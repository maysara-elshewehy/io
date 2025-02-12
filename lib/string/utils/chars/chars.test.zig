// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std           = @import("std");
    const chars         = @import("./chars.zig");
    const expect        = std.testing.expect;
    const expectEqual   = std.testing.expectEqual;
    const expectError   = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "chars.initWithCapacity" {
            // Success Cases.
            {
                const array = chars.initWithCapacity(u8, 1);
                try expect(array.len == 1);
                try expect(array[0] == 0);

                const array2 = chars.initWithCapacity(u8, 2);
                try expect(array2.len == 2);
                try expect(array2[0] == 0);
                try expect(array2[1] == 0);
            }
        }

        test "chars.initWithSlice" {
            // Success Cases.
            {
                // Array of chars.
                const multi_elem_arr = try chars.initWithSlice(u8, 3, "012");
                try expect(multi_elem_arr.len == 3);
                for(0..3) |i| try expect(multi_elem_arr[i] == "012"[i]);

                // Array of chars (with unfilled elements, automatically terminated with null char).
                const multi_elem_arr2 = try chars.initWithSlice(u8, 4, "012");
                try expect(multi_elem_arr2.len == 4);
                for(0..4) |i| try expect(multi_elem_arr2[i] == (if(i == 3) 0 else "012"[i]));

                // zero size
                const zero_size_arr = try chars.initWithSlice(u8, 0, "");
                try expect(zero_size_arr.len == 0);
            }

            // Failure cases.
            try expectError(error.OutOfRange, chars.initWithSlice(u8, 1, "AB"));   // Out of range
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "chars.insertSlice" {
            var array = chars.initWithCapacity(u8, 18);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.insertSlice(u8, &array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.insertSlice(u8, &array, "@", prev_len, 17));
        }

        test "chars.insertChar" {
            var array = chars.initWithCapacity(u8, 7);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.insertChar(u8, &array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, chars.insertChar(u8, &array, '@', 0, 6));
        }

        test "chars.visualInsertSlice" {
            var array = chars.initWithCapacity(u8, 18);
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = "H", .pos=0 },
                .{ .value  = "👨‍🏭", .expected = "H👨‍🏭", .pos=1 },
                .{ .value  = "o", .expected = "Ho👨‍🏭", .pos=1 },
                .{ .value  = "ell", .expected = "Hello👨‍🏭", .pos=1 },
                .{ .value  = " ", .expected = "Hello 👨‍🏭", .pos=5 },
                .{ .value  = "!", .expected = "Hello 👨‍🏭!", .pos=7 },
                .{ .value  = "", .expected = "Hello 👨‍🏭!", .pos=2 },
            };

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.visualInsertSlice(u8, &array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.visualInsertSlice(u8, &array, "@", prev_len, 17));
            try expectError(error.OutOfRange, chars.visualInsertSlice(u8, &array, "@", prev_len, 99));
        }

        test "chars.visualInsertChar" {
            var array = try chars.initWithSlice(u8, 18, "👨‍🏭");
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

            var prev_len : usize = 11;
            for(cases) |c| {
                try chars.visualInsertChar(u8, &array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.visualInsertChar(u8, &array, '@', prev_len, 6));
            try expectError(error.OutOfRange, chars.visualInsertChar(u8, &array, '@', prev_len, 99));
        }

        test "chars.appendSlice" {
            var array = chars.initWithCapacity(u8, 18);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.appendSlice(u8, &array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.appendSlice(u8, &array, "@", prev_len));
        }

        test "chars.appendChar" {
            var array = chars.initWithCapacity(u8, 7);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.appendChar(u8, &array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.appendChar(u8, &array, '@', prev_len));
        }

        test "chars.prependSlice" {
            var array = chars.initWithCapacity(u8, 18);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.prependSlice(u8, &array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.prependSlice(u8, &array, "@", prev_len));
        }

        test "chars.prependChar" {
            var array = chars.initWithCapacity(u8, 7);
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

            var prev_len : usize = 0;
            for(cases) |c| {
                try chars.prependChar(u8, &array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, chars.prependChar(u8, &array, '@', prev_len));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "chars.removeIndex" {
            var array = try chars.initWithSlice(u8, 7, "Hello !");
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

            var prev_len : usize = 7;

            for(cases) |c| {
                try chars.removeIndex(u8, &array, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len -= 1;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, chars.removeIndex(u8, &array, 0, 1));
        }

        test "chars.removeRange" {
            var array = try chars.initWithSlice(u8, 7, "Hello !");
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

            var prev_len : usize = 7;

            for(cases) |c| {
                try chars.removeRange(u8, &array, prev_len, c.pos, c.len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len -= c.len;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, chars.removeRange(u8, &array, 0, 1, 1));
        }

        test "chars.removeVisualIndex" {
            var array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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

            var prev_len : usize = 18;

            for(cases) |c| {
                _ = try chars.removeVisualIndex(u8, &array, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len = c.expected.len;
            }

            // Failure Cases.
            const res = chars.removeVisualIndex(u8, &array, 0, 1);
            try expectError(error.OutOfRange, res);

            var array2 = try chars.initWithSlice(u8, 11, "👨‍🏭");
            const res2 = chars.removeVisualIndex(u8, &array2, 11, 2);
            try expectError(error.InvalidPosition, res2);
        }

        test "chars.removeVisualRange" {
            var array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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

            var prev_len : usize = 18;

            for(cases) |c| {
                _ = try chars.removeVisualRange(u8, &array, prev_len, c.pos, c.len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len = c.expected.len;
            }

            // Failure Cases.
            const res = chars.removeVisualRange(u8, &array, 0, 1, 1);
            try expectError(error.OutOfRange, res);

            var array2 = try chars.initWithSlice(u8, 11, "👨‍🏭");
            const res2 = chars.removeVisualRange(u8, &array2, 11, 2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "chars.pop" {
            var array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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
                .{ .removed = "",  .expected = "" },
            };

            var prev_len : usize = 18;

            for(cases) |c| {
                const res = chars.pop(u8, array[0..prev_len]);
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, array[0..prev_len-c.removed.len]);
                prev_len -= c.removed.len;
            }
        }

        test "chars.shift" {
            var array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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

            var prev_len : usize = 18;

            for(cases) |c| {
                const res = chars.shift(u8, array[0..prev_len]);
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, array[0..prev_len-c.removed.len]);
                prev_len -= c.removed.len;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "chars.find" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, chars.find(u8, &array, c.value));
            }
        }

        test "chars.findVisual" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, chars.findVisual(u8, &array, c.value));
            }
        }

        test "chars.findLast" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, chars.findLast(u8, &array, c.value));
            }
        }

        test "chars.findLastVisual" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, chars.findLastVisual(u8, &array, c.value));
            }
        }

        test "chars.includes" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
            try expect(chars.includes(u8, &array, "H"));
            try expect(chars.includes(u8, &array, "e"));
            try expect(chars.includes(u8, &array, "l"));
            try expect(chars.includes(u8, &array, "o"));
            try expect(chars.includes(u8, &array, " "));
            try expect(chars.includes(u8, &array, "👨‍🏭"));
            try expect(chars.includes(u8, &array, "!"));
            try expect(!chars.includes(u8, &array, "@"));
        }

        test "chars.startsWith" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
            try expect(chars.startsWith(u8, &array, "H"));
            try expect(!chars.startsWith(u8, &array, "👨‍🏭"));
        }

        test "chars.endsWith" {
            const array = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
            try expect(chars.endsWith(u8, &array, "!"));
            try expect(!chars.endsWith(u8, &array, "👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "chars.toLower" {
            var array = try chars.initWithSlice(u8, 18, "HeLLo 👨‍🏭!");
            chars.toLower(u8, &array);
            try expectStrings("hello 👨‍🏭!", &array);
        }

        test "chars.toUpper" {
            var array = try chars.initWithSlice(u8, 18, "HeLLo 👨‍🏭!");
            chars.toUpper(u8, &array);
            try expectStrings("HELLO 👨‍🏭!", &array);
        }

        test "chars.toTitle" {
            var array = try chars.initWithSlice(u8, 18, "heLLo 👨‍🏭!");
            chars.toTitle(u8, &array);
            try expectStrings("Hello 👨‍🏭!", &array);
        }

        test "chars.reverse" {
            var array = try chars.initWithSlice(u8, 5, "Hello");
            chars.reverse(u8, array[0..5]);
            try expectStrings("olleH", &array);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── DATA ────────────────────────────┐

        test "chars.countWritten" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 4 }, .{ "👨‍🏭", 11 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], chars.countWritten(u8, c[0]));
            }

            const array = try chars.initWithSlice(u8, 64, "Hello 👨‍🏭!");
            try expectEqual(18, chars.countWritten(u8, &array));
        }

        test "chars.countVisual" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 1 }, .{ "👨‍🏭", 1 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], try chars.countVisual(u8, c[0]));
            }

            const array = try chars.initWithSlice(u8, 64, "Hello 👨‍🏭!");
            try expectEqual(8, try chars.countVisual(u8, &array));
        }

        test "chars.writtenSlice" {
            const array = try chars.initWithSlice(u8, 64, "Hello 🌍!");
            try expectStrings("Hello 🌍!", chars.writtenSlice(u8, &array));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "chars.split" {
            const input = "0👨‍🏭11👨‍🏭2👨‍🏭33";
            const array = try chars.initWithSlice(u8, 64, input);

            // Test basic splits
            try expectStrings("0", chars.split(u8, &array, input.len, "👨‍🏭", 0).?);
            try expectStrings("11", chars.split(u8, &array, input.len, "👨‍🏭", 1).?);
            try expectStrings("2", chars.split(u8, &array, input.len, "👨‍🏭", 2).?);
            try expectStrings("33", chars.split(u8, &array, input.len, "👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(chars.split(u8, &array, input.len, "👨‍🏭", 4) == null);

            // Test empty input
            try expectStrings("", chars.split(u8, &array, 0, "👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(input, chars.split(u8, &array, input.len, "X", 0).?);
        }

        test "chars.splitAll" {
            const allocator = std.testing.allocator;

            // Consecutive delimiters
            const input1 = "a👨‍🏭👨‍🏭b";
            const parts1 = try chars.splitAll(u8, allocator, input1, input1.len, "👨‍🏭", true);
            defer allocator.free(parts1);
            try expectStrings("a", parts1[0]);
            try expectStrings("", parts1[1]);
            try expectStrings("b", parts1[2]);

            // Leading/trailing delimiters
            const input2 = "👨‍🏭a👨‍🏭b👨‍🏭";
            const parts2 = try chars.splitAll(u8, allocator, input2, input2.len, "👨‍🏭", true);
            defer allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // No delimiters
            const input3 = "hello";
            const parts3 = try chars.splitAll(u8, allocator, input3, input3.len, "👨‍🏭", true);
            defer allocator.free(parts3);
            try expectStrings("hello", parts3[0]);

            // Empty input
            const parts4 = try chars.splitAll(u8, allocator, "", 0, "👨‍🏭", true);
            defer allocator.free(parts4);
            try expectStrings("", parts4[0]);
        }

        test "chars.splitAll edge cases" {
            const allocator = std.testing.allocator;

            // Leading/trailing delimiters
            const input2 = "👨‍🏭a👨‍🏭b👨‍🏭";
            const parts2 = try chars.splitAll(u8, allocator, input2, input2.len, "👨‍🏭", true);
            defer allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try chars.splitAll(u8, allocator, input2, input2.len, "👨‍🏭", false);
            defer allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "chars.replaceAllChars" {
            var array = try chars.initWithSlice(u8, 64, "aXb");
            chars.replaceAllChars(u8, &array, 'X', 'Y');
            try expectStrings("aYb", array[0..3]);
        }

        test "chars.replaceAllSlices" {
            var array = try chars.initWithSlice(u8, 64, "Hello 👨‍🏭!");
            const res = try chars.replaceAllSlices(u8, &array, 18, "👨‍🏭", "World");
            try expectStrings("Hello World!", array[0..12]);
            try expectEqual(1, res);

            // OutOfRange
            var array2 = try chars.initWithSlice(u8, 3, "aXb");
            try expectError(error.OutOfRange, chars.replaceAllSlices(u8, &array2, 3, "X", "YYY"));
        }

        test "chars.replaceRange" {
            // Case 1: Replacement of same length
            var array1 = try chars.initWithSlice(u8, 64, "Hello 👨‍🏭!");
            try chars.replaceRange(u8, &array1, 18, 6, 11, "World");
            try expectStrings("Hello World!", array1[0..12]);

            // Case 2: Replacement is shorter than the original range
            var array2 = try chars.initWithSlice(u8, 64, "Hello ZigLang!");
            try chars.replaceRange(u8, &array2, 14, 6, 7, "Zig");
            try expectStrings("Hello Zig!", array2[0..10]);

            // Case 3: Replacement is longer than the original range
            var array3 = try chars.initWithSlice(u8, 64, "Hello World!");
            try chars.replaceRange(u8, &array3, 12, 6, 5, "Beautiful World");
            try expectStrings("Hello Beautiful World!", array3[0..22]);

            // Case 4: Replace at the start
            var array4 = try chars.initWithSlice(u8, 18, "1234567890");
            try chars.replaceRange(u8, &array4, 10, 0, 3, "ABC");
            try expectStrings("ABC4567890", array4[0..10]);

            // Case 5: Replace at the end
            var array5 = try chars.initWithSlice(u8, 18, "abcdef123456");
            try chars.replaceRange(u8, &array5, 12, 6, 6, "XYZ");
            try expectStrings("abcdefXYZ", array5[0..9]);

            // Case 6: Replace full string
            var array6 = try chars.initWithSlice(u8, 18, "Replace Me!");
            try chars.replaceRange(u8, &array6, 11, 0, 11, "Done");
            try expectStrings("Done", array6[0..4]);

            // Case 7: Replacement is empty (removal)
            var array7 = try chars.initWithSlice(u8, 18, "DeleteThis");
            try chars.replaceRange(u8, &array7, 10, 6, 4, "");
            try expectStrings("Delete", array7[0..6]);

            // Case 8: Inserting a string (replace empty range)
            var array8 = try chars.initWithSlice(u8, 18, "Hello!");
            try chars.replaceRange(u8, &array8, 6, 5, 0, " World");
            try expectStrings("Hello World!", array8[0..12]);

            // Case 9: OutOfRange
            var array9 = try chars.initWithSlice(u8, 3, "aXb");
            try expectError(error.OutOfRange, chars.replaceRange(u8, &array9, 3, 0, 3, "YYYY"));
        }

        test "chars.replaceVisualRange" {
            var array1 = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");
            try chars.replaceVisualRange(u8, &array1, 18, 6, 1, "World");
            try expectStrings("Hello World!", array1[0..12]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "chars.isChar" {
            // True cases.
            try expect(chars.isChar(u8, 0));
            try expect(chars.isChar(u8, 255));

            // False cases.
            try expect(!chars.isChar(u8, 256));
            try expect(!chars.isChar(u8, -1));
            try expect(!chars.isChar(u8, @as(u7, 0)));
        }

        test "chars.isSlice" {
            // True cases.
            try expect(chars.isSlice(u8, ""));
            try expect(chars.isSlice(u8, [_]u8{}));
            try expect(chars.isSlice(u8, &[_]u8{}));

            try expect(chars.isSlice(u8, "#"));
            try expect(chars.isSlice(u8, [_]u8{0}));
            try expect(chars.isSlice(u8, &[_]u8{0}));

            // False cases.
            try expect(!chars.isSlice(u8, 0));
            try expect(!chars.isSlice(u8, 1000));
            try expect(!chars.isSlice(u8, 'c'));
            try expect(!chars.isSlice(u8, true));
            try expect(!chars.isSlice(u8, 42));
            try expect(!chars.isSlice(u8, 1.5));
            try expect(!chars.isSlice(u8, [_]u7{0}));
            try expect(!chars.isSlice(u8, &[_]u7{0}));
        }

        test "chars.equals" {
            // Case 1: Empty strings
            try expect(chars.equals(u8, "", ""));
            try expect(!chars.equals(u8, "", "a"));

            // Case 2: Strings with only one element
            try expect(chars.equals(u8, "a", "a"));
            try expect(!chars.equals(u8, "a", "b"));

            // Case 3: Strings with multiple elements
            try expect(chars.equals(u8, "abc", "abc"));
            try expect(!chars.equals(u8, "abc", "abcd"));
        }

        test "chars.isEmpty" {
            try expect(chars.isEmpty(u8, ""));
            try expect(!chars.isEmpty(u8, "a"));
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝