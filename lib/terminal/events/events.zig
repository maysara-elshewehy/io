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
    const events    = switch (builtin.os.tag) {
        .linux      => @import("./events.linux.zig"),
        .windows    => @import("./events.win.zig"),
        else        => @compileError("OS not supported"),
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // Implementation for listening to a single key press
    pub fn listen() !types.Key {
        return events.enableRawMode();
    }

    // Implementation for continuously listening to key presses
    pub fn listenUntil(condition: fn (key: types.Key) bool) !void {
        while (true) {
            const key = try listen();
            if (condition(key)) break;
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝