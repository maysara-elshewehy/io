// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A set of useful utilities with associated functions.
    pub const utils = @import("./utils/utils.zig");

    /// A set of useful data types with their associated functions.
    pub const types = @import("./types/types.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "all" {
        _ = @import("./utils/utils.zig");
        _ = @import("./types/types.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝