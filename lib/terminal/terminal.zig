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

    /// Comprehensive terminal settings for cross-platform compatibility.
    pub const settings = @import("./settings/settings.zig");

    /// Utility functions for ANSI escape code manipulation and terminal styling.
    pub const ansi = @import("./ansi/ansi.zig");

    /// Detailed terminal information ensuring cross-platform compatibility.
    pub const info = @import("./info/info.zig");

    /// Seamless Command Line Integration with ZIG.
    pub const cli = @import("./cli/cli.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./settings/settings.test.zig");
        _ = @import("./ansi/ansi.test.zig");
        _ = @import("./info/info.test.zig");
        _ = @import("./cli/cli.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝