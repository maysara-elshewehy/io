// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// ..?
    pub const Viewer = @import("./Viewer/src.zig");

    /// ..?
    pub const Buffer = @import("./Buffer/src.zig");

    /// ..?
    pub const String = @import("./String/src.zig");

    /// ..?
    pub const uString = @import("./uString/src.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./Viewer/test.zig");
        _ = @import("./Buffer/test.zig");
        _ = @import("./String/test.zig");
        _ = @import("./uString/test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝