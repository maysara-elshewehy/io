// This is a min version of https://github.com/Super-ZIG/io library.
// I created this file to use this library without the need to install it via Zig. 
// Simply drag this single file into your project and import it.
//
// Made with ❤️ by Maysara.
//
// Email    : Maysara.Elshewehy@gmail.com
// GitHub   : https://github.com/maysara-elshewehy


const std = @import("std");
const builtin = @import("builtin");

/// Global buffer for General purposes.
var g_buff_1024:[1024]u8 = undefined;

/// Outputs a simple message followed by a newline.
pub inline fn out ( comptime _msg: []const u8 ) !void { 
    try outWith(_msg ++ "\n", .{}); }

/// Outputs a formatted message to the console.
pub inline fn outWith ( comptime _fmt: []const u8, _args: anytype ) !void { 
    try nosuspend std.io.getStdOut().writer().print(_fmt, _args); }

/// Outputs a simple message followed by a newline to a specific writer.
pub inline fn outWriter ( comptime _msg: []const u8, _writer: anytype ) !void {
    try _writer.print("{s}", .{_msg}); }

/// Outputs a formatted message followed by a newline to a specific writer.
pub inline fn outWriterWith ( comptime _fmt: []const u8, _args: anytype, _writer: anytype ) !void {
    try _writer.print(_fmt, _args); }

/// Reads input from the user until a newline character is encountered.
pub inline fn in () ![]const u8 {
    const l_res = try std.io.getStdIn().reader().readUntilDelimiterOrEof(&g_buff_1024, '\n');
    return l_res orelse unreachable; }

/// Reads input from the user until a newline character is encountered using custom buffer.
pub inline fn inBuff ( _buff: []u8 ) !void {
    for (_buff) |*l_byte| { l_byte.* = 0; }
    _ = try std.io.getStdIn().reader().readUntilDelimiterOrEof(_buff, '\n'); }

/// Displays a message and waits for the user to respond.
pub inline fn ask ( comptime _msg: []const u8 ) ![]const u8 {
    try out (_msg); return try  in  (); }

/// Displays a message and waits for the user to respond using custom buffer.
pub inline fn askBuff ( comptime _msg: []const u8, _buff: []u8 ) !void { 
    try out (_msg); try inBuff  (_buff); }

/// Listens for key input.
pub inline fn once ( _call: anytype ) !void {
    if (builtin.os.tag == .windows) {
        return __WIN_API__.once(_call);
    } else if (builtin.os.tag == .linux) { 
        return __LIN_API__.once(_call);
    } else { 
        try outWith("OS not supported : {}\n", .{builtin.os.tag}); unreachable; } }

/// Listens for key input until the condition is met.
pub inline fn on ( _cond: anytype, _call: anytype ) !void {
    if (builtin.os.tag == .windows) {
        return __WIN_API__.on(_cond, _call);
    } else if (builtin.os.tag == .linux) {
        return __LIN_API__.on(_cond, _call);
    } else {
        try outWith("OS not supported : {}\n", .{builtin.os.tag}); unreachable; } }

/// Clears the terminal(Screen).
pub inline fn cls () !void {
    _ = try out("\x1b[2J\x1b[H"); }

/// Alias for io library types.
pub const types = struct {
    // Struct to represent key press details.
    pub const key = struct {
        /// Press state.
        pub const State = enum { None, SinglePress, DoublePress, };

        m_val   : u8    = 0,            // key code
        m_mod   : u3    = 0,            // modifier keys (ctrl, alt, shift)
        m_state : State = State.None,   // press state 


        /// Returns the press state.
        pub inline fn state (_self: *const key) State {
            if(_self.m_state == State.None)
            {
                const isSinglePress = _self.m_mod == 0;

                if (isSinglePress)  { _self.m_state = State.SinglePress; }
                else                { _self.m_state = State.DoublePress; }
            }

            return _self.m_state;
        }

        /// Returns the key code.
        pub inline fn code(_self: *const key) u8 {
            return _self.m_val;
        }

        /// Returns a character representation of the key.
        pub inline fn char(_self: *const key) u8 {
            return switch (_self.m_mod) {
                4    => { return '@' + _self.m_val; }, // ctrl 
                5    => { return '@' + _self.m_val; }, // alt + ctrl 
                else => { return       _self.m_val; }, // others
            };
        }

        /// Returns a string representation of the modifiers.
        pub inline fn mod(_self: *const key) [] const u8 {
            return switch (_self.m_mod) {
                0    => "none",
                1    => "alt",
                2    => "shift",
                3    => "alt + shift",
                4    => "ctrl",
                5    => "alt + ctrl",
                else => "unknown",
            };
        }

        /// Returns true if the Alt modifier key was pressed.
        pub inline fn alt (_self: *const key) bool {
            return (_self.m_mod & 1 << 0) != 0;
        }

        /// Returns true if the Ctrl modifier key was pressed.
        pub inline fn ctrl (_self: *const key) bool {
            return (_self.m_mod & 1 << 2) != 0;
        }

        // Returns true if the Shift modifier key was pressed.
        pub inline fn  shift(_self: *const key) bool {
            return (_self.m_mod & 1 << 1) != 0;
        }

        /// Returns count of pressed keys.
        pub inline fn count (_self: *const key) u8 {
            var m_count : u8 = 1;

            if (_self.alt())     m_count += 1;
            if (_self.ctrl())    m_count += 1;
            if (_self.shift())   m_count += 1;

            return m_count;
        }
    };
};

/// Windows ONLY
const __WIN_API__ = if (builtin.os.tag == .windows) struct {
    const windowsH = @cImport({
        @cInclude("windows.h");
    });

    /// Alias for key press state enumeration.
    const g_State = types.key.State;     

    // Virtual key codes for common keys
    const VK_LSHIFT     = 0xA0;
    const VK_RSHIFT     = 0xA1;
    const VK_LCONTROL   = 0xA2;
    const VK_RCONTROL   = 0xA3;
    const VK_LMENU      = 0xA4;
    const VK_RMENU      = 0xA5;

    // Maximum allowed delay between key presses to be considered as double press
    const MAX_KEYPRESS_DELAY : f64  = 1.0;

    /// Listen for a single key press and invoke the provided callback function
    pub inline fn once ( _call: anytype ) !void {
        try Logic.Core( _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE) ); }
    
    /// Listen for key input until the specified condition is met and invoke the callback function
    pub inline fn on ( _cond: anytype, _call: anytype ) !void {
        try loop.untilWith( _cond, Logic.Core, .{ _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE) } ); }

    const Logic = struct
    {
        var g_lastKeyTime   : f64       = 0.0;          // Stores the timestamp of the last key press
        var g_lastKey       : u8        = 0;            // Stores the last pressed key
        var g_state         : g_State   = g_State.None; // Stores the current key press state (SinglePress/DoublePress)

        /// Core function to handle key input and invoke the callback function
        inline fn Core
        ( _call: anytype, _hConsole: anytype )
        !void
        {
            var l_bytesRead : u32 = 0;
            var l_inputRecord : windowsH.INPUT_RECORD = undefined;
            
            while(true)
            {
                // Read the console input event (key press)
                _ = windowsH.ReadConsoleInputA(_hConsole, &l_inputRecord, 1, &l_bytesRead);

                if (l_inputRecord.EventType == windowsH.KEY_EVENT and l_inputRecord.Event.KeyEvent.bKeyDown != 0)
                {
                    const l_key         = l_inputRecord.Event.KeyEvent.uChar.AsciiChar;
                    const l_currentTime = @as(f64, @floatFromInt(std.time.timestamp()));

                    // Check the time between the current and last key press
                    if (l_currentTime - g_lastKeyTime <= MAX_KEYPRESS_DELAY)
                    {
                        // If the time between presses is less than the allowed threshold, treat as double press
                        g_state = g_State.DoublePress;
                    }
                    else
                    {
                        // Otherwise, treat as single press
                        g_state = g_State.SinglePress;
                    }

                    g_lastKeyTime = l_currentTime;  // Update the timestamp of the last key press
                    g_lastKey = l_key;              // Update the last pressed key

                    const l_modifiers = Help.detectMods(); // Detect the modifier keys (Shift, Ctrl, Alt)
                    
                    // If the key pressed is 0 (no valid key), ignore
                    if (l_key == 0)
                    {
                        return;
                    }

                    // Create a key object with the key value, modifiers, and key press state
                    const l_res         = types.key
                    {
                        .m_val          = Help.getKeyValue(l_key),
                        .m_mod          = l_modifiers,
                        .m_state        = g_state,
                    };

                    // Call the provided callback function with the key object
                    try _call(l_res);

                    break;
                }
            }
        }

        const Help = struct
        {
            /// Get the current state of a key based on its virtual key code
            inline fn checkKeyState ( _keyCode: i32 ) i32
            {
                return windowsH.GetKeyState(_keyCode); // Return the key state (pressed or not)
            }

            /// Detect the state of modifier keys (Shift, Ctrl, Alt)
            inline fn detectMods () u3
            {
                var l_modifiers : u3 = 0;

                // Check if Shift key (either left or right) is pressed
                if (checkKeyState(windowsH.VK_LSHIFT) & 0x8000 != 0 or checkKeyState(windowsH.VK_RSHIFT) & 0x8000 != 0)
                {
                    l_modifiers |= 1 << 1;      // Set the Shift modifier
                }

                // Check if Ctrl key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LCONTROL) & 0x8000 != 0 or checkKeyState(windowsH.VK_RCONTROL) & 0x8000 != 0)
                {
                    if (g_lastKey != 0)
                    {
                        l_modifiers |= 1 << 2;  // Set the Ctrl modifier
                    }
                }

                // Check if Alt key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LMENU) & 0x8000 != 0 or checkKeyState(windowsH.VK_RMENU) & 0x8000 != 0)
                {
                    if (g_lastKey != 0)
                    {
                        l_modifiers |= 1 << 0;  // Set the Alt modifier
                    }
                }

                return l_modifiers; // Return the detected modifiers
            }

            inline fn getKeyValue(key: u8) u8
            { 
                return key;
            }
        };
    };
} else null;

/// Linux ONLY
const __LIN_API__ = if (builtin.os.tag == .linux) struct {
    const linuxH = @cImport({
        @cInclude("termios.h"); // Termios library for terminal I/O settings
        @cInclude("unistd.h");  // POSIX operating system API (e.g., read, tcsetattr)
    });

    // variables to hold the old/new terminal settings
    var g_oldSettings : linuxH.struct_termios = undefined;
    var g_newSettings : linuxH.termios        = undefined;

    // variables to hold the key input
    var g_keyBuffer : [3]u8 = undefined;
    var g_bytesRead : isize = undefined;

    /// Listen for key input
    pub inline fn once ( _call: anytype ) !void {
        try Logic.Core( _call ); }

    /// Listen for key input until the condition is met
    pub inline fn on ( _cond: anytype, _call: anytype ) !void {
        try loop.untilWith( _cond, Logic.Core, .{ _call } ); }

    const Logic = struct
    {
        /// The entry point of our logic !
        inline fn Core ( _call: anytype ) !void 
        {
            Help.init();
            defer Help.reset();

            // Read key input
            g_bytesRead = linuxH.read(0, &g_keyBuffer, @sizeOf(@TypeOf(g_keyBuffer)));

            if (g_bytesRead > 0) 
            { 
                const l_res: types.key = Help.detectMods(g_keyBuffer[0..], g_bytesRead);
                try _call(l_res);
            } 
            else 
            {
                unreachable; 
            }
        }

        const Help = struct 
        {
            /// Restore old terminal settings to prevent permanent changes.
            inline fn reset () void 
            {
                _ = linuxH.tcsetattr(0, linuxH.TCSAFLUSH, &g_oldSettings);
            }

            /// Setup the new terminal settings.
            inline fn init () void 
            {
                // Cleanup the buffer
                g_keyBuffer[0..].* = @as([3]u8, std.mem.zeroes([3]u8));

                // Get current terminal settings and store in 'oldSettings'
                _ = linuxH.tcgetattr(0, &g_oldSettings);

                // Copy the current settings to 'newSettings'
                g_newSettings = g_oldSettings;

                // Disable canonical mode (no buffering, no waiting for Enter key to submit input)
                g_newSettings.c_lflag &= @as(c_uint, ~@as(c_uint, linuxH.ICANON)); // Clear the ICANON flag to disable canonical mode

                // Disable echoing characters (input characters will not be displayed on the terminal)
                g_newSettings.c_lflag &= @as(c_uint, ~@as(c_uint, linuxH.ECHO)); // Clear the ECHO flag to disable character echoing

                // Set minimum number of characters to 1 (we don’t need to wait for Enter key)
                g_newSettings.c_cc[linuxH.VMIN] = 1; // Set the VMIN control character to 1 to require at least 1 character

                // Set timeout to 0 (no wait time for input)
                g_newSettings.c_cc[linuxH.VTIME] = 0; // Set the VTIME control character to 0 to disable wait time

                // Set the new terminal settings
                // Reset to avoid needing to press enter and to hide the user input in the terminal !
                if (linuxH.tcsetattr(0, linuxH.TCSAFLUSH, &g_newSettings) != 0)
                {
                    Help.reset(); 
                } 
            }

            // Function to detect modifier keys (Ctrl, Alt, Shift)
            inline fn detectMods ( _keyBuffer: []const u8, _bytesRead: isize ) types.key
            {
                var l_res = types.key
                {
                    .m_val  = 0,
                    .m_mod  = 0,
                    .m_state = types.key.State.None };

                if (_bytesRead == 0) { return l_res; }

                // Alt key detection
                if (_keyBuffer[0] == 0x1B)
                {
                    l_res.m_mod |= 1 << 0;

                    if (_bytesRead > 1)
                    {
                        l_res.m_val = _keyBuffer[1];
                        if (std.ascii.isUpper(_keyBuffer[1])) { l_res.m_mod |= 1 << 1; }
                        if (_keyBuffer[1] >= 0x00 and _keyBuffer[1] <= 0x1F) { l_res.m_mod |= 1 << 2; }
                    }

                    return l_res;
                }

                // Ctrl key detection
                if (_keyBuffer[0] >= 0x00 and _keyBuffer[0] <= 0x1F)
                {
                    l_res.m_mod |= 1 << 2;
                    l_res.m_val = _keyBuffer[0];

                    return l_res;
                }

                // Shift detection
                if (std.ascii.isUpper(_keyBuffer[0])) { l_res.m_mod |= 1 << 1; }

                l_res.m_val = getKeyValue(_keyBuffer[0]);

                return l_res;
            }  

            inline fn getKeyValue(key: u8) u8 
            {
                return key;
            }
        };
    };
} else null;


/// @ref https://github.com/Super-ZIG/io/blob/main/dist/loop.min.zig
const loop = struct {
    pub inline fn untilWith ( _cond: anytype, _call: anytype, _args: anytype ) !void {
        while (true) {
            try @call(.auto, _call, _args);
            if (!try _cond()) break; } }
};