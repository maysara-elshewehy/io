// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const   std                     = @import("std");
    const   loop                    = @import("../../libs/loop.zig");
    const   types                   = @import("../../types/_.zig");

    const   windowsH                = @cImport
    ({
        @cInclude("windows.h");                             // Windows API definitions for handling keyboard input and system events.
    });

    const g_State                   = types.key.State;      // Alias for key press state enumeration.

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ DATA ══════════════════════════════════════╗

    // Virtual key codes for common keys
    const VK_LSHIFT                 = 0xA0;
    const VK_RSHIFT                 = 0xA1;
    const VK_LCONTROL               = 0xA2;
    const VK_RCONTROL               = 0xA3;
    const VK_LMENU                  = 0xA4;
    const VK_RMENU                  = 0xA5;

    // Flags representing modifier key states (Ctrl, Shift, Alt)
    const LEFT_CTRL_PRESSED         = 0x0008;
    const RIGHT_CTRL_PRESSED        = 0x0004;
    const LEFT_SHIFT_PRESSED        = 0x0010;
    const RIGHT_SHIFT_PRESSED       = 0x0020;
    const LEFT_ALT_PRESSED          = 0x0002;
    const RIGHT_ALT_PRESSED         = 0x0001;

    // Maximum allowed delay between key presses to be considered as double press
    const MAX_KEYPRESS_DELAY : f64  = 1.0;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Listen for a single key press and invoke the provided callback function
    pub inline fn once
    ( _call: anytype ) 
    !void
    {
        try Logic.Core( _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE) );
    }
    
    /// Listen for key input until the specified condition is met and invoke the callback function
    pub inline fn on
    ( _cond: anytype, _call: anytype ) 
    !void
    {
        try loop.untilWith( _cond, Logic.Core, .{ _call, windowsH.GetStdHandle(windowsH.STD_INPUT_HANDLE) } );
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ LOGIC ═════════════════════════════════════╗

    const Logic = struct
    {
        var g_lastKeyTime   : f64       = 0.0;              // Stores the timestamp of the last key press
        var g_lastKey       : u8        = 0;                // Stores the last pressed key
        var g_state         : g_State   = g_State.None;     // Stores the current key press state (SinglePress/DoublePress)

        /// Core function to handle key input and invoke the callback function
        inline fn Core
        ( _call: anytype, _hConsole: anytype )
        !void
        {
            var l_inputRecord   : windowsH.INPUT_RECORD     = undefined;
            var l_bytesRead     : u32                       = 0;
            
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
                        g_state         = g_State.DoublePress;
                    }
                    else
                    {
                        // Otherwise, treat as single press
                        g_state         = g_State.SinglePress;
                    }

                    g_lastKeyTime       = l_currentTime;        // Update the timestamp of the last key press
                    g_lastKey           = l_key;                // Update the last pressed key

                    const l_modifiers   = Help.detectMods();    // Detect the modifier keys (Shift, Ctrl, Alt)
                    
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
            
            /// Detect the state of modifier keys (Shift, Ctrl, Alt)
            inline fn 
            detectMods
            ( ) 
            u3
            {
                var l_modifiers : u3 = 0;

                // Check if Shift key (either left or right) is pressed
                if (checkKeyState(windowsH.VK_LSHIFT) & 0x8000 != 0 or checkKeyState(windowsH.VK_RSHIFT) & 0x8000 != 0)
                {
                    l_modifiers |= 1 << 1;                  // Set the Shift modifier
                }

                // Check if Ctrl key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LCONTROL) & 0x8000 != 0 or checkKeyState(windowsH.VK_RCONTROL) & 0x8000 != 0)
                {
                    if (g_lastKey != 0)
                    {
                        l_modifiers |= 1 << 2;              // Set the Ctrl modifier
                    }
                }

                // Check if Alt key (either left or right) is pressed and there's a valid key press
                if (checkKeyState(windowsH.VK_LMENU) & 0x8000 != 0 or checkKeyState(windowsH.VK_RMENU) & 0x8000 != 0)
                {
                    if (g_lastKey != 0)
                    {
                        l_modifiers |= 1 << 0;              // Set the Alt modifier
                    }
                }

                return l_modifiers;                         // Return the detected modifiers
            }

            /// Get the current state of a key based on its virtual key code
            inline fn 
            checkKeyState
            ( _keyCode: i32 ) 
            i32
            {
                return windowsH.GetKeyState(_keyCode);      // Return the key state (pressed or not)
            }
        };
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝