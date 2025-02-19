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

    const std = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const GetError = error { FailedToGetInfo };

    // Cursor info structure.
    pub const Cursor = struct {
        x: i16,
        y: i16,
    };

    // Terminal info structure.
    pub const TerminalInfo = struct {
        height  : u16,
        width   : u16,
        rows    : u16,
        cols    : u16,
        cursor  : Cursor,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Returns the terminal info.
    pub inline fn get() GetError!TerminalInfo {
        var info: LinuxTerminalInfo = undefined;

        if (std.os.linux.ioctl(STDOUT_FILENO, TIOCGWINSZ, @intFromPtr(&info)) != 0)
            return GetError.FailedToGetInfo;

            var ws: std.posix.winsize = undefined;

            const err = std.posix.system.ioctl(0, std.posix.T.IOCGWINSZ, @intFromPtr(&ws));
            if (std.posix.errno(err) != .SUCCESS)
                return GetError.FailedToGetInfo;

        return TerminalInfo{
            .height     = ws.row,
            .width      = ws.col,
            .rows       = info.rows,
            .cols       = info.cols,
            .cursor     = .{ .x=info.x, .y=info.y },
        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const TIOCGWINSZ = 0x5413;
    const STDOUT_FILENO = 1;

    const LinuxTerminalInfo = extern struct {
        rows    : u16,
        cols    : u16,
        x       : i16,
        y   : i16,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝