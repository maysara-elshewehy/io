// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std       = @import("std");
    const builtin   = @import("builtin");
    const types     = @import("./events.types.zig");
    const win       = std.os.windows;
    const DWORD     = win.DWORD;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Windows implementation for enabling raw mode and detecting key presses.
    ///
    /// We use windows ReadConsoleInputW to get key events and parse them into Key.
    pub inline fn enableRawMode() !types.Key {
        // Get input handle
        const input_handle = win.kernel32.GetStdHandle(win.STD_INPUT_HANDLE);
        if (input_handle == win.INVALID_HANDLE_VALUE)
            return error.InvalidHandle;

        // Get console
        var old_settings: DWORD = undefined;
        if (win.kernel32.GetConsoleMode(input_handle.?, &old_settings) == 0)
            return error.FailedToGetConsoleMode;

        // Reset console
        defer _ = win.kernel32.SetConsoleMode(input_handle.?, old_settings);

        // Set new console
        var new_settings = old_settings & ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT);
        new_settings |= ENABLE_EXTENDED_FLAGS | ENABLE_PROCESSED_INPUT;
        if (win.kernel32.SetConsoleMode(input_handle.?, new_settings) == 0)
            return error.FailedToSetConsoleMode;

        // Read console input
        var input_record: INPUT_RECORD = undefined;
        var events_read: DWORD = undefined;
        while (true) {
            if (ReadConsoleInputW(input_handle.?, &input_record, 1, &events_read) == 0) {
                return error.FailedToReadConsoleInput;
            }

            if (input_record.EventType == KEY_EVENT) {
                if (input_record.Event.KeyEvent.bKeyDown != 0) {
                    // Parsing input.
                    return parseKeyEventRecord(input_record.Event.KeyEvent);
                }
            }
        }
    }

    /// -
    inline fn parseKeyEventRecord(event: KEY_EVENT_RECORD) types.Key {
        var key = types.Key {
            .m_val = @intCast(event.wVirtualKeyCode),
            .m_mod = 0,
            .m_state = types.Key.State.None,
            .m_arrow = types.Key.Arrow.None,
        };

        // Modifiers detection
        {
            if (event.dwControlKeyState & LEFT_ALT_PRESSED  != 0 or
                event.dwControlKeyState & RIGHT_ALT_PRESSED != 0)
            { key.m_mod |= 1 << 0; }

            if (event.dwControlKeyState & SHIFT_PRESSED != 0)
            { key.m_mod |= 1 << 1; }

            if (event.dwControlKeyState & LEFT_CTRL_PRESSED  != 0 or
                event.dwControlKeyState & RIGHT_CTRL_PRESSED != 0)
            { key.m_mod |= 1 << 2; }
        }

        // Arrows detection
        key.m_arrow = switch (event.wVirtualKeyCode) {
            VK_UP       => types.Key.Arrow.Up,
            VK_DOWN     => types.Key.Arrow.Down,
            VK_RIGHT    => types.Key.Arrow.Right,
            VK_LEFT     => types.Key.Arrow.Left,
            else        => types.Key.Arrow.None,
        };

        return key;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    // Define missing Windows console mode flags and constants
    const ENABLE_ECHO_INPUT         : DWORD = 0x0004;
    const ENABLE_PROCESSED_INPUT    : DWORD = 0x0001;
    const ENABLE_LINE_INPUT         : DWORD = 0x0002;
    const ENABLE_EXTENDED_FLAGS     : DWORD = 0x0080;
    const LEFT_ALT_PRESSED          : DWORD = 0x0002;
    const RIGHT_ALT_PRESSED         : DWORD = 0x0001;
    const LEFT_CTRL_PRESSED         : DWORD = 0x0008;
    const RIGHT_CTRL_PRESSED        : DWORD = 0x0004;
    const SHIFT_PRESSED             : DWORD = 0x0010;
    const NUMLOCK_ON                : DWORD = 0x0020;
    const SCROLLLOCK_ON             : DWORD = 0x0040;
    const CAPSLOCK_ON               : DWORD = 0x0080;
    const ENHANCED_KEY              : DWORD = 0x0100;
    const VK_UP                     : DWORD = 0x26;
    const VK_DOWN                   : DWORD = 0x28;
    const VK_LEFT                   : DWORD = 0x25;
    const VK_RIGHT                  : DWORD = 0x27;
    const KEY_EVENT                 : win.WORD = 0x0001;

    // Define missing key event record
    const KEY_EVENT_RECORD = extern struct {
        bKeyDown: win.BOOL,
        wRepeatCount: win.WORD,
        wVirtualKeyCode: win.WORD,
        wVirtualScanCode: win.WORD,
        uChar: extern union {
            UnicodeChar: win.WCHAR,
            AsciiChar: u8,
        },
        dwControlKeyState: DWORD,
    };

    // Define missing INPUT_RECORD structure
    const INPUT_RECORD = extern struct {
        EventType: win.WORD,
        Event: extern union {
            KeyEvent: KEY_EVENT_RECORD,
        },
    };

    // Declare ReadConsoleInputW function
    extern "kernel32" fn ReadConsoleInputW(
        hConsoleInput: win.HANDLE,
        lpBuffer: *INPUT_RECORD,
        nLength: DWORD,
        lpNumberOfEventsRead: *DWORD
    ) callconv(win.WINAPI) win.BOOL;

// ╚══════════════════════════════════════════════════════════════════════════════════╝