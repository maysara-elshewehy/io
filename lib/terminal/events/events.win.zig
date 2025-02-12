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
    const Types     = @import("./events.types.zig");
    const win       = std.os.windows;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // Define missing Windows console mode flags
    const ENABLE_ECHO_INPUT : u32 = 0x0004;
    const ENABLE_PROCESSED_INPUT : u32 = 0x0001;
    const ENABLE_LINE_INPUT : u32 = 0x0002;
    const ENABLE_EXTENDED_FLAGS : u32 = 0x0080;
    const LEFT_ALT_PRESSED : u32 = 0x0002;
    const RIGHT_ALT_PRESSED : u32 = 0x0001;
    const LEFT_CTRL_PRESSED : u32 = 0x0008;
    const RIGHT_CTRL_PRESSED : u32 = 0x0004;
    const SHIFT_PRESSED : u32 = 0x0010;
    const NUMLOCK_ON : u32 = 0x0020;
    const SCROLLLOCK_ON : u32 = 0x0040;
    const CAPSLOCK_ON : u32 = 0x0080;
    const ENHANCED_KEY : u32 = 0x0100;
    const VK_UP : u32 = 0x26;
    const VK_DOWN : u32 = 0x28;
    const VK_LEFT : u32 = 0x25;
    const VK_RIGHT : u32 = 0x27;

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
        dwControlKeyState: win.DWORD,
    };

    // Define missing INPUT_RECORD structure
    const INPUT_RECORD = extern struct {
        EventType: win.WORD,
        Event: extern union {
            KeyEvent: KEY_EVENT_RECORD,
        },
    };

    // Define missing KEY_EVENT constant
    const KEY_EVENT: win.WORD = 0x0001;

    // Declare ReadConsoleInputW function
    extern "kernel32" fn ReadConsoleInputW(
        hConsoleInput: win.HANDLE,
        lpBuffer: *INPUT_RECORD,
        nLength: win.DWORD,
        lpNumberOfEventsRead: *win.DWORD
    ) callconv(win.WINAPI) win.BOOL;

    // Windows implementation for listening to a single key press
    pub inline fn listen() !Types.Key {
        const input_handle = win.kernel32.GetStdHandle(win.STD_INPUT_HANDLE);
        if (input_handle == win.INVALID_HANDLE_VALUE) return error.InvalidHandle;

        var original_mode: win.DWORD = undefined;
        if (win.kernel32.GetConsoleMode(input_handle.?, &original_mode) == 0) {
            return error.FailedToGetConsoleMode;
        }
        defer _ = win.kernel32.SetConsoleMode(input_handle.?, original_mode);

        var new_mode = original_mode & ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT);
        new_mode |= ENABLE_EXTENDED_FLAGS | ENABLE_PROCESSED_INPUT;

        if (win.kernel32.SetConsoleMode(input_handle.?, new_mode) == 0) {
            return error.FailedToSetConsoleMode;
        }

        var input_record: INPUT_RECORD = undefined;
        var events_read: win.DWORD = undefined;
        while (true) {
            if (ReadConsoleInputW(input_handle.?, &input_record, 1, &events_read) == 0) {
                return error.FailedToReadConsoleInput;
            }

            if (input_record.EventType == KEY_EVENT) {
                if (input_record.Event.KeyEvent.bKeyDown != 0) {
                    return detectKey(input_record.Event.KeyEvent);
                }
            }
        }
    }

    inline fn detectKey(event: KEY_EVENT_RECORD) Types.Key {
        var res = Types.Key {
            .m_val = 0,
            .m_mod = 0,
            .m_state = Types.Key.State.None,
            .m_arrow = Types.Key.Arrow.None,
        };

        res.m_val = @intCast(event.wVirtualKeyCode);

        if (event.dwControlKeyState & LEFT_ALT_PRESSED != 0 or
            event.dwControlKeyState & RIGHT_ALT_PRESSED != 0)
        {
            res.m_mod |= 1 << 0;
        }

        if (event.dwControlKeyState & SHIFT_PRESSED != 0) {
            res.m_mod |= 1 << 1;
        }

        if (event.dwControlKeyState & LEFT_CTRL_PRESSED != 0 or
            event.dwControlKeyState & RIGHT_CTRL_PRESSED != 0)
        {
            res.m_mod |= 1 << 2;
        }

        res.m_arrow = switch (event.wVirtualKeyCode) {
            VK_UP => Types.Key.Arrow.Up,
            VK_DOWN => Types.Key.Arrow.Down,
            VK_RIGHT => Types.Key.Arrow.Right,
            VK_LEFT => Types.Key.Arrow.Left,
            else => Types.Key.Arrow.None,
        };

        return res;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝