// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// Immutable fixed array of `UTF-8` bytes.
    pub const Viewer = @import("./Viewer/Viewer.zig").Viewer;

    /// Mutable fixed array of `UTF-8` bytes.
    pub const Buffer = @import("./Buffer/Buffer.zig");

    /// Managed dynamic array of `UTF-8` bytes.
    pub const String = @import("./String/String.zig").String;

    /// Unmanaged dynamic array of `UTF-8` bytes.
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