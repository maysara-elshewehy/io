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
    const posix     = std.posix;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Linux implementation for enabling raw mode and detecting key presses.
    ///
    /// We use posix tcgetattr and tcsetattr to get and set terminal attributes.
    ///
    /// Then we use posix read to get key events and parse them into Key.
    pub inline fn enableRawMode() !types.Key {

        // Get current terminal settings.
        const start_settings = try posix.tcgetattr(0);
        defer posix.tcsetattr(0, .FLUSH, start_settings) catch unreachable;

        // Set the new terminal settings
        var new_settings = start_settings;
        // Disable canonical mode (no buffering, no waiting for Enter key to submit input)
        new_settings.lflag.ICANON = false;
        // Disable echoing characters (input characters will not be displayed on the terminal)
        new_settings.lflag.ECHO = false;
        // Set minimum number of characters to 1 (we don’t need to wait for Enter key)
        new_settings.cc[6] = 1; // VMIN
        // Set timeout to 0 (no wait time for input)
        new_settings.cc[5] = 0; // VTIME

        var key_buffer: [3]u8 = undefined;
        var bytes_read: usize = undefined;

        // Set the new terminal settings
        try posix.tcsetattr(0, .FLUSH, new_settings);

        // Read key input
        bytes_read = try std.io.getStdIn().reader().read(key_buffer[0..]);

        if (bytes_read > 0) return parseBytesRead(key_buffer[0..], bytes_read)
        else unreachable;
    }

    /// -
    inline fn parseBytesRead(key_buffer: []const u8, bytes_read: usize) types.Key {
        var res = types.Key {
            .m_val  = 0,
            .m_mod  = 0,
            .m_state = types.Key.State.None,
            .m_arrow = types.Key.Arrow.None,
        };

        if (bytes_read == 0) return res;

        // Detect arrow keys
        if (key_buffer[1] == '[' and bytes_read > 2) {
            res.m_arrow = switch (key_buffer[2]) {
                'A' => types.Key.Arrow.Up,
                'B' => types.Key.Arrow.Down,
                'C' => types.Key.Arrow.Right,
                'D' => types.Key.Arrow.Left,
                else => types.Key.Arrow.None,
            };
            return res;
        }

        // Alt key detection
        if (key_buffer[0] == 0x1B) {
            res.m_mod |= 1 << 0;

            if (bytes_read > 1) {
                res.m_val = key_buffer[1];
                if (std.ascii.isUpper(key_buffer[1])) { res.m_mod |= 1 << 1; }
                if (key_buffer[1] >= 0x00 and key_buffer[1] <= 0x1F) { res.m_mod |= 1 << 2; }
            }

            return res;
        }

        // Ctrl key detection
        if (key_buffer[0] >= 0x00 and key_buffer[0] <= 0x1F) {
            res.m_mod |= 1 << 2;
            res.m_val = key_buffer[0];

            return res;
        }

        // Shift detection
        if (std.ascii.isUpper(key_buffer[0])) { res.m_mod |= 1 << 1; }

        res.m_val = key_buffer[0];

        return res;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝