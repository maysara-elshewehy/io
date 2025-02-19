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
        height: u16,
        width: u16,
        rows: u16,
        cols: u16,
        cursor: Cursor,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Get current terminal info.
    pub inline fn get() GetError!TerminalInfo {
        const hStdOut = std.os.windows.GetStdHandle(std.os.windows.STD_OUTPUT_HANDLE)
                        catch return GetError.FailedToGetInfo;

        if (@intFromPtr(hStdOut) == @intFromPtr(std.os.windows.INVALID_HANDLE_VALUE))
            return GetError.FailedToGetInfo;

        var csbi: WindowsTerminalInfo = undefined;
        if (GetConsoleScreenBufferInfo(hStdOut, &csbi) == 0)
            return GetError.FailedToGetInfo;

        return TerminalInfo{
            .height = @intCast(csbi.dwSize.Y),
            .width = @intCast(csbi.dwSize.X),
            .rows = @intCast(csbi.srWindow.Bottom - csbi.srWindow.Top),
            .cols = @intCast(csbi.srWindow.Right  - csbi.srWindow.Left),
            .cursor = .{ .x=csbi.dwCursorPosition.X, .y=csbi.dwCursorPosition.Y },
        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ Internal ════════════════════════════════════╗

    const WindowsTerminalInfo = extern struct {
        dwSize                      : std.os.windows.COORD,
        dwCursorPosition            : std.os.windows.COORD,
        wAttributes                 : u16,
        srWindow                    : std.os.windows.SMALL_RECT,
        dwMaximumWindowSize         : std.os.windows.COORD,
    };

    extern "kernel32" fn GetConsoleScreenBufferInfo(
        hConsoleOutput              : std.os.windows.HANDLE,
        lpConsoleScreenBufferInfo   : *WindowsTerminalInfo
    )callconv(std.os.windows.WINAPI) i32;

// ╚══════════════════════════════════════════════════════════════════════════════════╝