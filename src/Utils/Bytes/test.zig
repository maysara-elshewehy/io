// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("./src.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectEqualStrings = std.testing.expectEqualStrings;

    const invalid_utf8 : [2]u8     = .{0xc0, 0x80};
    const long_array   : [1024]u8  = .{'#'} ** 1024;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗


// ╚══════════════════════════════════════════════════════════════════════════════════╝