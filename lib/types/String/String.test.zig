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
                try expect(string.capacity() == 0);
            }

            // initCapacity
            {
                // zero size
                try expectError(error.ZeroSize, String.initCapacity(allocator, 0));

                // non zero size
                const string = try String.initCapacity(allocator, 64);
                defer string.deinit();
                try expect(string.capacity() == 64);
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
                try expectEqual(validUtf8.len, string.length());
                try expectEqual(28, string.capacity());
                try expectStrings(validUtf8, string.slice());

                // non empty input (invalid UTF-8)
                // try expectError(unreachable, String.init(allocator, &[_]u8{0x80, 0x81, 0x82}));
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
            var string = String.initAlloc(allocator);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, capacity: usize, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .capacity = 8,   .expected = "H", .pos=0 },
                .{ .value  = "!",   .capacity = 8,   .expected = "H!", .pos=1 },
                .{ .value  = "o",   .capacity = 8,   .expected = "Ho!", .pos=1 },
                .{ .value  = "ell", .capacity = 8,   .expected = "Hello!", .pos=1 },
                .{ .value  = " ",   .capacity = 8,   .expected = "Hello !", .pos=5 },
                .{ .value  = "👨‍🏭",  .capacity = 20,  .expected = "Hello 👨‍🏭!", .pos=6 },
                .{ .value  = "",    .capacity = 20,  .expected = "Hello 👨‍🏭!", .pos=2 },
            };

            for(cases) |c| {
                try string.insert(c.value, c.pos);
                try expectStrings(c.expected, string.slice());
                try expectEqual(c.capacity, string.capacity());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insert(&[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, string.insert("@", 99));
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
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertOne('\x80', 0));
            try expectError(error.OutOfRange, string.insertOne('@', 99));
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
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertVisual(&[_]u8{0x80, 0x81, 0x82}, 17));
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
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertVisualOne('\x80', 0));
            try expectError(error.OutOfRange, string.insertVisualOne('@', 99));
        }

        test "append" {
            var string = String.initAlloc(allocator);
            defer string.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, capacity: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .capacity = 8,  .expected = "H" },
                .{ .value  = "e",   .capacity = 8,  .expected = "He" },
                .{ .value  = "llo", .capacity = 8, .expected = "Hello" },
                .{ .value  = " ",   .capacity = 8, .expected = "Hello " },
                .{ .value  = "👨‍🏭",  .capacity = 20, .expected = "Hello 👨‍🏭" },
                .{ .value  = "!",   .capacity = 20, .expected = "Hello 👨‍🏭!" },
                .{ .value  = "",    .capacity = 20, .expected = "Hello 👨‍🏭!" },
            };

            for(cases) |c| {
                try string.append(c.value);
                try expectStrings(c.expected, string.slice());
                try expectEqual(c.capacity, string.capacity());
            }

            // Failure Cases.
            // try expectError(unreachable, string.append(&[_]u8{0x80, 0x81, 0x82}));
        }

        test "appendOne" {
            var string = String.initAlloc(allocator);
            defer string.deinit();

            const Cases = struct { value: u8, expected: []const u8, capacity: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H', .capacity = 8, .expected = "H" },
                .{ .value  = 'e', .capacity = 8, .expected = "He" },
                .{ .value  = 'l', .capacity = 8, .expected = "Hel" },
                .{ .value  = 'l', .capacity = 8, .expected = "Hell" },
                .{ .value  = 'o', .capacity = 8, .expected = "Hello" },
                .{ .value  = ' ', .capacity = 8, .expected = "Hello " },
                .{ .value  = '!', .capacity = 8, .expected = "Hello !" },
            };

            for(cases) |c| {
                try string.appendOne(c.value);
                try expectStrings(c.expected, string.slice());
                try expectEqual(c.capacity, string.capacity());
            }

            // Failure Cases.
            // try expectError(unreachable, string.appendOne(0x80));
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
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.prepend(&[_]u8{0x80, 0x81, 0x82}));
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
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.prependOne(0x80));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "remove" {
            var string = try String.init(allocator, "Hello !");
            defer string.deinit();

            const Cases = struct { pos: usize, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .pos  = 0, .expected = "ello !" },
                .{ .pos  = 5, .expected = "ello " },
                .{ .pos  = 3, .expected = "ell " },
                .{ .pos  = 1, .expected = "el " },
                .{ .pos  = 0, .expected = "l " },
                .{ .pos  = 0, .expected = " " },
                .{ .pos  = 0, .expected = "" },
            };

            for(cases) |c| {
                try string.remove(c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, string.remove(1));
        }

        test "removeRange" {
            var string = try String.init(allocator, "Hello !");
            defer string.deinit();

            const Cases = struct { pos: usize, len: usize, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .pos  = 0, .len = 1, .expected = "ello !" },
                .{ .pos  = 5, .len = 1, .expected = "ello " },
                .{ .pos  = 3, .len = 1, .expected = "ell " },
                .{ .pos  = 1, .len = 1, .expected = "el " },
                .{ .pos  = 0, .len = 1, .expected = "l " },
                .{ .pos  = 0, .len = 1, .expected = " " },
                .{ .pos  = 0, .len = 1, .expected = "" },
            };

            for(cases) |c| {
                try string.removeRange(c.pos, c.len);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, string.removeRange(1, 1));
        }

        test "removeVisual" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            const Cases = struct { pos: usize, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .pos  = 6, .expected = "Hello !" },
                .{ .pos  = 0, .expected = "ello !" },
                .{ .pos  = 5, .expected = "ello " },
                .{ .pos  = 3, .expected = "ell " },
                .{ .pos  = 1, .expected = "el " },
                .{ .pos  = 0, .expected = "l " },
                .{ .pos  = 0, .expected = " " },
                .{ .pos  = 0, .expected = "" },
            };

            for(cases) |c| {
                _ = try string.removeVisual(c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            const res = string.removeVisual(1);
            try expectError(error.OutOfRange, res);

            var string2 = try String.init(allocator, "👨‍🏭");
            defer string2.deinit();

            const res2 = string2.removeVisual(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "removeVisualRange" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            const Cases = struct { pos: usize, len: usize, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .pos  = 6, .len = 1, .expected = "Hello !" },
                .{ .pos  = 0, .len = 1, .expected = "ello !" },
                .{ .pos  = 5, .len = 1, .expected = "ello " },
                .{ .pos  = 3, .len = 1, .expected = "ell " },
                .{ .pos  = 1, .len = 1, .expected = "el " },
                .{ .pos  = 0, .len = 1, .expected = "l " },
                .{ .pos  = 0, .len = 1, .expected = " " },
                .{ .pos  = 0, .len = 1, .expected = "" },
            };

            for(cases) |c| {
                _ = try string.removeVisualRange(c.pos, c.len);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            const res = string.removeVisualRange(1, 1);
            try expectError(error.OutOfRange, res);

            var string2 = try String.init(allocator, "👨‍🏭");
            defer string2.deinit();

            const res2 = string2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "pop" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            const Cases = struct { removed: []const u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .removed = "!",  .expected = "Hello 👨‍🏭" },
                .{ .removed = "👨‍🏭", .expected = "Hello " },
                .{ .removed = " ",  .expected = "Hello" },
                .{ .removed = "o",  .expected = "Hell" },
                .{ .removed = "l",  .expected = "Hel" },
                .{ .removed = "l",  .expected = "He" },
                .{ .removed = "e",  .expected = "H" },
                .{ .removed = "H",  .expected = "" },
            };

            for(cases) |c| {
                const res = string.pop();
                try expectStrings(c.removed, res.?);
                try expectStrings(c.expected, string.slice());
            }

            // null case
            try expectEqual(null, string.pop());
        }

        test "shift" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            const Cases = struct { removed: []const u8, expected: []const u8 };
            const cases = &[_]Cases{
                .{ .removed = "H",  .expected = "ello 👨‍🏭!" },
                .{ .removed = "e",  .expected = "llo 👨‍🏭!" },
                .{ .removed = "l",  .expected = "lo 👨‍🏭!" },
                .{ .removed = "l",  .expected = "o 👨‍🏭!" },
                .{ .removed = "o",  .expected = " 👨‍🏭!" },
                .{ .removed = " ",  .expected = "👨‍🏭!" },
                .{ .removed = "👨‍🏭", .expected = "!" },
                .{ .removed = "!",  .expected = "" },
                .{ .removed = "",  .expected = "" },
            };


            for(cases) |c| {
                const res = string.shift();
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, string.slice());
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "find" {
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

        test "findVisual" {
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

        test "rfind" {
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

        test "rfindVisual" {
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

        test "includes" {
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

        test "startsWith" {
            const string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            try expect(string.startsWith("H"));
            try expect(!string.startsWith("👨‍🏭"));
        }

        test "endsWith" {
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
            try expectStrings("hello 👨‍🏭!", string.slice());
        }

        test "toUpper" {
            var  string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            string.toUpper();
            try expectStrings("HELLO 👨‍🏭!", string.slice());
        }

        test "toTitle" {
            var  string = try String.init(allocator, "heLLo 👨‍🏭!");
            defer string.deinit();

            string.toTitle();
            try expectStrings("Hello 👨‍🏭!", string.slice());
        }

        test "reverse" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();
            try string.reverse();
            try expectStrings("!👨‍🏭 olleH", string.slice());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "length/vlength" {
            var string = try String.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit();

            try expectEqual(18, string.m_source.len);
            try expectEqual(18, string.length());
            try expectEqual(8, string.vlength());
        }

        test "slice/allocatedSlice" {
            var string = try String.init(allocator, &[_]u8{ '1', 0, 0 });
            defer string.deinit();

            try expectStrings("1", string.slice());
            try expectEqual(1, string.slice().len);

            // size = original length *2
            try expectEqual(6, string.allocatedSlice().len);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝