// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Viewer = @import("./Viewer.zig").Viewer;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "initialization" {
        // empty input
        const emptyUtf8: []const u8 = "";
        try expectError(error.ZeroSize, Viewer.init(emptyUtf8));

        // non empty input (valid UTF-8)
        const validUtf8: []const u8 = "Hello, 世界!";
        const buffer = try Viewer.init(validUtf8);
        try expectStrings(validUtf8, buffer.source[0..]);

        // non empty input (invalid UTF-8)
        const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
        try expectError(error.InvalidValue, Viewer.init(invalidUtf8));
    }

    test "iterator" {
        const validUtf8: []const u8 = "Hello, 世界!";
        const viewer = try Viewer.init(validUtf8);
        var iter = viewer.iterator();

        while(iter.nextSlice()) |slice| {
            try expect(utf8.utils.isValid(slice));
        }
        
        // Ensure all characters were iterated
        try expectEqual(validUtf8.len, iter.current_index);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝