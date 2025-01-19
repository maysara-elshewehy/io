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

    // ┌─────────────────────── Initialization ───────────────────────┐

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

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐

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

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "Buffer.find" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected  :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 2 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 17 },
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, buffer.find(c.value));
            }
        }

        test "Buffer.findVisual" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 2 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 7 },
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, buffer.findVisual(c.value));
            }
        }

        test "Buffer.rfind" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 3 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 17},
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, buffer.rfind(c.value));
            }
        }

        test "Buffer.rfindVisual" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value  : []const u8 = undefined, expected  :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 3 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 7},
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, buffer.rfindVisual(c.value));
            }
        }

        test "Buffer.includes" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            try expect(buffer.includes("H"));
            try expect(buffer.includes("e"));
            try expect(buffer.includes("l"));
            try expect(buffer.includes("o"));
            try expect(buffer.includes(" "));
            try expect(buffer.includes("👨‍🏭"));
            try expect(buffer.includes("!"));
            try expect(!buffer.includes("@"));
        }

        test "Buffer.startsWith" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            try expect(buffer.startsWith("H"));
            try expect(!buffer.startsWith("👨‍🏭"));
        }

        test "Buffer.endsWith" {
            const buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            try expect(buffer.endsWith("!"));
            try expect(!buffer.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "toLower" {
            var buffer = try Buffer.init(18, "HeLLo 👨‍🏭!");
            buffer.toLower();
            try expectStrings("hello 👨‍🏭!", buffer.source[0..buffer.length]); 
        }

        test "toUpper" {
            var buffer = try Buffer.init(18, "HeLLo 👨‍🏭!");
            buffer.toUpper();
            try expectStrings("HELLO 👨‍🏭!", buffer.source[0..buffer.length]); 
        }

        test "toTitle" {
            var buffer = try Buffer.init(18, "heLLo 👨‍🏭!");
            buffer.toTitle();
            try expectStrings("Hello 👨‍🏭!", buffer.source[0..buffer.length]); 
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝