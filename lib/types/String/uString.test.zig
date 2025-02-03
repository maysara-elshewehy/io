// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Unicode = @import("../../utils/Unicode/Unicode.zig");
    const uString = @import("./String.zig").uString;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

    const allocator = std.testing.allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "initialization" {
            // initCapacity
            {
                // zero size
                try expectError(error.ZeroSize, uString.initCapacity(allocator, 0));

                // non zero size
                var ustring = try uString.initCapacity(allocator, 64);
                defer ustring.deinit(allocator);
                try expect(ustring.capacity() == 64);
            }

            // Init
            {
                // empty input
                const _empty: []const u8 = "";
                const empty = try uString.init(allocator, _empty);
                defer empty.deinit(allocator);
                try expectEqual(_empty.len, empty.length());
                try expectEqual(0, empty.capacity());
                try expectStrings(_empty, empty.slice());

                // non empty input (valid unicode)
                const validUnicode: []const u8 = "Hello, 世界!";
                var ustring = try uString.init(allocator, validUnicode);
                defer ustring.deinit(allocator);
                try expectEqual(validUnicode.len, ustring.length());
                try expectEqual(28, ustring.capacity());
                try expectStrings(validUnicode, ustring.slice());

                // non empty input (invalid unicode)
                // try expectError(unreachable, uString.init(allocator, &[_]u8{0x80, 0x81, 0x82}));
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐


        test "iterator" {
            const validUnicode: []const u8 = "Hello, 世界!";
            var ustring = try uString.init(allocator, validUnicode);
            defer ustring.deinit(allocator);
            var iter = try ustring.iterator();

            while(iter.nextSlice()) |slice| {
                try expect(Unicode.utils.Utf8Validate(slice));
            }

            // Ensure all characters were iterated
            try expectEqual(validUnicode.len, iter.current_index);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "insert" {
            var string = try uString.initCapacity(allocator, 18);
            defer string.deinit(allocator);

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
                try string.insert(allocator, c.value, c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insert(allocator, &[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, string.insert(allocator, "@", 99));
        }

        test "insertOne" {
            var string = try uString.initCapacity(allocator, 7);
            defer string.deinit(allocator);

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
                try string.insertOne(allocator, c.value, c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertOne(allocator, '\x80', 0));
            try expectError(error.OutOfRange, string.insertOne(allocator, '@', 99));
        }

        test "insertVisual" {
            var string = try uString.initCapacity(allocator, 18);
            defer string.deinit(allocator);

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
                try string.insertVisual(allocator, c.value, c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertVisual(allocator, &[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, string.insertVisual(allocator, "@", 99));
        }

        test "insertVisualOne" {
            var string = try uString.init(allocator, "👨‍🏭");
            defer string.deinit(allocator);

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
                try string.insertVisualOne(allocator, c.value, c.pos);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.insertVisualOne(allocator, '\x80', 0));
            try expectError(error.OutOfRange, string.insertVisualOne(allocator, '@', 99));
        }

        test "append" {
            var string = try uString.initCapacity(allocator, 18);
            defer string.deinit(allocator);

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
                try string.append(allocator, c.value);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.append(allocator, &[_]u8{0x80, 0x81, 0x82}));
        }

        test "appendOne" {
            var string = try uString.initCapacity(allocator, 7);
            defer string.deinit(allocator);

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
                try string.appendOne(allocator, c.value);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.appendOne(allocator, 0x80));
        }

        test "prepend" {
            var string = try uString.initCapacity(allocator, 18);
            defer string.deinit(allocator);

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
                try string.prepend(allocator, c.value);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.prepend(allocator, &[_]u8{0x80, 0x81, 0x82}));
        }

        test "prependOne" {
            var string = try uString.initCapacity(allocator, 7);
            defer string.deinit(allocator);

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
                try string.prependOne(allocator, c.value);
                try expectStrings(c.expected, string.slice());
            }

            // Failure Cases.
            // try expectError(unreachable, string.prependOne(allocator, 0x80));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "remove" {
            var string = try uString.init(allocator, "Hello !");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello !");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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

            var string2 = try uString.init(allocator, "👨‍🏭");
            defer string2.deinit(allocator);

            const res2 = string2.removeVisual(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "removeVisualRange" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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

            var string2 = try uString.init(allocator, "👨‍🏭");
            defer string2.deinit(allocator);

            const res2 = string2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "pop" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

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
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

            try expect(string.startsWith("H"));
            try expect(!string.startsWith("👨‍🏭"));
        }

        test "endsWith" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

            try expect(string.endsWith("!"));
            try expect(!string.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "toLower" {
            var  string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

            string.toLower();
            try expectStrings("hello 👨‍🏭!", string.slice());
        }

        test "toUpper" {
            var  string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

            string.toUpper();
            try expectStrings("HELLO 👨‍🏭!", string.slice());
        }

        test "toTitle" {
            var  string = try uString.init(allocator, "heLLo 👨‍🏭!");
            defer string.deinit(allocator);

            string.toTitle();
            try expectStrings("Hello 👨‍🏭!", string.slice());
        }

        test "reverse" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);
            try string.reverse(allocator);
            try expectStrings("!👨‍🏭 olleH", string.slice());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "length/vlength" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);

            try expectEqual(18, string.m_source.len);
            try expectEqual(18, string.length());
            try expectEqual(8, string.vlength());
        }

        test "slice/allocatedSlice" {
            var string = try uString.init(allocator, &[_]u8{ '1', 0, 0 });
            defer string.deinit(allocator);

            try expectStrings("1", string.slice());
            try expectEqual(1, string.slice().len);

            // size = original length *2
            try expectEqual(6, string.allocatedSlice().len);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Utils ────────────────────────────┐

        test "split" {
            var string = try uString.init(allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer string.deinit(allocator);

            // Test basic splits
            try expectStrings("0", string.split("👨‍🏭", 0).?);
            try expectStrings("11", string.split("👨‍🏭", 1).?);
            try expectStrings("2", string.split("👨‍🏭", 2).?);
            try expectStrings("33", string.split("👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(string.split("👨‍🏭", 4) == null);

            // Test empty input
            var string2 = try uString.initCapacity(allocator, 1);
            defer string2.deinit(allocator);
            try expectStrings("", string2.split("👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(string.slice(), string.split("X", 0).?);
        }

        test "splitAll edge cases" {
            // Leading/trailing delimiters
            var string = try uString.init(allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer string.deinit(allocator);

            const parts2 = try string.splitAll(allocator, "👨‍🏭", true);
            defer allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try string.splitAll(allocator, "👨‍🏭", false);
            defer allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

        test "splitToString" {
            var string = try uString.init(allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer string.deinit(allocator);

            // Test basic splits
            if(try string.splitToString(allocator, "👨‍🏭", 0)) |res| {
                defer res.deinit(allocator);
                try expectStrings("0", res.slice());
            }
            if(try string.splitToString(allocator, "👨‍🏭", 1)) |res| {
                defer res.deinit(allocator);
                try expectStrings("11", res.slice());
            }
            if(try string.splitToString(allocator, "👨‍🏭", 2)) |res| {
                defer res.deinit(allocator);
                try expectStrings("2", res.slice());
            }
            if(try string.splitToString(allocator, "👨‍🏭", 3)) |res| {
                defer res.deinit(allocator);
                try expectStrings("33", res.slice());
            }

            // Test out-of-bounds indices
            try expect(try string.splitToString(allocator, "👨‍🏭", 4) == null);

            // Test empty input
            var string2 = uString.initAlloc(allocator);
            try expectStrings("", (try string2.splitToString(allocator, "👨‍🏭", 0)).?.slice());

            // Test non-existent delimiter
            if(try string.splitToString(allocator, "X", 0)) |res| {
                defer res.deinit(allocator);
                try expectStrings(string.slice(), res.slice());
            }
        }

        test "splitAllToStrings edge cases" {
            // Leading/trailing delimiters
            var string = try uString.init(allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer string.deinit(allocator);

            const parts2 = try string.splitAllToStrings(allocator, "👨‍🏭");
            defer allocator.free(parts2);
            try expectStrings("", parts2[0].slice());
            try expectStrings("a", parts2[1].slice());
            try expectStrings("b", parts2[2].slice());
            try expectStrings("", parts2[3].slice());
            for(0..parts2.len) |i| { defer parts2[i].deinit(allocator); }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "replaceAllChars" {
            var string = try uString.init(allocator, "aXb");
            defer string.deinit(allocator);
            string.replaceAllChars('X', 'Y');
            try expectStrings("aYb", string.slice());
        }

        test "replaceAllSlices" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);
            const res = try string.replaceAllSlices(allocator, "👨‍🏭", "World");
            try expectStrings("Hello World!", string.slice());
            try expectEqual(1, res);
        }

        test "replaceRange" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);
            try string.replaceRange(allocator, 6, 11, "World");
            try expectStrings("Hello World!", string.slice());
        }

        test "replaceVisualRange" {
            var string = try uString.init(allocator, "Hello 👨‍🏭!");
            defer string.deinit(allocator);
            try string.replaceVisualRange(allocator, 6, 1, "World");
            try expectStrings("Hello World!", string.slice());
        }

    // └──────────────────────────────────────────────────────────────┘

    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "equals" {
            const string1 = try uString.init(allocator, "Hello, World!");
            defer string1.deinit(allocator);

            const string2 = try uString.init(allocator, "Hello, World!");
            defer string2.deinit(allocator);

            const string3 = try uString.init(allocator, "Goodbye, World!");
            defer string3.deinit(allocator);

            try expect(string1.equals(string2.slice()));
            try expect(!string1.equals(string3.slice()));
        }

        test "isEmpty" {
            const empty = try uString.init(allocator, "");
            defer empty.deinit(allocator);

            const nonEmpty = try uString.init(allocator, "Hello, World!");
            defer nonEmpty.deinit(allocator);

            try expect(empty.isEmpty());
            try expect(!nonEmpty.isEmpty());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝