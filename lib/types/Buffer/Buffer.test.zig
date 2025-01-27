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
            try expect(buffer.length() == validUtf8.len);
            try expect(buffer.m_source.len == 64);
            try expectStrings(validUtf8, buffer.m_source[0..buffer.length()]);
            // try expectError(error.InvalidValue, Buffer.init(64, &[_]u8{0x80, 0x81, 0x82}));
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


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "insert" {
            var buffer = try Buffer.initCapacity(18);
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
                try buffer.insert(c.value, c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.insert(&[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, buffer.insert("@", 17));
        }

        test "insertOne" {
            var buffer = try Buffer.initCapacity(7);
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
                try buffer.insertOne(c.value, c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.insertOne('\x80', 0));
            try expectError(error.OutOfRange, buffer.insertOne('@', 6));
        }

        test "insertVisual" {
            var buffer = try Buffer.initCapacity(18);
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
                try buffer.insertVisual(c.value, c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.insertVisual(&[_]u8{0x80, 0x81, 0x82}, 17));
            try expectError(error.OutOfRange, buffer.insertVisual("@", 17));
            try expectError(error.InvalidPosition, buffer.insertVisual("@", 99));

        }

        test "insertVisualOne" {
            var buffer = try Buffer.init(18, "👨‍🏭");
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
                try buffer.insertVisualOne(c.value, c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.insertVisualOne('\x80', 0));
            try expectError(error.OutOfRange, buffer.insertVisualOne('@', 6));
            try expectError(error.InvalidPosition, buffer.insertVisualOne('@', 99));
        }

        test "append" {
            var buffer = try Buffer.initCapacity(18);
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
                try buffer.append(c.value);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.append(&[_]u8{0x80, 0x81, 0x82}));
            try expectError(error.OutOfRange, buffer.append("@"));
        }

        test "appendOne" {
            var buffer = try Buffer.initCapacity(7);
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
                try buffer.appendOne(c.value);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.appendOne(0x80));
            try expectError(error.OutOfRange, buffer.appendOne('@'));
        }

        test "prepend" {
            var buffer = try Buffer.initCapacity(18);
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
                try buffer.prepend(c.value);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.prepend(&[_]u8{0x80, 0x81, 0x82}));
            try expectError(error.OutOfRange, buffer.prepend("@"));
        }

        test "prependOne" {
            var buffer = try Buffer.initCapacity(7);
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
                try buffer.prependOne(c.value);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            // try expectError(error.InvalidValue, buffer.prependOne(0x80));
            try expectError(error.OutOfRange, buffer.prependOne('@'));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "Buffer.remove" {
            var buffer = try Buffer.init(7, "Hello !");
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
                try buffer.remove(c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            try expectError(error.OutOfRange, buffer.remove(1));
        }

        test "Buffer.removeRange" {
            var buffer = try Buffer.init(7, "Hello !");
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
                try buffer.removeRange(c.pos, c.len);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            try expectError(error.OutOfRange, buffer.removeRange(1, 1));
        }

        test "Buffer.removeVisual" {
            var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
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
                _ = try buffer.removeVisual(c.pos);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            const res = buffer.removeVisual(1);
            try expectError(error.OutOfRange, res);

            var array2 = try Buffer.init(11, "👨‍🏭");
            const res2 = array2.removeVisual(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "Buffer.removeVisualRange" {
            var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
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
                _ = try buffer.removeVisualRange(c.pos, c.len);
                try expectStrings(c.expected, buffer.m_source[0..c.expected.len]);
            }

            // Failure Cases.
            const res = buffer.removeVisualRange(1, 1);
            try expectError(error.OutOfRange, res);

            var array2 = try Buffer.init(11, "👨‍🏭");
            const res2 = array2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "pop" {
            var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
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
                const res = buffer.pop();
                try expectStrings(c.removed, res.?);
                try expectStrings(c.expected, buffer.m_source[0..buffer.length()]);
            }

            // null case
            try expectEqual(null, buffer.pop());
        }

        test "shift" {
            var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
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
                const res = buffer.shift();
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, buffer.m_source[0..buffer.length()]);
            }
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
            try expectStrings("hello 👨‍🏭!", buffer.m_source[0..buffer.length()]);
        }

        test "toUpper" {
            var buffer = try Buffer.init(18, "HeLLo 👨‍🏭!");
            buffer.toUpper();
            try expectStrings("HELLO 👨‍🏭!", buffer.m_source[0..buffer.length()]);
        }

        test "toTitle" {
            var buffer = try Buffer.init(18, "heLLo 👨‍🏭!");
            buffer.toTitle();
            try expectStrings("Hello 👨‍🏭!", buffer.m_source[0..buffer.length()]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "reverse" {
            var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
            buffer.reverse();
            try expectStrings("!👨‍🏭 olleH", buffer.m_source[0..buffer.length()]);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝