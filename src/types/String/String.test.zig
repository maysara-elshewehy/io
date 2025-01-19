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

    // ┌─────────────────────── Initialization ───────────────────────┐

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

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐

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

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "String.find" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

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
                try expectEqual(c.expected, string.find(c.value));
            }
        }

        test "String.findVisual" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

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
                try expectEqual(c.expected, string.findVisual(c.value));
            }
        }

        test "String.rfind" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

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
                try expectEqual(c.expected, string.rfind(c.value));
            }
        }

        test "String.rfindVisual" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

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
                try expectEqual(c.expected, string.rfindVisual(c.value));
            }
        }

        test "String.includes" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            try expect(string.includes("H"));
            try expect(string.includes("e"));
            try expect(string.includes("l"));
            try expect(string.includes("o"));
            try expect(string.includes(" "));
            try expect(string.includes("👨‍🏭"));
            try expect(string.includes("!"));
            try expect(!string.includes("@"));
        }

        test "String.startsWith" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            try expect(string.startsWith("H"));
            try expect(!string.startsWith("👨‍🏭"));
        }

        test "String.endsWith" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            try expect(string.endsWith("!"));
            try expect(!string.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "toLower" {
            var  string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            string.toLower();
            try expectStrings("hello 👨‍🏭!", string.source[0..string.length]); 
        }

        test "toUpper" {
            var  string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            string.toUpper();
            try expectStrings("HELLO 👨‍🏭!", string.source[0..string.length]); 
        }

        test "toTitle" {
            var  string = try String.init(allocator, "heLLo 👨‍🏭!");
            defer string.deinit();

            string.toTitle();
            try expectStrings("Hello 👨‍🏭!", string.source[0..string.length]); 
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        // wait for append function to be implemented.
        test "writtenSlice" {
            var string = try String.init(allocator, &[_]u8{ '1', 0, 0 });
            defer string.deinit();

            try expectEqual(1, string.writtenSlice().len);
        }

        // wait for append function to be implemented.
        test "allocatedSlice" {
            var string = try String.init(allocator, &[_]u8{ '1', 0, 0 });
            defer string.deinit();
            
            // size = original length *2
            try expectEqual(6, string.allocatedSlice().len);
        }
    
    // └──────────────────────────────────────────────────────────────┘


// ╚══════════════════════════════════════════════════════════════════════════════════╝