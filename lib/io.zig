// Copyright (c) 2025 SuperZIG All rights reserved.
//
// main repo: https://github.com/Super-ZIG/io
// benchmark repo: https://github.com/maysara-elshewehy/io-bench
// docs website: https://super-zig.github.io/io/
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const StringModule      = @import("./string/string.zig");
    pub const chars         = StringModule.utils.chars;
    pub const Viewer        = StringModule.Viewer;
    pub const Buffer        = StringModule.Buffer;
    pub const String        = StringModule.String;
    pub const uString       = StringModule.uString;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "String" {
        _ = @import("./string/test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝