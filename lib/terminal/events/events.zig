// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const types         = @import("./events.types.zig");
    const settings      = @import("../settings/settings.zig");
    const Unicode       = @import("../../string/utils/unicode/unicode.zig");
    const Iterator      = @import("../../string/utils/unicode/unicode.zig").Iterator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const Event = types.Event;
    pub const ReadError = error { FailedToRead };
    pub const ListenError = ReadError || settings.GetOrSetSettingsError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Continuously listens for key presses until a condition is met.
    pub fn listenUntil(condition: fn (event: Event) bool) ListenError!void {
        // enable raw mode
        const original_terminal = try settings.enableRawMode();

        while (true) {
            const res = try crossReader(original_terminal);
            const event = parseBytesRead(res);
            if (condition(event)) break;
        }

        // disable raw mode
        try settings.disableRawMode(original_terminal);
    }

    /// like `listenUntil` but takes arguments.
    pub fn listenUntilWith(condition: fn (event: Event, args: anytype) bool, args: anytype) ListenError!void {
        // enable raw mode
        const original_terminal = try settings.enableRawMode();

        while (true) {
            const res = try crossReader(original_terminal);
            const event = parseBytesRead(res);
            if (condition(event, args)) break;
        }

        // disable raw mode
        try settings.disableRawMode(original_terminal);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Parse ══════════════════════════════════════╗

    /// -
    fn parseBytesRead(key_buffer: []const u8) types.Event {
        var event: types.Event = .{};

        if (key_buffer.len == 0) return event;

        // Keep the raw data in m_read
        event.key.m_read = key_buffer;

        var keyPart: []const u8 = "";

        // Handle simple keys (Enter, Tab, Backspace, Space)
        switch (key_buffer[0]) {

            '\x0A', '\x0D' => {
                event.key.m_mask |= types.Key.Bitmask.Enter;
                keyPart = key_buffer[0 .. 1];
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            },

            '\x09' => {
                event.key.m_mask |= types.Key.Bitmask.Tab;
                keyPart = key_buffer[0 .. 1];
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            },

            '\x7F' => {
                event.key.m_mask |= types.Key.Bitmask.Backspace;
                keyPart = key_buffer[0 .. 1];
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            },

            ' ' => {
                event.key.m_mask |= types.Key.Bitmask.Space;
                keyPart = key_buffer[0 .. 1];
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            },

            else => {}
        }

        if (key_buffer[0] == '\x1b') {

            if (key_buffer.len == 1) {
                event.key.m_mask |= types.Key.Bitmask.Escape;
                keyPart = key_buffer[0 .. 1];
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            }

            if (key_buffer[1] == '[') {
                return parseCsi(key_buffer[2..]);
            }

            else if (key_buffer[1] == 'O') {
                if (key_buffer.len >= 3) {
                    const finalChar = key_buffer[2];
                    switch (finalChar) {
                        'P' => { event.key.m_mask |= types.Key.Bitmask.F1; },
                        'Q' => { event.key.m_mask |= types.Key.Bitmask.F2; },
                        'R' => { event.key.m_mask |= types.Key.Bitmask.F3; },
                        'S' => { event.key.m_mask |= types.Key.Bitmask.F4; },
                        else => { event.key.m_mask |= types.Key.Bitmask.Unknown; },
                    }
                    return event;
                } else {
                    return event;
                }
            }

            else {
                // Alt-modified key: use the next character after ESC
                event.key.m_mask |= types.Key.Bitmask.Alt;
                if (key_buffer.len > 1) {
                    const c = key_buffer[1];
                    const lenToCopy = Unicode.getLengthOfStartByte(c) catch 1;
                    if (c < 0x20) {
                        // If it's a control character (e.g. 0x01), convert it
                        event.key.m_mask |= types.Key.Bitmask.Ctrl;
                        var buf: [2]u8 = [_]u8{0, 0};
                        buf[0] = c + '@';
                        keyPart = buf[0 .. 1];
                    } else {
                        keyPart = key_buffer[1 .. @min(1 + lenToCopy, key_buffer.len)];
                    }
                }
                @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
                return event;
            }
        }

        else {
            // Normal key:
            if (key_buffer[0] >= 0x00 and key_buffer[0] <= 0x1F) {
                // Ctrl only: convert the control code to the corresponding character
                event.key.m_mask |= types.Key.Bitmask.Ctrl;
                var buf: [2]u8 = [_]u8{0, 0};
                buf[0] = key_buffer[0] + '@';
                keyPart = buf[0 .. 1];
            } else {
                const lenToCopy = Unicode.getLengthOfStartByte(key_buffer[0]) catch 1;
                keyPart = key_buffer[0 .. @min(lenToCopy, key_buffer.len)];
            }
            @memcpy(event.key.m_key[0 .. keyPart.len], keyPart);
            return event;
        }
    }

    /// -
    fn parseCsi(buf: []const u8) types.Event {
        var event: types.Event = .{};
        var idx: usize = 0;
        var number: u32 = 0;

        while (idx < buf.len and std.ascii.isDigit(buf[idx])) {
            number = number * 10 + (buf[idx] - '0');
            idx += 1;
        }

        var modifier: u32 = 0;
        if (idx < buf.len and buf[idx] == ';') {
            idx += 1;
            while (idx < buf.len and std.ascii.isDigit(buf[idx])) {
                modifier = modifier * 10 + (buf[idx] - '0');
                idx += 1;
            }
        }

        if (idx >= buf.len) return event;
        const finalChar = buf[idx];

        switch (finalChar) {
            'A' => { event.key.m_mask |= types.Key.Bitmask.Up; },
            'B' => { event.key.m_mask |= types.Key.Bitmask.Down; },
            'C' => { event.key.m_mask |= types.Key.Bitmask.Right; },
            'D' => { event.key.m_mask |= types.Key.Bitmask.Left; },
            '~' => {
                switch (number) {
                    1, 7 => { event.key.m_mask |= types.Key.Bitmask.Home; },
                    4, 8 => { event.key.m_mask |= types.Key.Bitmask.End; },
                    2   => { event.key.m_mask |= types.Key.Bitmask.Insert; },
                    3   => { event.key.m_mask |= types.Key.Bitmask.Delete; },
                    5   => { event.key.m_mask |= types.Key.Bitmask.PageUp; },
                    6   => { event.key.m_mask |= types.Key.Bitmask.PageDown; },
                    15  => { event.key.m_mask |= types.Key.Bitmask.F5; },
                    17  => { event.key.m_mask |= types.Key.Bitmask.F6; },
                    18  => { event.key.m_mask |= types.Key.Bitmask.F7; },
                    19  => { event.key.m_mask |= types.Key.Bitmask.F8; },
                    20  => { event.key.m_mask |= types.Key.Bitmask.F9; },
                    21  => { event.key.m_mask |= types.Key.Bitmask.F10; },
                    23  => { event.key.m_mask |= types.Key.Bitmask.F11; },
                    24  => { event.key.m_mask |= types.Key.Bitmask.F12; },
                    else => { event.key.m_mask |= types.Key.Bitmask.Unknown; },
                }
            },

            else => { event.key.m_mask |= types.Key.Bitmask.Unknown; },
        }

        if (modifier != 0) {
            switch (modifier) {
                2 => { event.key.m_mask |= types.Key.Bitmask.Shift; },
                3 => { event.key.m_mask |= types.Key.Bitmask.Alt; },
                4 => { event.key.m_mask |= types.Key.Bitmask.Shift | types.Key.Bitmask.Alt; },
                5 => { event.key.m_mask |= types.Key.Bitmask.Ctrl; },
                6 => { event.key.m_mask |= types.Key.Bitmask.Ctrl | types.Key.Bitmask.Shift; },
                7 => { event.key.m_mask |= types.Key.Bitmask.Ctrl | types.Key.Bitmask.Alt; },
                8 => { event.key.m_mask |= types.Key.Bitmask.Ctrl | types.Key.Bitmask.Alt | types.Key.Bitmask.Shift; },
                else => { event.key.m_mask |= types.Key.Bitmask.Unknown; },
            }
        }

        return event;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ Internal ════════════════════════════════════╗

    /// Cross-platform event reader.
    fn crossReader(current_term_settings: anytype) ReadError![]const u8 {
        if (@import("builtin").os.tag == .windows) {
            return windowsReader(current_term_settings.handles.inputHandle) catch return ReadError.FailedToRead;
        } else {
            return linuxReader(std.io.getStdIn().reader()) catch return ReadError.FailedToRead;
        }
    }

    /// Linux implementationn.
    fn linuxReader(_: anytype) ReadError![]const u8 {
        var buff: [32]u8 = undefined;
        var size: usize = undefined;

        // Read key input
        const reader = std.io.getStdIn().reader();
        size = reader.read(buff[0..]) catch return ReadError.FailedToRead;

        // Parse bytes
        return buff[0..size];
    }

    /// Windows implementation.
    fn windowsReader(inputHandle: anytype) ReadError![]const u8 {
        var input_buffer: [32]u16 = undefined;
        var chars_read: u32 = 0;
        var utf8_text: [32] u8 = undefined;

        while (true) {
            if (ReadConsoleW(inputHandle.?, &input_buffer, input_buffer.len, &chars_read, null) == 0)
                return ReadError.FailedToRead;

            const size = std.unicode.utf16LeToUtf8(&utf8_text, input_buffer[0..chars_read]) catch return ReadError.FailedToRead;

            return utf8_text[0..size];
        }

        return .{};
    }

    // Declare ReadConsoleW function
    extern "kernel32" fn ReadConsoleW(
        hConsoleInput: std.os.windows.HANDLE,
        lpBuffer: [*]u16,
        nNumberOfCharsToRead: u32,
        lpNumberOfCharsRead: *u32,
        lpReserved: ?*anyopaque,
    ) callconv(std.os.windows.WINAPI) std.os.windows.BOOL;

// ╚══════════════════════════════════════════════════════════════════════════════════╝