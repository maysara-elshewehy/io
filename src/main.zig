// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A set of utility functions for working with bytes.
    const Bytes = @import("./mods/Bytes.zig");

    /// Fixed array of bytes.
    const Buffer = @import("./mods/Buffer.zig");

    /// Dynamic array of bytes.
    const String = @import("./mods/String.zig").String;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./tests/Bytes.zig");
        _ = @import("./tests/Buffer.zig");
        _ = @import("./tests/String.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝