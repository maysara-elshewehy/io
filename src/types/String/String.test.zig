// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const String = @import("./String.zig").String;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

    const allocator = std.testing.allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "initialization" {
        // initAlloc
        {
            const string = String.initAlloc(allocator);
            defer string.deinit();
            try expect(string.capacity == 0);
        }

        // initCapacity
        {
            // zero size
            try expectError(error.ZeroSize, String.initCapacity(allocator, 0));

            // non zero size
            const string = try String.initCapacity(allocator, 64);
            defer string.deinit();
            try expect(string.capacity == 64);
        }

        // Init
        {
            // empty input
            const emptyUtf8: []const u8 = "";
            try expectError(error.ZeroSize, String.init(allocator, emptyUtf8));

            // non empty input (valid UTF-8)
            const validUtf8: []const u8 = "Hello, 世界!";
            const string = try String.init(allocator, validUtf8);
            defer string.deinit();
            try expectEqual(validUtf8.len, string.length);
            try expectEqual(28, string.capacity);
            try expectStrings(validUtf8, string.writtenSlice());

            // non empty input (invalid UTF-8)
            const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
            try expectError(error.InvalidValue, String.init(allocator, invalidUtf8));
        }
    }

    test "iterator" {
        const validUtf8: []const u8 = "Hello, 世界!";
        var string = try String.init(allocator, validUtf8);
        defer string.deinit();
        var iter = try string.iterator();

        while(iter.nextSlice()) |slice| {
            try expect(utf8.utils.isValid(slice));
        }
        
        // Ensure all characters were iterated
        try expectEqual(validUtf8.len, iter.current_index);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝