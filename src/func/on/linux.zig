// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const   std                     = @import("std");
    const   loop                    = @import("../../libs/loop.zig");
    const   types                   = @import("../../types/_.zig");

    const   linuxH                  = @cImport
    ({
        @cInclude("termios.h");                             // Termios library for terminal I/O settings
        @cInclude("unistd.h");                              // POSIX operating system API (e.g., read, tcsetattr)
    });

    const   g_ts                    = linuxH.termios;
    const   g_tS                    = linuxH.struct_termios;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ DATA ══════════════════════════════════════╗

    // variables to hold the old/new terminal settings
    var     g_oldSettings : g_tS    = undefined;
    var     g_newSettings : g_ts    = undefined;

    // variables to hold the key input
    var     g_keyBuffer   : [3]u8   = undefined;
    var     g_bytesRead   : isize   = undefined;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Listen for key input
    pub inline fn once
    ( _call: anytype ) 
    !void
    {
        try Logic.Core( _call );
    }

    /// Listen for key input until the condition is met
    pub inline fn on
    ( _cond: anytype, _call: anytype ) 
    !void
    {
        try loop.untilWith( _cond, Logic.Core, .{ _call } );
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ LOGIC ═════════════════════════════════════╗

    const Logic = struct
    {
        /// The entry point of our logic !
        inline fn Core
        ( _call: anytype )
        !void
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
                // try _call(types.key{ .key = 0, .character = 0, .modifiers = 0, });
                unreachable;
            }
        }

        const Help = struct
        {
            /// Restore old terminal settings to prevent permanent changes.
            inline fn reset
            ()
            void
            {
                _ = linuxH.tcsetattr(0, linuxH.TCSAFLUSH, &g_oldSettings);
            }

            /// Setup the new terminal settings.
            inline fn init
            ()
            void
            {
                // Cleanup the buffer
                g_keyBuffer[0..].* = @as([3]u8, std.mem.zeroes([3]u8));

                // Get current terminal settings and store in 'oldSettings'
                _ = linuxH.tcgetattr(0, &g_oldSettings);

                // Copy the current settings to 'newSettings'
                g_newSettings = g_oldSettings;


                // Disable canonical mode (no buffering, no waiting for Enter key to submit input)
                g_newSettings.c_lflag &= @as(c_uint, ~@as(c_uint, linuxH.ICANON));  // Clear the ICANON flag to disable canonical mode


                // Disable echoing characters (input characters will not be displayed on the terminal)
                g_newSettings.c_lflag &= @as(c_uint, ~@as(c_uint, linuxH.ECHO));    // Clear the ECHO flag to disable character echoing


                // Set minimum number of characters to 1 (we don’t need to wait for Enter key)
                g_newSettings.c_cc[linuxH.VMIN] = 1;                                // Set the VMIN control character to 1 to require at least 1 character


                // Set timeout to 0 (no wait time for input)
                g_newSettings.c_cc[linuxH.VTIME] = 0;                               // Set the VTIME control character to 0 to disable wait time

                // Set the new terminal settings
                if (linuxH.tcsetattr(0, linuxH.TCSAFLUSH, &g_newSettings) != 0)
                {
                    // Reset to avoid needing to press enter and to hide the user input in the terminal !
                    Help.reset();
                } 
            }

            // Function to detect modifier keys (Ctrl, Alt, Shift)
            inline fn detectMods
            ( _keyBuffer: []const u8, _bytesRead: isize )
            types.key
            {
                var l_res = types.key
                {
                    .m_val      = 0,
                    .m_mod      = 0,
                    .m_state    = types.key.State.None
                };

                if (_bytesRead == 0)
                {
                    return l_res;
                }

                // Alt key detection
                if (_keyBuffer[0] == 0x1B)
                {
                    l_res.m_mod |= types.MOD_ALT;

                    if (_bytesRead > 1) {
                        l_res.m_val = _keyBuffer[1];

                        if (std.ascii.isUpper(_keyBuffer[1]))
                        {
                            l_res.m_mod |= types.MOD_SHIFT;
                        }

                        if (_keyBuffer[1] >= 0x00 and _keyBuffer[1] <= 0x1F)
                        {
                            l_res.m_mod |= types.MOD_CTRL;
                        }
                    }

                    return l_res;
                }

                // Ctrl key detection
                if (_keyBuffer[0] >= 0x00 and _keyBuffer[0] <= 0x1F)
                {
                    l_res.m_mod |= types.MOD_CTRL;
                    l_res.m_val = _keyBuffer[0];

                    return l_res;
                }

                // Shift detection
                if (std.ascii.isUpper(_keyBuffer[0]))
                {
                    l_res.m_mod |= types.MOD_SHIFT;
                }

                l_res.m_val = getKeyValue(_keyBuffer[0]);

                return l_res;
            }  

            inline fn
            getKeyValue(key: u8) u8
            {
                return key;

                // // Printable character
                // if (std.ascii.isPrint(key))
                // {
                //     return key;
                // }

                // // Handle non-printable key
                // else
                // {
                //     return key;
                // }
            }
        };
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝
