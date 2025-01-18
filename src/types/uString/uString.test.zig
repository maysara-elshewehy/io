// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const uString = @import("./uString.zig").uString;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

    const allocator = std.testing.allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "initialization" {
        // initCapacity
        {
            // zero size
            try expectError(error.ZeroSize, uString.initCapacity(allocator, 0));

            // non zero size
            var ustring = try uString.initCapacity(allocator, 64);
            defer ustring.deinit(allocator);
            try expect(ustring.capacity == 64);
        }

        // Init
        {
            // empty input
            const emptyUtf8: []const u8 = "";
            try expectError(error.ZeroSize, uString.init(allocator, emptyUtf8));

            // non empty input (valid UTF-8)
            const validUtf8: []const u8 = "Hello, 世界!";
            var ustring = try uString.init(allocator, validUtf8);
            defer ustring.deinit(allocator);
            try expectEqual(validUtf8.len, ustring.length);
            try expectEqual(28, ustring.capacity);
            try expectStrings(validUtf8, ustring.writtenSlice());

            // non empty input (invalid UTF-8)
            const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
            try expectError(error.InvalidValue, uString.init(allocator, invalidUtf8));
        }
    }

    test "iterator" {
        const validUtf8: []const u8 = "Hello, 世界!";
        var ustring = try uString.init(allocator, validUtf8);
        defer ustring.deinit(allocator);
        var iter = try ustring.iterator();

        while(iter.nextSlice()) |slice| {
            try expect(utf8.utils.isValid(slice));
        }
        
        // Ensure all characters were iterated
        try expectEqual(validUtf8.len, iter.current_index);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝