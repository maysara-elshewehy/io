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


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "insert" {
            var string = try String.initCapacity(allocator, 18);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H", .pos=0 },
                .{ .value  = "!",   .expected = "H!", .pos=1 },
                .{ .value  = "o",   .expected = "Ho!", .pos=1 },
                .{ .value  = "ell", .expected = "Hello!", .pos=1 },
                .{ .value  = " ",   .expected = "Hello !", .pos=5 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!", .pos=6 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!", .pos=2 },
            };

            for(cases) |c| {
                try string.insert(c.value, c.pos);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.insert(&[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, string.insert("@", 99)); // TODO: update with the actual value
        }

        test "insertOne" {
            var string = try String.initCapacity(allocator, 7);
            defer string.deinit();

            const Cases = struct { value: u8, expected: []const u8, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "H", .pos=0 },
                .{ .value  = '!', .expected = "H!", .pos=1 },
                .{ .value  = 'o', .expected = "Ho!", .pos=1 },
                .{ .value  = 'l', .expected = "Hlo!", .pos=1 },
                .{ .value  = 'e', .expected = "Helo!", .pos=1 },
                .{ .value  = 'l', .expected = "Hello!", .pos=2 },
                .{ .value  = ' ', .expected = "Hello !", .pos=5 },
            };

            for(cases) |c| {
                try string.insertOne(c.value, c.pos);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.insertOne('\x80', 0));
            try expectError(error.OutOfRange, string.insertOne('@', 99)); // TODO: update with the actual value
        }

        test "insertVisual" {
            var string = try String.initCapacity(allocator, 18);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H", .pos=0 },
                .{ .value  = "👨‍🏭",  .expected = "H👨‍🏭", .pos=1 },
                .{ .value  = "o",   .expected = "Ho👨‍🏭", .pos=1 },
                .{ .value  = "ell", .expected = "Hello👨‍🏭", .pos=1 },
                .{ .value  = " ",   .expected = "Hello 👨‍🏭", .pos=5 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!", .pos=7 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!", .pos=2 },
            };

            for(cases) |c| {
                try string.insertVisual(c.value, c.pos);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.insertVisual(&[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, string.insertVisual("@", 99));
        }

        test "insertVisualOne" {
            var string = try String.init(allocator, "👨‍🏭");
            defer string.deinit();

            const Cases = struct { value: u8, expected: []const u8, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "👨‍🏭H", .pos=1 },
                .{ .value  = '!', .expected = "👨‍🏭H!", .pos=2 },
                .{ .value  = 'o', .expected = "👨‍🏭Ho!", .pos=2 },
                .{ .value  = 'l', .expected = "👨‍🏭Hlo!", .pos=2 },
                .{ .value  = 'e', .expected = "👨‍🏭Helo!", .pos=2 },
                .{ .value  = 'l', .expected = "👨‍🏭Hello!", .pos=3 },
                .{ .value  = ' ', .expected = "👨‍🏭Hello !", .pos=6 },
            };

            for(cases) |c| {
                try string.insertVisualOne(c.value, c.pos);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.insertVisualOne('\x80', 0));
            try expectError(error.OutOfRange, string.insertVisualOne('@', 99));
        }

        test "append" {
            var string = try String.initCapacity(allocator, 18);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H" },
                .{ .value  = "e",   .expected = "He" },
                .{ .value  = "llo", .expected = "Hello" },
                .{ .value  = " ",   .expected = "Hello " },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭" },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" },
            };

            for(cases) |c| {
                try string.append(c.value);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.append(&[_]u8{0x80, 0x81, 0x82}));
        }

        test "appendOne" {
            var string = try String.initCapacity(allocator, 7);
            defer string.deinit();

            const Cases = struct { value: u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "H" },
                .{ .value  = 'e', .expected = "He" },
                .{ .value  = 'l', .expected = "Hel" },
                .{ .value  = 'l', .expected = "Hell" },
                .{ .value  = 'o', .expected = "Hello" },
                .{ .value  = ' ', .expected = "Hello " },
                .{ .value  = '!', .expected = "Hello !" },
            };

            for(cases) |c| {
                try string.appendOne(c.value);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.appendOne(0x80));
        }

        test "prepend" {
            var string = try String.initCapacity(allocator, 18);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H" },
                .{ .value  = "e",   .expected = "eH" },
                .{ .value  = "oll", .expected = "olleH" },
                .{ .value  = " ",   .expected = " olleH" },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH" },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" },
            };

            for(cases) |c| {
                try string.prepend(c.value);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.prepend(&[_]u8{0x80, 0x81, 0x82}));
        }

        test "prependOne" {
            var string = try String.initCapacity(allocator, 7);
            defer string.deinit();

            const Cases = struct { value: u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "H" },
                .{ .value  = 'e', .expected = "eH" },
                .{ .value  = 'l', .expected = "leH" },
                .{ .value  = 'l', .expected = "lleH" },
                .{ .value  = 'o', .expected = "olleH" },
                .{ .value  = ' ', .expected = " olleH" },
                .{ .value  = '!', .expected = "! olleH" },
            };

            for(cases) |c| {
                try string.prependOne(c.value);
                try expectStrings(c.expected, string.writtenSlice());
            }

            // Failure Cases.
            try expectError(error.InvalidValue, string.prependOne(0x80));
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
            try expectStrings("hello 👨‍🏭!", string.writtenSlice()); 
        }

        test "toUpper" {
            var  string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            string.toUpper();
            try expectStrings("HELLO 👨‍🏭!", string.writtenSlice()); 
        }

        test "toTitle" {
            var  string = try String.init(allocator, "heLLo 👨‍🏭!");
            defer string.deinit();

            string.toTitle();
            try expectStrings("Hello 👨‍🏭!", string.writtenSlice()); 
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

        test "reverse" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();
            try string.reverse();
            try expectStrings("!👨‍🏭 olleH", string.writtenSlice());
        }
    
    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝