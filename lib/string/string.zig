// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    /// A utility module for efficient string manipulation, providing various tools
    /// for handling ASCII, UTF-8, codepoints, graphemes, and memory operations.
    pub const utils = .{
        .ascii      = @import("./utils/ascii.zig"),
        .utf8       = @import("./utils/utf8.zig"),
        .codepoint  = @import("./utils/codepoint.zig"),
        .grapheme   = @import("./utils/grapheme.zig"),
        .memory     = @import("./utils/memory.zig"),
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        // utils
        _ = @import("./utils/ascii.test.zig");
        _ = @import("./utils/utf8.test.zig");
        _ = @import("./utils/codepoint.test.zig");
        _ = @import("./utils/grapheme.test.zig");
        _ = @import("./utils/memory.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝