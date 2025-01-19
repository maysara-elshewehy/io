// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A set of useful functions for working with bytes.
    pub const bytes = @import("./bytes/bytes.zig");

    /// A set of useful functions for working with utf-8.
    pub const utf8 = @import("./utf8/utf8.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./bytes/bytes.test.zig");
        _ = @import("./utf8/utf8.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝