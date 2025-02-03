// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A set of useful functions for working with Bytes.
    pub const Bytes = @import("./Bytes/Bytes.zig");

    /// A set of useful functions for working with unicode.
    pub const Unicode = @import("./Unicode/Unicode.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./Bytes/Bytes.test.zig");
        _ = @import("./Unicode/Unicode.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝