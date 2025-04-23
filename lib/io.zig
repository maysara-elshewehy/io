// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    /// Provides utilities for string manipulation and operations.
    pub const string = @import("./string/string.zig");

    /// Provides utilities for terminal input/output operations.
    pub const terminal = @import("./terminal/terminal.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./string/string.zig");
        _ = @import("./terminal/terminal.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝