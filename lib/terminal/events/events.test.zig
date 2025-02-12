// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std               = @import("std");
    const events            = @import("./events.zig");
    const BigBuffer         = @import("../../string/string.zig").Buffer(u8, 256);
    const expect            = std.testing.expect;
    const expectEqual       = std.testing.expectEqual;
    const expectError       = std.testing.expectError;
    const expectStrings     = std.testing.expectEqualStrings;
    const expectSlices      = std.testing.expectEqualSlices;
    const some_text         = "some_text";

    fn print (msg: []const u8) void { std.debug.print("{s} \n", .{msg}); }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
