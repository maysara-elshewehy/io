// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// Immutable fixed-size string type that supports Unicode.
    pub const Viewer = @import("./Viewer/Viewer.zig").Viewer;

    /// Mutable Immutable fixed-size string type that supports Unicode.
    pub const Buffer = @import("./Buffer/Buffer.zig");

    /// Managed dynamic-size string type that supports Unicode.
    pub const String = @import("./String/String.zig").String;

    /// Unmanaged dynamic-size string type that supports Unicode.
    pub const uString = @import("./String/String.zig").uString;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./Viewer/Viewer.test.zig");
        _ = @import("./Buffer/Buffer.test.zig");
        _ = @import("./String/String.test.zig");
        _ = @import("./String/uString.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝