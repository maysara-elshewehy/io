// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Buffer = @import("./Buffer.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "initialization" {
        // empty input
        const emptyUtf8: []const u8 = "";
        try expectError(error.ZeroSize, Buffer.init(64, emptyUtf8));

        // non empty input (valid UTF-8)
        const validUtf8: []const u8 = "Hello, 世界!";
        const buffer = try Buffer.init(64, validUtf8);
        try expect(buffer.length == validUtf8.len);
        try expect(buffer.source.len == 64);
        try expectStrings(validUtf8, buffer.source[0..buffer.length]);

        // non empty input (invalid UTF-8)
        const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
        try expectError(error.InvalidValue, Buffer.init(64, invalidUtf8));
    }

    test "iterator" {
        const validUtf8: []const u8 = "Hello, 世界!";
        var buffer = try Buffer.init(64, validUtf8[0..]);
        var iter = try buffer.iterator();

        while(iter.nextSlice()) |slice| {
            try expect(utf8.utils.isValid(slice));
        }
        
        // Ensure all characters were iterated
        try expectEqual(validUtf8.len, iter.current_index);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝