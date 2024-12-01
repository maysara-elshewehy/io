// ╔══════════════════════════════════════ FILE ══════════════════════════════════════╗

    const std = @import("std");
    const loop = @import("../../libs/loop.zig");
    const types = @import("../../types/all.zig");
    const windowsH = @cImport({
        @cInclude("windows.h"); // Windows API definitions for handling keyboard input and system events.
    });

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// Alias for key press state enumeration.
    const g_State = types.key.State;     

    // Virtual key codes for common keys
    const VK_LSHIFT     = 0xA0;
    const VK_RSHIFT     = 0xA1;
    const VK_LCONTROL   = 0xA2;
    const VK_RCONTROL   = 0xA3;
    const VK_LMENU      = 0xA4;
    const VK_RMENU      = 0xA5;
    const VK_UP         = 0x26;
    const VK_DOWN       = 0x28;
    const VK_LEFT       = 0x25;
    const VK_RIGHT      = 0x27;

    // Maximum allowed delay between key presses to be considered as double press
    const MAX_KEYPRESS_DELAY : f64  = 1.0;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Listen for a single key press and invoke the provided callback function
    pub inline fn once ( _call: anytype, _args: anytype ) !void {
        try Logic.Core( _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE), _args ); }
    
    /// Listen for key input until the specified condition is met and invoke the callback function
    pub inline fn on ( _cond: anytype, _condArgs: anytype, _call: anytype, _callArgs: anytype ) !void {
        try loop.untilWith( _cond, _condArgs, Logic.Core, .{ _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE), _callArgs } ); }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ LOGIC ═════════════════════════════════════╗

    const Logic = struct {
        var g_lastKeyTime   : f64       = 0.0;          // Stores the timestamp of the last key press
        var g_lastKey       : u8        = 0;            // Stores the last pressed key
        var g_state         : g_State   = g_State.None; // Stores the current key press state (SinglePress/DoublePress)

        /// Core function to handle key input and invoke the callback function
        inline fn Core( _call: anytype, _hConsole: anytype, _args: anytype ) !void {
            var l_bytesRead : u32 = 0;
            var l_inputRecord : windowsH.INPUT_RECORD = undefined;
            
            while(true) {
                // Read the console input event (key press)
                _ = windowsH.ReadConsoleInputA(_hConsole, &l_inputRecord, 1, &l_bytesRead);

                if (l_inputRecord.EventType == windowsH.KEY_EVENT and l_inputRecord.Event.KeyEvent.bKeyDown != 0) {
                    const l_key         = l_inputRecord.Event.KeyEvent.uChar.AsciiChar;
                    const l_currentTime = @as(f64, @floatFromInt(std.time.timestamp()));
                    const l_virtualKey  = l_inputRecord.Event.KeyEvent.wVirtualKeyCode;

                    // Check the time between the current and last key press
                    if (l_currentTime - g_lastKeyTime <= MAX_KEYPRESS_DELAY) {
                        // If the time between presses is less than the allowed threshold, treat as double press
                        g_state = g_State.DoublePress;
                    } else {
                        // Otherwise, treat as single press
                        g_state = g_State.SinglePress;
                    }

                    g_lastKeyTime = l_currentTime;  // Update the timestamp of the last key press
                    g_lastKey = l_key;              // Update the last pressed key

                    const l_modifiers = Help.detectMods(); // Detect the modifier keys (Shift, Ctrl, Alt)

                    // Get Arrows
                    var l_arrows : types.key.Arrow = undefined;

                    switch (l_virtualKey) {
                        VK_UP    => l_arrows = types.key.Arrow.Up,
                        VK_DOWN  => l_arrows = types.key.Arrow.Down,
                        VK_LEFT  => l_arrows = types.key.Arrow.Left,
                        VK_RIGHT => l_arrows = types.key.Arrow.Right,
                        else     => { 
                            if(l_key == 0) { return; }
                            else { l_arrows = types.key.Arrow.None; }
                        },
                    }

                    // Create a key object with the key value, modifiers, and key press state
                    const l_res         = types.key {
                        .m_val          = Help.getKeyValue(l_key),
                        .m_mod          = l_modifiers,
                        .m_state        = g_state,
                        .m_arrow        = l_arrows
                    };

                    // Call the provided callback function with the key object
                    try _call(l_res, _args);

                    break;
                }
            }
        }

        const Help = struct {
            /// Get the current state of a key based on its virtual key code
            inline fn checkKeyState( _keyCode: i32 ) i32 {
                return windowsH.GetKeyState(_keyCode); // Return the key state (pressed or not)
            }

            /// Detect the state of modifier keys (Shift, Ctrl, Alt)
            inline fn detectMods() u3 {
                var l_modifiers : u3 = 0;

                // Check if Shift key (either left or right) is pressed
                if (checkKeyState(windowsH.VK_LSHIFT) & 0x8000 != 0 or checkKeyState(windowsH.VK_RSHIFT) & 0x8000 != 0) {
                    l_modifiers |= 1 << 1;                  // Set the Shift modifier
                }

                // Check if Ctrl key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LCONTROL) & 0x8000 != 0 or checkKeyState(windowsH.VK_RCONTROL) & 0x8000 != 0) {
                    if (g_lastKey != 0) {
                        l_modifiers |= 1 << 2;              // Set the Ctrl modifier
                    }
                }

                // Check if Alt key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LMENU) & 0x8000 != 0 or checkKeyState(windowsH.VK_RMENU) & 0x8000 != 0) {
                    if (g_lastKey != 0) {
                        l_modifiers |= 1 << 0;              // Set the Alt modifier
                    }
                }

                return l_modifiers;                         // Return the detected modifiers
            }

            inline fn getKeyValue(key: u8) u8 { 
                return key;
            }
        };
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝