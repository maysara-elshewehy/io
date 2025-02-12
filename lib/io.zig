// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/
// bench: https://github.com/maysara-elshewehy/SuperZIG-bench
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const StringModule      = @import("./string/string.zig");
    pub const chars         = StringModule.utils.chars;
    pub const unicode       = StringModule.utils.unicode;
    pub const Viewer        = StringModule.Viewer;
    pub const Buffer        = StringModule.Buffer;
    pub const String        = StringModule.String;
    pub const uString       = StringModule.uString;

    pub const terminal      = @import("./terminal/terminal.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./string/string.test.zig");
        _ = @import("./terminal/terminal.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝