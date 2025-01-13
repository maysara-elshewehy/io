// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Viewer = @import("./src.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectEqualStrings = std.testing.expectEqualStrings;

    const ZWJ_array    : [3]u8     = .{0xE2, 0x80, 0x8D};
    const MOD_array    : [2]u8     = .{0xCC, 0x81};
    const invalid_utf8 : [2]u8     = .{0xc0, 0x80};

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗


// ╚══════════════════════════════════════════════════════════════════════════════════╝