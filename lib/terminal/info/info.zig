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

    const std       = @import("std");
    const ansi      = @import("../ansi/ansi.zig");
    const cross     = switch (@import("builtin").os.tag) {
        .windows    => @import("./info.win.zig"),
        else        => @import("./info.linux.zig"),
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const GetError = cross.GetError;

    /// Terminal info structure.
    pub const TerminalInfo = cross.TerminalInfo;

    /// Cursor info structure.
    pub const Cursor = cross.Cursor;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Get current terminal info.
    pub const get = cross.get;

    /// Get current cursor position.
    pub fn getCursor() GetError!Cursor {
        const info = try cross.get();
        return .{
            .x = info.cursor.x,
            .y = info.cursor.y,
        };
    }

    /// Get current terminal width.
    pub fn getWidth() GetError!u16 {
        const info = try cross.get();
        return info.width;
    }

    /// Get current terminal height.
    pub fn getHeight() GetError!u16 {
        const info = try cross.get();
        return info.height;
    }

    /// Get current terminal rows.
    pub fn getRows() GetError!u16 {
        const info = try cross.get();
        return info.rows;
    }

    /// Get current terminal cols.
    pub fn getCols() GetError!u16 {
        const info = try cross.get();
        return info.cols;
    }

    /// Set the cursor position.
    pub fn setCursor(cursor: Cursor) !void {
        try ansi.cursor.goTo(std.io.getStdOut().writer(), cursor.x, cursor.y);
    }

    /// Set the cursor position and clears everything after the new position.
    pub fn setCursorAndClear(cursor: Cursor) !void {
        try setCursor(cursor);
        try ansi.clear.screenFromCursor(std.io.getStdOut().writer());
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝