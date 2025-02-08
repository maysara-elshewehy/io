// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std               = @import("std");
    const bytes             = @import("./bytes.zig");

    const expect            = std.testing.expect;
    const expectEqual       = std.testing.expectEqual;
    const expectError       = std.testing.expectError;
    const expectStrings     = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "bytes.initWithCapacity" {
            // Success Cases.
            {
                const array = bytes.initWithCapacity(1);
                try expect(array.len == 1);
                try expect(array[0] == 0);

                const array2 = bytes.initWithCapacity(2);
                try expect(array2.len == 2);
                try expect(array2[0] == 0);
                try expect(array2[1] == 0);
            }
        }

        test "bytes.initWithSlice" {
            // Success Cases.
            {
                // Array of bytes.
                const multi_elem_arr = try bytes.initWithSlice(3, "012");
                try expect(multi_elem_arr.len == 3);
                for(0..3) |i| try expect(multi_elem_arr[i] == "012"[i]);

                // Array of bytes (with unfilled elements, automatically terminated with null byte).
                const multi_elem_arr2 = try bytes.initWithSlice(4, "012");
                try expect(multi_elem_arr2.len == 4);
                for(0..4) |i| try expect(multi_elem_arr2[i] == (if(i == 3) 0 else "012"[i]));

                // zero size
                const zero_size_arr = try bytes.initWithSlice(0, "");
                try expect(zero_size_arr.len == 0);
            }

            // Failure cases.
            try expectError(error.OutOfRange, bytes.initWithSlice(1, "AB"));   // Out of range
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "bytes.insertSlice" {
            var array = bytes.initWithCapacity(18);
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
                try bytes.insertSlice(&array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.insertSlice(&array, "@", prev_len, 17));
        }

        test "bytes.insertByte" {
            var array = bytes.initWithCapacity(7);
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
                try bytes.insertByte(&array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, bytes.insertByte(&array, '@', 0, 6));
        }

        test "bytes.visualInsertSlice" {
            var array = bytes.initWithCapacity(18);
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
                try bytes.visualInsertSlice(&array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.visualInsertSlice(&array, "@", prev_len, 17));
            try expectError(error.OutOfRange, bytes.visualInsertSlice(&array, "@", prev_len, 99));
        }

        test "bytes.visualInsertByte" {
            var array = try bytes.initWithSlice(18, "👨‍🏭");
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
                try bytes.visualInsertByte(&array, c.value, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.visualInsertByte(&array, '@', prev_len, 6));
            try expectError(error.OutOfRange, bytes.visualInsertByte(&array, '@', prev_len, 99));
        }

        test "bytes.appendSlice" {
            var array = bytes.initWithCapacity(18);
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
                try bytes.appendSlice(&array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.appendSlice(&array, "@", prev_len));
        }

        test "bytes.appendByte" {
            var array = bytes.initWithCapacity(7);
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
                try bytes.appendByte(&array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.appendByte(&array, '@', prev_len));
        }

        test "bytes.prependSlice" {
            var array = bytes.initWithCapacity(18);
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
                try bytes.prepend(&array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += c.value.len;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.prepend(&array, "@", prev_len));
        }

        test "bytes.prependByte" {
            var array = bytes.initWithCapacity(7);
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
                try bytes.prependByte(&array, c.value, prev_len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len += 1;
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, bytes.prependByte(&array, '@', prev_len));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "bytes.remove" {
            var array = try bytes.initWithSlice(7, "Hello !");
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
                try bytes.removeIndex(&array, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len -= 1;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, bytes.removeIndex(&array, 0, 1));
        }

        test "bytes.removeRange" {
            var array = try bytes.initWithSlice(7, "Hello !");
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
                try bytes.removeRange(&array, prev_len, c.pos, c.len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len -= c.len;
            }

            // Failure Cases.
            try expectError(error.OutOfRange, bytes.removeRange(&array, 0, 1, 1));
        }

        test "bytes.removeVisualIndex" {
            var array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                _ = try bytes.removeVisualIndex(&array, prev_len, c.pos);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len = c.expected.len;
            }

            // Failure Cases.
            const res = bytes.removeVisualIndex(&array, 0, 1);
            try expectError(error.OutOfRange, res);

            var array2 = try bytes.initWithSlice(11, "👨‍🏭");
            const res2 = bytes.removeVisualIndex(&array2, 11, 2);
            try expectError(error.InvalidPosition, res2);
        }

        test "bytes.removeVisualRange" {
            var array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                _ = try bytes.removeVisualRange(&array, prev_len, c.pos, c.len);
                try expectStrings(c.expected, array[0..c.expected.len]);
                prev_len = c.expected.len;
            }

            // Failure Cases.
            const res = bytes.removeVisualRange(&array, 0, 1, 1);
            try expectError(error.OutOfRange, res);

            var array2 = try bytes.initWithSlice(11, "👨‍🏭");
            const res2 = bytes.removeVisualRange(&array2, 11, 2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "bytes.pop" {
            var array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                const res = bytes.pop(array[0..prev_len]);
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, array[0..prev_len-c.removed.len]);
                prev_len -= c.removed.len;
            }
        }

        test "bytes.shift" {
            var array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                const res = bytes.shift(array[0..prev_len]);
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, array[0..prev_len-c.removed.len]);
                prev_len -= c.removed.len;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "bytes.find" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, bytes.find(&array, c.value));
            }
        }

        test "bytes.findVisual" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, bytes.findVisual(&array, c.value));
            }
        }

        test "bytes.findLast" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, bytes.findLast(&array, c.value));
            }
        }

        test "bytes.findLastVisual" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
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
                try expectEqual(c.expected, bytes.findLastVisual(&array, c.value));
            }
        }

        test "bytes.includes" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
            try expect(bytes.includes(&array, "H"));
            try expect(bytes.includes(&array, "e"));
            try expect(bytes.includes(&array, "l"));
            try expect(bytes.includes(&array, "o"));
            try expect(bytes.includes(&array, " "));
            try expect(bytes.includes(&array, "👨‍🏭"));
            try expect(bytes.includes(&array, "!"));
            try expect(!bytes.includes(&array, "@"));
        }

        test "bytes.startsWith" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
            try expect(bytes.startsWith(&array, "H"));
            try expect(!bytes.startsWith(&array, "👨‍🏭"));
        }

        test "bytes.endsWith" {
            const array = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
            try expect(bytes.endsWith(&array, "!"));
            try expect(!bytes.endsWith(&array, "👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "bytes.toLower" {
            var array = try bytes.initWithSlice(18, "HeLLo 👨‍🏭!");
            bytes.toLower(&array);
            try expectStrings("hello 👨‍🏭!", &array);
        }

        test "bytes.toUpper" {
            var array = try bytes.initWithSlice(18, "HeLLo 👨‍🏭!");
            bytes.toUpper(&array);
            try expectStrings("HELLO 👨‍🏭!", &array);
        }

        test "bytes.toTitle" {
            var array = try bytes.initWithSlice(18, "heLLo 👨‍🏭!");
            bytes.toTitle(&array);
            try expectStrings("Hello 👨‍🏭!", &array);
        }

        test "bytes.reverse" {
            var array = try bytes.initWithSlice(5, "Hello");
            bytes.reverse(array[0..5]);
            try expectStrings("olleH", &array);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── DATA ────────────────────────────┐

        test "bytes.countWritten" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 4 }, .{ "👨‍🏭", 11 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], bytes.countWritten(c[0]));
            }

            const array = try bytes.initWithSlice(64, "Hello 👨‍🏭!");
            try expectEqual(18, bytes.countWritten(&array));
        }

        test "bytes.countVisual" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 1 }, .{ "👨‍🏭", 1 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], try bytes.countVisual(c[0]));
            }

            const array = try bytes.initWithSlice(64, "Hello 👨‍🏭!");
            try expectEqual(8, try bytes.countVisual(&array));
        }

        test "bytes.writtenSlice" {
            const array = try bytes.initWithSlice(64, "Hello 🌍!");
            try expectStrings("Hello 🌍!", bytes.writtenSlice(&array));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "bytes.split" {
            const input = "0👨‍🏭11👨‍🏭2👨‍🏭33";
            const array = try bytes.initWithSlice(64, input);

            // Test basic splits
            try expectStrings("0", bytes.split(&array, input.len, "👨‍🏭", 0).?);
            try expectStrings("11", bytes.split(&array, input.len, "👨‍🏭", 1).?);
            try expectStrings("2", bytes.split(&array, input.len, "👨‍🏭", 2).?);
            try expectStrings("33", bytes.split(&array, input.len, "👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(bytes.split(&array, input.len, "👨‍🏭", 4) == null);

            // Test empty input
            try expectStrings("", bytes.split(&array, 0, "👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(input, bytes.split(&array, input.len, "X", 0).?);
        }

        test "bytes.splitAll" {
            const allocator = std.testing.allocator;

            // Consecutive delimiters
            const input1 = "a👨‍🏭👨‍🏭b";
            const parts1 = try bytes.splitAll(allocator, input1, input1.len, "👨‍🏭", true);
            defer allocator.free(parts1);
            try expectStrings("a", parts1[0]);
            try expectStrings("", parts1[1]);
            try expectStrings("b", parts1[2]);

            // Leading/trailing delimiters
            const input2 = "👨‍🏭a👨‍🏭b👨‍🏭";
            const parts2 = try bytes.splitAll(allocator, input2, input2.len, "👨‍🏭", true);
            defer allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // No delimiters
            const input3 = "hello";
            const parts3 = try bytes.splitAll(allocator, input3, input3.len, "👨‍🏭", true);
            defer allocator.free(parts3);
            try expectStrings("hello", parts3[0]);

            // Empty input
            const parts4 = try bytes.splitAll(allocator, "", 0, "👨‍🏭", true);
            defer allocator.free(parts4);
            try expectStrings("", parts4[0]);
        }

        test "bytes.splitAll edge cases" {
            const allocator = std.testing.allocator;

            // Leading/trailing delimiters
            const input2 = "👨‍🏭a👨‍🏭b👨‍🏭";
            const parts2 = try bytes.splitAll(allocator, input2, input2.len, "👨‍🏭", true);
            defer allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try bytes.splitAll(allocator, input2, input2.len, "👨‍🏭", false);
            defer allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "bytes.replaceAllChars" {
            var array = try bytes.initWithSlice(64, "aXb");
            bytes.replaceAllChars(&array, 'X', 'Y');
            try expectStrings("aYb", array[0..3]);
        }

        test "bytes.replaceAllSlices" {
            var array = try bytes.initWithSlice(64, "Hello 👨‍🏭!");
            const res = try bytes.replaceAllSlices(&array, 18, "👨‍🏭", "World");
            try expectStrings("Hello World!", array[0..12]);
            try expectEqual(1, res);

            // OutOfRange
            var array2 = try bytes.initWithSlice(3, "aXb");
            try expectError(error.OutOfRange, bytes.replaceAllSlices(&array2, 3, "X", "YYY"));
        }

        test "bytes.replaceRange" {
            // Case 1: Replacement of same length
            var array1 = try bytes.initWithSlice(64, "Hello 👨‍🏭!");
            try bytes.replaceRange(&array1, 18, 6, 11, "World");
            try expectStrings("Hello World!", array1[0..12]);

            // Case 2: Replacement is shorter than the original range
            var array2 = try bytes.initWithSlice(64, "Hello ZigLang!");
            try bytes.replaceRange(&array2, 14, 6, 7, "Zig");
            try expectStrings("Hello Zig!", array2[0..10]);

            // Case 3: Replacement is longer than the original range
            var array3 = try bytes.initWithSlice(64, "Hello World!");
            try bytes.replaceRange(&array3, 12, 6, 5, "Beautiful World");
            try expectStrings("Hello Beautiful World!", array3[0..22]);

            // Case 4: Replace at the start
            var array4 = try bytes.initWithSlice(18, "1234567890");
            try bytes.replaceRange(&array4, 10, 0, 3, "ABC");
            try expectStrings("ABC4567890", array4[0..10]);

            // Case 5: Replace at the end
            var array5 = try bytes.initWithSlice(18, "abcdef123456");
            try bytes.replaceRange(&array5, 12, 6, 6, "XYZ");
            try expectStrings("abcdefXYZ", array5[0..9]);

            // Case 6: Replace full string
            var array6 = try bytes.initWithSlice(18, "Replace Me!");
            try bytes.replaceRange(&array6, 11, 0, 11, "Done");
            try expectStrings("Done", array6[0..4]);

            // Case 7: Replacement is empty (removal)
            var array7 = try bytes.initWithSlice(18, "DeleteThis");
            try bytes.replaceRange(&array7, 10, 6, 4, "");
            try expectStrings("Delete", array7[0..6]);

            // Case 8: Inserting a string (replace empty range)
            var array8 = try bytes.initWithSlice(18, "Hello!");
            try bytes.replaceRange(&array8, 6, 5, 0, " World");
            try expectStrings("Hello World!", array8[0..12]);

            // Case 9: OutOfRange
            var array9 = try bytes.initWithSlice(3, "aXb");
            try expectError(error.OutOfRange, bytes.replaceRange(&array9, 3, 0, 3, "YYYY"));
        }

        test "bytes.replaceVisualRange" {
            var array1 = try bytes.initWithSlice(18, "Hello 👨‍🏭!");
            try bytes.replaceVisualRange(&array1, 18, 6, 1, "World");
            try expectStrings("Hello World!", array1[0..12]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "bytes.isByte" {
            // True cases.
            try expect(bytes.isByte(0));
            try expect(bytes.isByte(255));

            // False cases.
            try expect(!bytes.isByte(256));
            try expect(!bytes.isByte(-1));
            try expect(!bytes.isByte(@as(u7, 0)));
        }

        test "bytes.isBytes" {
            // True cases.
            try expect(bytes.isBytes(""));
            try expect(bytes.isBytes([_]u8{}));
            try expect(bytes.isBytes(&[_]u8{}));

            try expect(bytes.isBytes("#"));
            try expect(bytes.isBytes([_]u8{0}));
            try expect(bytes.isBytes(&[_]u8{0}));

            // False cases.
            try expect(!bytes.isBytes(0));
            try expect(!bytes.isBytes(1000));
            try expect(!bytes.isBytes('c'));
            try expect(!bytes.isBytes(true));
            try expect(!bytes.isBytes(42));
            try expect(!bytes.isBytes(1.5));
            try expect(!bytes.isBytes([_]u7{0}));
            try expect(!bytes.isBytes(&[_]u7{0}));
        }

        test "bytes.equals" {
            // Case 1: Empty strings
            try expect(bytes.equals("", ""));
            try expect(!bytes.equals("", "a"));

            // Case 2: Strings with only one element
            try expect(bytes.equals("a", "a"));
            try expect(!bytes.equals("a", "b"));

            // Case 3: Strings with multiple elements
            try expect(bytes.equals("abc", "abc"));
            try expect(!bytes.equals("abc", "abcd"));
        }

        test "bytes.isEmpty" {
            try expect(bytes.isEmpty(""));
            try expect(!bytes.isEmpty("a"));
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝