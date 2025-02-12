// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal/
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    /// -
    pub const utils = @import("./utils/utils.zig");

    /// -
    pub const events = @import("./events/events.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./utils/utils.test.zig");
        _ = @import("./events/events.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝