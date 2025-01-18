// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// ..?
    pub const Viewer = @import("./Viewer/Viewer.zig");

    /// ..?
    pub const Buffer = @import("./Buffer/Buffer.zig");

    /// ..?
    pub const String = @import("./String/String.zig");

    /// ..?
    pub const uString = @import("./uString/uString.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./Viewer/Viewer.test.zig");
        _ = @import("./Buffer/Buffer.test.zig");
        _ = @import("./String/String.test.zig");
        _ = @import("./uString/uString.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝