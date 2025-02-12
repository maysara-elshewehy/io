// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std           = @import("std");
    const root          = @import("./string.zig");
    const utils         = root.utils;
    const Buffer        = root.Buffer;
    const Viewer        = root.Viewer;
    const String        = root.String;
    const uString       = root.uString;
    const expect        = std.testing.expect;
    const expectEqual   = std.testing.expectEqual;
    const expectError   = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;
    const Allocator     = std.testing.allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Utils ══════════════════════════════════════╗

    test "utils" {
        _ = @import("./utils/utils.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Viewer ═════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "Viewer(u8).initEmpty" {
            const s = Viewer(u8).initEmpty();
            try expectEqual(0, s.len());
            try expectEqual(0, s.size());
            try expectStrings("", s.src());
        }

        test "Viewer(u8).initWithSlice" {
            const s = Viewer(u8).initWithSlice("Hello");
            try expectEqual(5, s.len());
            try expectEqual(5, s.size());
            try expectStrings("Hello", s.src());
        }

        test "Viewer(u8).initWithSelf" {
            const s = Viewer(u8).initWithSlice("Hello");
            const s2 = Viewer(u8).initWithSelf(s);
            try expectEqual(5, s2.len());
            try expectEqual(5, s2.size());
            try expectStrings("Hello", s2.src());
        }

        test "Viewer(u8).init (all types)" {
            // with slice
            const s = try Viewer(u8).init("H");
            try expectEqual(1, s.len());
            try expectEqual(1, s.size());
            try expectStrings("H", s.src());

            // with self
            const s2 = try Viewer(u8).init(s);
            try expectEqual(1, s2.len());
            try expectEqual(1, s2.size());
            try expectStrings("H", s2.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "Viewer(u8).find" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.find(c.value));
            }
        }

        test "Viewer(u8).findVisual" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findVisual(c.value));
            }
        }

        test "Viewer(u8).findLast" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findLast(c.value));
            }
        }

        test "Viewer(u8).findLastVisual" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findLastVisual(c.value));
            }
        }

        test "Viewer(u8).includes" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

            try expect(s.includes("H"));
            try expect(s.includes("e"));
            try expect(s.includes("l"));
            try expect(s.includes("o"));
            try expect(s.includes(" "));
            try expect(s.includes("👨‍🏭"));
            try expect(s.includes("!"));
            try expect(!s.includes("@"));
        }

        test "Viewer(u8).startsWith" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

            try expect(s.startsWith("H"));
            try expect(!s.startsWith("👨‍🏭"));
        }

        test "Viewer(u8).endsWith" {
            var s = Viewer(u8).initWithSlice("Hello 👨‍🏭!");

            try expect(s.endsWith("!"));
            try expect(!s.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Check ───────────────────────────┐

        test "Viewer(u8).isEqual" {
            const s1 = Viewer(u8).initWithSlice("Hello, World!");
            const s2 = Viewer(u8).initWithSlice("Hello, World!");
            const s3 = Viewer(u8).initWithSlice("Goodbye, World!");

            try expect(s1.isEqual(s2.src()));
            try expect(!s1.isEqual(s3.src()));
        }

        test "Viewer(u8).isEmpty" {
            const empty = Viewer(u8).initWithSlice("");
            const nonEmpty = Viewer(u8).initWithSlice("Hello, World!");

            try expect(empty.isEmpty());
            try expect(!nonEmpty.isEmpty());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "Viewer(u8).iterator" {
            var s = Viewer(u8).initWithSlice("!👨‍🏭@👨‍🏭#");
            var iter = s.iterator();

            while(iter.nextCodepointSlice()) |slice| {
                try expect(utils.unicode.Utf8Validate(slice));
            }

            // Ensure all characters were iterated
            try expectEqual("!👨‍🏭@👨‍🏭#".len, iter.pos);
        }

        test "Viewer(u8).charAt and Viewer(u8).atVisual and Viewer(u8).sub" {
            var s = Viewer(u8).initWithSlice("!👨‍🏭@👨‍🏭#");

            try expectEqual('!',  s.charAt(0).?);
            try expectEqual('@',  s.charAt(12).?);
            try expectEqual('#',  s.charAt(24).?);
            try expectEqual(null, s.charAt(25));

            try expectStrings("!",  s.atVisual(0).?);
            try expectStrings("👨‍🏭",  s.atVisual(1).?);
            try expectStrings("@",  s.atVisual(2).?);
            try expectStrings("👨‍🏭",  s.atVisual(3).?);
            try expectStrings("#",  s.atVisual(4).?);
            try expectEqual(null, s.atVisual(5));

            try expectStrings("👨‍🏭", try s.sub(1, 12));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "Viewer(u8).split" {
            var s = try Viewer(u8).init("0👨‍🏭11👨‍🏭2👨‍🏭33");

            // Test basic splits
            try expectStrings("0", s.split("👨‍🏭", 0).?);
            try expectStrings("11", s.split("👨‍🏭", 1).?);
            try expectStrings("2", s.split("👨‍🏭", 2).?);
            try expectStrings("33", s.split("👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(s.split("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = Viewer(u8).initEmpty();
            try expectStrings("", s2.split("👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(s.src(), s.split("X", 0).?);
        }

        test "Viewer(u8).splitAll" {
            // Leading/trailing delimiters
            var s = try Viewer(u8).init("👨‍🏭a👨‍🏭b👨‍🏭");

            const parts2 = try s.splitAll(Allocator, "👨‍🏭", true);
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try s.splitAll(Allocator, "👨‍🏭", false);
            defer Allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

        test "Viewer(u8).splitToSelf" {
            var s = try Viewer(u8).init("0👨‍🏭11👨‍🏭2👨‍🏭33");

            // Test basic splits
            if(s.splitToSelf( "👨‍🏭", 0)) |res| {
                try expectStrings("0", res.src());
            }
            if(s.splitToSelf("👨‍🏭", 1)) |res| {
                try expectStrings("11", res.src());
            }
            if(s.splitToSelf("👨‍🏭", 2)) |res| {
                try expectStrings("2", res.src());
            }
            if(s.splitToSelf("👨‍🏭", 3)) |res| {
                try expectStrings("33", res.src());
            }

            // Test out-of-bounds indices
            try expect(s.splitToSelf("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = Buffer(u8, 100).initEmpty();
            try expectStrings("", (try s2.splitToSelf("👨‍🏭", 0)).?.src());

            // Test non-existent delimiter
            if(s.splitToSelf("X", 0)) |res| {
                try expectStrings(s.src(), res.src());
            }
        }

        test "Viewer(u8).splitAllToSelf" {
            // Leading/trailing delimiters
            var s = try Viewer(u8).init("👨‍🏭a👨‍🏭b👨‍🏭");

            const parts2 = try s.splitAllToSelf(Allocator, "👨‍🏭");
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0].src());
            try expectStrings("a", parts2[1].src());
            try expectStrings("b", parts2[2].src());
            try expectStrings("", parts2[3].src());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Buffer ═════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "Buffer(u8, N).initEmpty" {
            const s = Buffer(u8, 16).initEmpty();
            try expectEqual(0, s.len());
            try expectEqual(16, s.size());
            try expectStrings("", s.src());
        }

        test "Buffer(u8, N).initWithSlice" {
            const s = Buffer(u8, 16).initWithSlice("Hello");
            try expectEqual(5, s.len());
            try expectEqual(16, s.size());
            try expectStrings("Hello", s.src());
        }

        test "Buffer(u8, N).initWithChar" {
            const s = Buffer(u8, 16).initWithChar('H');
            try expectEqual(1, s.len());
            try expectEqual(16, s.size());
            try expectStrings("H", s.src());
        }

        test "Buffer(u8, N).initWithSelf" {
            const s = Buffer(u8, 16).initWithSlice("Hello");
            const s2 = Buffer(u8, 16).initWithSelf(s);
            try expectEqual(5, s2.len());
            try expectEqual(16, s2.size());
            try expectStrings("Hello", s2.src());
        }

        test "Buffer(u8, N).initWithFmt" {
            var s = try Buffer(u8, 20).initWithFmt("{s}", .{"Hello"});
            try expectStrings("Hello", s.src());

            var s2 = try Buffer(u8, 20).initWithFmt("{s} {s}", .{"Hello", "World"});
            try expectStrings("Hello World", s2.src());

            var s3 = try Buffer(u8, 20).initWithFmt("{s}{s}", .{"Hello", "!"});
            try expectStrings("Hello!", s3.src());

            const s4 = Buffer(u8, 2).initWithFmt("{s}{s}", .{"Hello", "!"});
            try expectError(error.OutOfMemory, s4);
        }

        test "Buffer(u8, N).init (all types)" {
            // with char
            const s = try Buffer(u8, 16).init('H');
            try expectEqual(1, s.len());
            try expectEqual(16, s.size());
            try expectStrings("H", s.src());

            // with slice
            const s2 = try Buffer(u8, 16).init("H");
            try expectEqual(1, s2.len());
            try expectEqual(16, s2.size());
            try expectStrings("H", s2.src());

            // with self
            const s3 = try Buffer(u8, 16).init(s2);
            try expectEqual(1, s3.len());
            try expectEqual(16, s3.size());
            try expectStrings("H", s3.src());

            // with positive integer
            const s4 = try Buffer(u8, 16).init(2099);
            try expectEqual(4, s4.len());
            try expectEqual(16, s4.size());
            try expectStrings("2099", s4.src());

            // with negative integer
            const s5 = try Buffer(u8, 16).init(-2099);
            try expectEqual(5, s5.len());
            try expectEqual(16, s5.size());
            try expectStrings("-2099", s5.src());

            // with float
            const s6 = try Buffer(u8, 16).init(20.99);
            try expectEqual(7, s6.len());
            try expectEqual(16, s6.size());
            try expectStrings("2.099e1", s6.src());

            // with small integer (not a character)
            // rules
            // 1. u8 is a character.
            // 2. comptime_int between the `u8` range is a character.
            const s7 = try Buffer(u8, 16).init(@as(u16, 2));
            try expectEqual(1, s7.len());
            try expectEqual(16, s7.size());
            try expectStrings("2", s7.src());

            // with boolean
            const s8 = try Buffer(u8, 16).init(true);
            try expectEqual(4, s8.len());
            try expectEqual(16, s8.size());
            try expectStrings("true", s8.src());

            // with array (not a s)
            const arr = [_]bool{ true, false };
            const s9 = try Buffer(u8, 16).init(arr);
            try expectEqual(15, s9.len());
            try expectEqual(16, s9.size());
            try expectStrings("{ true, false }", s9.src());

            // with structure
            const s10 = try Buffer(u8, 256).init(.{ .value = "Hello" });
            try expectEqual(256, s10.size());
            // the `id` of the struct changed every time, so i will comment it.
            // try expectEqual(100, s10.len());
            // try expectStrings("String(u8).String(u8).test.test.Buffer(u8, N).init (with char)__struct_26510{ .value = { 72, 101, 108, 108, 111 } }", s10.src());

            // with null
            const s11 = try Buffer(u8, 16).init(null);
            try expectEqual(4, s11.len());
            try expectEqual(16, s11.size());
            try expectStrings("null", s11.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "Buffer(u8, N).insertSlice" {
            var s = Buffer(u8, 19).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=19 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=19 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=19 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=19 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=19 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=19 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=19 },
            };

            for(cases) |c| {
                try s.insertSlice(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertSlice("@", 19));
            try s.insertSlice("@", 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.insertSlice("@", 0));
        }

        test "Buffer(u8, N).insertChar" {
            var s = Buffer(u8, 4).initEmpty();

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "H",            .pos=0, .size=4 },
                .{ .value  = '!', .expected = "H!",           .pos=1, .size=4 },
                .{ .value  = 'o', .expected = "Ho!",          .pos=1, .size=4 },
            };

            for(cases) |c| {
                try s.insertChar(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertChar('@', 4));
            try s.insertChar('@', 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.insertChar(0, 0));
        }

        test "Buffer(u8, N).insertSelf" {
            var s = Buffer(u8, 19).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=19 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=19 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=19 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=19 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=19 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=19 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=19 },
            };

            for(cases) |c| {
                const o = Buffer(u8, 19).initWithSlice(c.value);
                try s.insertSelf(o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertSelf(Buffer(u8, 19).initWithSlice("@"), 19));
            try s.insertSelf(Buffer(u8, 19).initWithSlice("@"), 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.insertSelf(Buffer(u8, 19).initWithSlice("@"), 0));
        }

        test "Buffer(u8, N).insertFmt" {
            var s = Buffer(u8, 19).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=19 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=19 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=19 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=19 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=19 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=19 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=19 },
            };

            for(cases) |c| {
                try s.insertFmt("{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertFmt("{s}", .{"@"}, 19));
            try s.insertFmt("{s}", .{"@"}, 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.insertFmt("{s}", .{"@"}, 0));
        }

        test "Buffer(u8, N).insert" {
            var s = Buffer(u8, 19).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=19 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=19 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=19 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=19 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=19 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=19 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=19 },
            };

            for(cases) |c| {
                try s.insert(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insert("@", 19));
            try s.insert("@", 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.insert("@", 0));
        }

        test "Buffer(u8, N).visualInsertSlice" {
            var s = Buffer(u8, 20).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=20 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=20 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=20 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=20 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=20 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertSlice(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertSlice("@", 20));
            try s.insertChar('@', 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.visualInsertSlice("@", 0));
        }

        test "Buffer(u8, N).visualInsertChar" {
            var s = Buffer(u8, 15).initWithSlice("👨‍🏭");

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H', .expected = "👨‍🏭H",            .pos=1, .size=15 },
                .{ .value  = '!', .expected = "👨‍🏭H!",           .pos=2, .size=15 },
                .{ .value  = 'o', .expected = "👨‍🏭Ho!",          .pos=2, .size=15 },
            };

            for(cases) |c| {
                try s.visualInsertChar(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertChar('@', 15));
            try s.visualInsertChar('@', 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.visualInsertChar(0, 0));
        }

        test "Buffer(u8, N).visualInsertSelf" {
            var s = Buffer(u8, 20).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=20 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=20 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=20 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=20 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=20 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=2, .size=20 },
            };

            for(cases) |c| {
                const o = Buffer(u8, 20).initWithSlice(c.value);
                try s.visualInsertSelf(o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertSelf(Buffer(u8, 20).initWithSlice("@"), 20));
            try s.insertSelf(Buffer(u8, 20).initWithSlice("@"), 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.visualInsertSelf(Buffer(u8, 20).initWithSlice("@"), 0));
        }

        test "Buffer(u8, N).visualInsertFmt" {
            var s = Buffer(u8, 20).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=20 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=20 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=20 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=20 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=20 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertFmt("{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertFmt("{s}", .{"@"}, 20));
            try s.visualInsertFmt("{s}", .{"@"}, 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.visualInsertFmt("{s}", .{"@"}, 0));
        }

        test "Buffer(u8, N).visualInsert" {
            var s = Buffer(u8, 20).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=20 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=20 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=20 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=20 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=20 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsert(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsert("@", 20));
            try s.visualInsert("@", 0); // add one to be full for the next test
            try expectError(error.OutOfMemory, s.visualInsert("@", 0));
        }

        test "Buffer(u8, N).appendSlice" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",           .size=18 },
                .{ .value  = "e",   .expected = "He",          .size=18 },
                .{ .value  = "llo", .expected = "Hello",       .size=18 },
                .{ .value  = " ",   .expected = "Hello ",      .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭",    .size=18 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!",   .size=18 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",   .size=18 },
            };

            for(cases) |c| {
                try s.appendSlice(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.appendSlice("@"));
        }

        test "Buffer(u8, N).appendChar" {
            var s = Buffer(u8, 6).initEmpty();

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value = 'H', .expected = "H", .size = 6 },
                .{ .value = 'e', .expected = "He", .size = 6 },
                .{ .value = 'l', .expected = "Hel", .size = 6 },
                .{ .value = 'l', .expected = "Hell", .size = 6 },
                .{ .value = 'o', .expected = "Hello", .size = 6 },
                .{ .value = '!', .expected = "Hello!", .size = 6 },
            };

            for (cases) |c| {
                try s.appendChar(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.appendChar('@'));
        }

        test "Buffer(u8, N).appendSelf" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",           .size=18 },
                .{ .value  = "e",   .expected = "He",          .size=18 },
                .{ .value  = "llo", .expected = "Hello",       .size=18 },
                .{ .value  = " ",   .expected = "Hello ",      .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭",    .size=18 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!",   .size=18 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",   .size=18 },
            };

            for(cases) |c| {
                const o = Buffer(u8, 18).initWithSlice(c.value);
                try s.appendSelf(o);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.appendSelf(Buffer(u8, 18).initWithSlice("@")));
        }

        test "Buffer(u8, N).appendFmt" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",           .size=18 },
                .{ .value  = "e",   .expected = "He",          .size=18 },
                .{ .value  = "llo", .expected = "Hello",       .size=18 },
                .{ .value  = " ",   .expected = "Hello ",      .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭",    .size=18 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!",   .size=18 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",   .size=18 },
            };

            for(cases) |c| {
                try s.appendFmt("{s}", .{c.value});
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.appendFmt("{s}", .{"@"}));
        }

        test "Buffer(u8, N).append" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",           .size=18 },
                .{ .value  = "e",   .expected = "He",          .size=18 },
                .{ .value  = "llo", .expected = "Hello",       .size=18 },
                .{ .value  = " ",   .expected = "Hello ",      .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭",    .size=18 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!",   .size=18 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",   .size=18 },
            };

            for(cases) |c| {
                try s.append(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.append("@"));
        }

        test "Buffer(u8, N).prependSlice" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .size=18 },
                .{ .value  = "e",   .expected = "eH",           .size=18 },
                .{ .value  = "oll", .expected = "olleH",        .size=18 },
                .{ .value  = " ",   .expected = " olleH",       .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH",     .size=18 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH",    .size=18 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH",    .size=18 },
            };

            for (cases) |c| {
                try s.prependSlice(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.prependSlice("@"));
        }

        test "Buffer(u8, N).prependChar" {
            var s = Buffer(u8, 6).initEmpty();

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value = 'H', .expected = "H", .size = 6 },
                .{ .value = 'e', .expected = "eH", .size = 6 },
                .{ .value = 'l', .expected = "leH", .size = 6 },
                .{ .value = 'l', .expected = "lleH", .size = 6 },
                .{ .value = 'o', .expected = "olleH", .size = 6 },
                .{ .value = '!', .expected = "!olleH", .size = 6 },
            };

            for (cases) |c| {
                try s.prependChar(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.prependChar('@'));
        }

        test "Buffer(u8, N).prependSelf" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .size=18 },
                .{ .value  = "e",   .expected = "eH",           .size=18 },
                .{ .value  = "oll", .expected = "olleH",        .size=18 },
                .{ .value  = " ",   .expected = " olleH",       .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH",     .size=18 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH",    .size=18 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH",    .size=18 },
            };

            for (cases) |c| {
                const o = Buffer(u8, 18).initWithSlice(c.value);
                try s.prependSelf(o);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.prependSelf(Buffer(u8, 18).initWithSlice("@")));
        }

        test "Buffer(u8, N).prependFmt" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .size=18 },
                .{ .value  = "e",   .expected = "eH",           .size=18 },
                .{ .value  = "oll", .expected = "olleH",        .size=18 },
                .{ .value  = " ",   .expected = " olleH",       .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH",     .size=18 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH",    .size=18 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH",    .size=18 },
            };

            for (cases) |c| {
                try s.prependFmt("{s}", .{c.value});
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.prependFmt("{s}", .{"@"}));
        }

        test "Buffer(u8, N).prepend" {
            var s = Buffer(u8, 18).initEmpty();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .size=18 },
                .{ .value  = "e",   .expected = "eH",           .size=18 },
                .{ .value  = "oll", .expected = "olleH",        .size=18 },
                .{ .value  = " ",   .expected = " olleH",       .size=18 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH",     .size=18 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH",    .size=18 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH",    .size=18 },
            };

            for (cases) |c| {
                try s.prepend(c.value);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfMemory, s.prependSlice("@"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "Buffer(u8, N).removeIndex" {
            var s = Buffer(u8, 20).initWithSlice("Hello !");

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
                try s.removeIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeIndex(1));
        }

        test "Buffer(u8, N).removeVisualIndex" {
            var s = Buffer(u8, 20).initWithSlice("Hello 👨‍🏭!");

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
                _ = try s.removeVisualIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualIndex(1);
            try expectError(error.OutOfRange, res);

            var s2 = Buffer(u8, 20).initWithSlice("👨‍🏭");

            const res2 = s2.removeVisualIndex(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "Buffer(u8, N).removeRange" {
            var s = Buffer(u8, 20).initWithSlice("Hello !");

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
                try s.removeRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeRange(1, 1));
        }

        test "Buffer(u8, N).removeVisualRange" {
            var s = Buffer(u8, 20).initWithSlice("Hello 👨‍🏭!");

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
                _ = try s.removeVisualRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualRange(1, 1);
            try expectError(error.OutOfRange, res);

            var s2 = Buffer(u8, 20).initWithSlice("👨‍🏭");

            const res2 = s2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "Buffer(u8, N).pop" {
            var s = Buffer(u8, 20).initWithSlice("Hello 👨‍🏭!");

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
                const res = s.pop();
                try expectStrings(c.removed, res.?);
                try expectStrings(c.expected, s.src());
            }

            // null case
            try expectEqual(null, s.pop());
        }

        test "Buffer(u8, N).shift" {
            var s = Buffer(u8, 20).initWithSlice("Hello 👨‍🏭!");

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
                const res = s.shift();
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, s.src());
            }
        }

        test "Buffer(u8, N).trimStart" {
            var s = Buffer(u8, 64).initWithSlice("   Hello 👨‍🏭!");
            s.trimStart(); // x1 (remove empty spaces)
            s.trimStart(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "Buffer(u8, N).trimEnd" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!    ");
            s.trimEnd(); // x1 (remove empty spaces)
            s.trimEnd(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "Buffer(u8, N).trim" {
            var s = Buffer(u8, 64).initWithSlice("    Hello 👨‍🏭!    ");
            s.trim(); // x1 (remove empty spaces)
            s.trim(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "Buffer(u8, N).replaceRange" {
            var s = try Buffer(u8, 64).init("Hello 👨‍🏭!");
            try s.replaceRange(6, 11, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "Buffer(u8, N).replaceVisualRange" {
            var s = try Buffer(u8, 64).init("Hello 👨‍🏭!");
            try s.replaceVisualRange(6, 1, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "Buffer(u8, N).replaceFirst" {
            var s = try Buffer(u8, 64).init("Hello 👨‍🏭👨‍🏭!");
            try s.replaceFirst("👨‍🏭", "World");
            try expectStrings("Hello World👨‍🏭!", s.src());
        }

        test "Buffer(u8, N).replaceFirstN" {
            var s = try Buffer(u8, 100).init("Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            try s.replaceFirstN("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceFirstN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorld👨‍🏭!", s.src());
            try s.replaceFirstN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "Buffer(u8, N).replaceLast" {
            var s = try Buffer(u8, 64).init("Hello 👨‍🏭👨‍🏭!");
            try s.replaceLast("👨‍🏭", "World");
            try expectStrings("Hello 👨‍🏭World!", s.src());
        }

        test "Buffer(u8, N).replaceLastN" {
            var s = try Buffer(u8, 100).init("Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            try s.replaceLastN("👨‍🏭", "World", 1);
            try expectStrings("Hello 👨‍🏭👨‍🏭👨‍🏭World!", s.src());
            try s.replaceLastN("👨‍🏭", "World", 2);
            try expectStrings("Hello 👨‍🏭WorldWorldWorld!", s.src());
            try s.replaceLastN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "Buffer(u8, N).replaceAll" {
            var s = try Buffer(u8, 64).init("Hello 👨‍🏭👨‍🏭!");
            try s.replaceAll("👨‍🏭", "World");
            try expectStrings("Hello WorldWorld!", s.src());
        }

        test "Buffer(u8, N).replaceNth" {
            var s = try Buffer(u8, 100).init("Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            try s.replaceNth("👨‍🏭", "World", 0);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceNth("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭World👨‍🏭!", s.src());
            try s.replaceNth("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭WorldWorld!", s.src());
            try s.replaceNth("👨‍🏭", "World", 0);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Repeat ───────────────────────────┐

        test "Buffer(u8, N).repeat" {
            var s = Buffer(u8, 10).initEmpty();

            // add 'H'x0
            try s.repeat('H', 0);
            try expectStrings("", s.src());
            try expectEqual(0, s.len());

            // add 'H'x5
            try s.repeat('H', 5);
            try expectStrings("HHHHH", s.src());
            try expectEqual(5, s.len());

            // add '@'x5
            try s.repeat( '@', 5);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());

            // add '@'x0
            try s.repeat('@', 0);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "Buffer(u8, N).find" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.find(c.value));
            }
        }

        test "Buffer(u8, N).findVisual" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findVisual(c.value));
            }
        }

        test "Buffer(u8, N).findLast" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findLast(c.value));
            }
        }

        test "Buffer(u8, N).findLastVisual" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

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
                try expectEqual(c.expected, s.findLastVisual(c.value));
            }
        }

        test "Buffer(u8, N).includes" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

            try expect(s.includes("H"));
            try expect(s.includes("e"));
            try expect(s.includes("l"));
            try expect(s.includes("o"));
            try expect(s.includes(" "));
            try expect(s.includes("👨‍🏭"));
            try expect(s.includes("!"));
            try expect(!s.includes("@"));
        }

        test "Buffer(u8, N).startsWith" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

            try expect(s.startsWith("H"));
            try expect(!s.startsWith("👨‍🏭"));
        }

        test "Buffer(u8, N).endsWith" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

            try expect(s.endsWith("!"));
            try expect(!s.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "Buffer(u8, N).toLower" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

            s.toLower();
            try expectStrings("hello 👨‍🏭!", s.src());
        }

        test "Buffer(u8, N).toUpper" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");

            s.toUpper();
            try expectStrings("HELLO 👨‍🏭!", s.src());
        }

        test "Buffer(u8, N).toTitle" {
            var s = Buffer(u8, 64).initWithSlice("heLLo 👨‍🏭!");

            s.toTitle();
            try expectStrings("Hello 👨‍🏭!", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Check ───────────────────────────┐

        test "Buffer(u8, N).isEqual" {
            const s1 = Buffer(u8, 64).initWithSlice("Hello, World!");
            const s2 = Buffer(u8, 64).initWithSlice("Hello, World!");
            const s3 = Buffer(u8, 64).initWithSlice("Goodbye, World!");

            try expect(s1.isEqual(s2.src()));
            try expect(!s1.isEqual(s3.src()));
        }

        test "Buffer(u8, N).isEmpty" {
            const empty = Buffer(u8, 64).initWithSlice("");
            const nonEmpty = Buffer(u8, 64).initWithSlice("Hello, World!");

            try expect(empty.isEmpty());
            try expect(!nonEmpty.isEmpty());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "Buffer(u8, N).Writer.write" {
            var s = Buffer(u8, 20).initEmpty();
            var writer = s.writer();

            _ = try writer.write("Hello");
            try expectStrings("Hello", s.src());

            _ = try writer.write(" World");
            try expectStrings("Hello World", s.src());

            _ = try writer.write("!");
            try expectStrings("Hello World!", s.src());
        }

        test "Buffer(u8, N).iterator" {
            var s = Buffer(u8, 64).initWithSlice("!👨‍🏭@👨‍🏭#");
            var iter = s.iterator();

            while(iter.nextCodepointSlice()) |slice| {
                try expect(utils.unicode.Utf8Validate(slice));
            }

            // Ensure all characters were iterated
            try expectEqual("!👨‍🏭@👨‍🏭#".len, iter.pos);
        }

        test "Buffer(u8, N).charAt and Buffer(u8, N).atVisual and Buffer(u8, N).sub" {
            var s = Buffer(u8, 64).initWithSlice("!👨‍🏭@👨‍🏭#");

            try expectEqual('!',  s.charAt(0).?);
            try expectEqual('@',  s.charAt(12).?);
            try expectEqual('#',  s.charAt(24).?);
            try expectEqual(null, s.charAt(25));

            try expectStrings("!",  s.atVisual(0).?);
            try expectStrings("👨‍🏭",  s.atVisual(1).?);
            try expectStrings("@",  s.atVisual(2).?);
            try expectStrings("👨‍🏭",  s.atVisual(3).?);
            try expectStrings("#",  s.atVisual(4).?);
            try expectEqual(null, s.atVisual(5));

            try expectStrings("👨‍🏭", try s.sub(1, 12));
        }

        test "Buffer(u8, N).cString" {
            var s = Buffer(u8, 64).initWithSlice("!👨‍🏭@👨‍🏭#");

            const c_string = try s.cString();

            try expectStrings("!👨‍🏭@👨‍🏭#", c_string);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "Buffer(u8, N).split" {
            var s = try Buffer(u8, 100).init("0👨‍🏭11👨‍🏭2👨‍🏭33");

            // Test basic splits
            try expectStrings("0", s.split("👨‍🏭", 0).?);
            try expectStrings("11", s.split("👨‍🏭", 1).?);
            try expectStrings("2", s.split("👨‍🏭", 2).?);
            try expectStrings("33", s.split("👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(s.split("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = Buffer(u8, 100).initEmpty();
            try expectStrings("", s2.split("👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(s.src(), s.split("X", 0).?);
        }

        test "Buffer(u8, N).splitAll" {
            // Leading/trailing delimiters
            var s = try Buffer(u8, 100).init("👨‍🏭a👨‍🏭b👨‍🏭");

            const parts2 = try s.splitAll(Allocator, "👨‍🏭", true);
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try s.splitAll(Allocator, "👨‍🏭", false);
            defer Allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

        test "Buffer(u8, N).splitToSelf" {
            var s = try Buffer(u8, 100).init("0👨‍🏭11👨‍🏭2👨‍🏭33");

            // Test basic splits
            if(try s.splitToSelf( "👨‍🏭", 0)) |res| {
                try expectStrings("0", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 1)) |res| {
                try expectStrings("11", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 2)) |res| {
                try expectStrings("2", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 3)) |res| {
                try expectStrings("33", res.src());
            }

            // Test out-of-bounds indices
            try expect(try s.splitToSelf("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = Buffer(u8, 100).initEmpty();
            try expectStrings("", (try s2.splitToSelf("👨‍🏭", 0)).?.src());

            // Test non-existent delimiter
            if(try s.splitToSelf("X", 0)) |res| {
                try expectStrings(s.src(), res.src());
            }
        }

        test "Buffer(u8, N).splitAllToSelf" {
            // Leading/trailing delimiters
            var s = try Buffer(u8, 100).init("👨‍🏭a👨‍🏭b👨‍🏭");

            const parts2 = try s.splitAllToSelf(Allocator, "👨‍🏭");
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0].src());
            try expectStrings("a", parts2[1].src());
            try expectStrings("b", parts2[2].src());
            try expectStrings("", parts2[3].src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "Buffer(u8, N).reverse" {
            var s = Buffer(u8, 64).initWithSlice("Hello 👨‍🏭!");
            s.reverse();
            try expectStrings("!👨‍🏭 olleH", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ uString ═════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "uString(u8).initEmpty" {
            const s = uString(u8).initEmpty();
            try expectEqual(0, s.len());
            try expectEqual(0, s.size());
            try expectStrings("", s.src());
        }

        test "uString(u8).initWithAllocator" {
            const s = try uString(u8).initWithAllocator(Allocator);
            try expectEqual(0, s.len());
            try expectEqual(0, s.size());
            try expectStrings("", s.src());
        }

        test "uString(u8).initWithCapacity" {
            var s = try uString(u8).initWithCapacity(Allocator, 10);
            defer s.deinit(Allocator);
            try expectEqual(0, s.len());
            try expectEqual(10, s.size());
            try expectStrings("", s.src());

            // zero
            const s2 = try uString(u8).initWithCapacity(Allocator, 0);
            try expectEqual(0, s2.len());
            try expectEqual(0, s2.size());
            try expectStrings("", s2.src());
        }

        test "uString(u8).initWithSlice" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello");
            defer s.deinit(Allocator);
            try expectEqual(5, s.len());
            try expectEqual(5, s.size());
            try expectStrings("Hello", s.src());
        }

        test "uString(u8).initWithChar" {
            var s = try uString(u8).initWithChar(Allocator, 'H');
            defer s.deinit(Allocator);
            try expectEqual(1, s.len());
            try expectEqual(1, s.size());
            try expectStrings("H", s.src());
        }

        test "uString(u8).initWithSelf" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello");
            defer s.deinit(Allocator);
            var s2 = try uString(u8).initWithSelf(Allocator, s);
            defer s2.deinit(Allocator);
            try expectEqual(5, s2.len());
            try expectEqual(5, s2.size());
            try expectStrings("Hello", s2.src());
        }

        test "uString(u8).initWithFmt" {
            var s = try uString(u8).initWithFmt(Allocator, "{s}", .{"Hello"});
            defer s.deinit(Allocator);
            try expectStrings("Hello", s.src());

            var s2 = try uString(u8).initWithFmt(Allocator, "{s} {s}", .{"Hello", "World"});
            defer s2.deinit(Allocator);
            try expectStrings("Hello World", s2.src());

            var s3 = try uString(u8).initWithFmt(Allocator, "{s}{s}", .{"Hello", "!"});
            defer s3.deinit(Allocator);
            try expectStrings("Hello!", s3.src());
        }

        test "uString(u8).init (all types)" {
            // with char
            const s = try uString(u8).init(Allocator, 'H'); defer s.deinit(Allocator);
            try expectEqual(1, s.len());
            try expectStrings("H", s.src());

            // with slice
            const s2 = try uString(u8).init(Allocator, "H"); defer s2.deinit(Allocator);
            try expectEqual(1, s2.len());
            try expectStrings("H", s2.src());

            // with self
            const s3 = try uString(u8).init(Allocator, s2); defer s3.deinit(Allocator);
            try expectEqual(1, s3.len());
            try expectStrings("H", s3.src());

            // with positive integer
            const s4 = try uString(u8).init(Allocator, 2099); defer s4.deinit(Allocator);
            try expectEqual(4, s4.len());
            try expectStrings("2099", s4.src());

            // with negative integer
            const s5 = try uString(u8).init(Allocator, -2099); defer s5.deinit(Allocator);
            try expectEqual(5, s5.len());
            try expectStrings("-2099", s5.src());

            // with float
            const s6 = try uString(u8).init(Allocator, 20.99); defer s6.deinit(Allocator);
            try expectEqual(7, s6.len());
            try expectStrings("2.099e1", s6.src());

            // with small integer (not a character)
            // rules
            // 1. u8 is a character.
            // 2. comptime_int between the `u8` range is a character.
            const s7 = try uString(u8).init(Allocator, @as(u16, 2)); defer s7.deinit(Allocator);
            try expectEqual(1, s7.len());
            try expectStrings("2", s7.src());

            // with boolean
            const s8 = try uString(u8).init(Allocator, true); defer s8.deinit(Allocator);
            try expectEqual(4, s8.len());
            try expectStrings("true", s8.src());

            // with array (not a s)
            const arr = [_]bool{ true, false };
            const s9 = try uString(u8).init(Allocator, arr); defer s9.deinit(Allocator);
            try expectEqual(15, s9.len());
            try expectStrings("{ true, false }", s9.src());

            // with structure
            const s10 = try uString(u8).init(Allocator, .{ .value = "Hello" }); defer s10.deinit(Allocator);
            // the `id` of the struct changed every time, so i will comment it.
            // try expectEqual(101, s10.len());
            // try expectStrings("String(u8).String(u8).test.test.uString(u8).init (with char)__struct_26510{ .value = { 72, 101, 108, 108, 111 } }", s10.src());

            // with null
            const s11 = try uString(u8).init(Allocator, null); defer s11.deinit(Allocator);
            try expectEqual(4, s11.len());
            try expectStrings("null", s11.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "uString(u8).insertSlice" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insertSlice(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertSlice(Allocator, "@", 99));
        }

        test "uString(u8).insertChar" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = '!',   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = 'o',   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = 'e',   .expected = "Heo!",         .pos=1, .size=8 },
                .{ .value  = 'l',   .expected = "Helo!",        .pos=2, .size=8 },
                .{ .value  = 'l',   .expected = "Hello!",       .pos=2, .size=8 },
                .{ .value  = ' ',   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = 'x',   .expected = "Hello x!",     .pos=6, .size=20 },
            };

            for(cases) |c| {
                try s.insertChar(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertChar(Allocator, '@', 99));
        }

        test "uString(u8).insertSelf" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                var o = try uString(u8).initWithSlice(Allocator, c.value);
                defer o.deinit(Allocator);
                try s.insertSelf(Allocator, o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            var o = try uString(u8).initWithSlice(Allocator, "@");
            defer o.deinit(Allocator);
            try expectError(error.OutOfRange, s.insertSelf(Allocator, o, 99));
        }

        test "uString(u8).insertFmt" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insertFmt(Allocator, "{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertFmt(Allocator, "{s}", .{"@"}, 99));
        }

        test "uString(u8).insert" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insert(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insert(Allocator, "@", 99));
        }

        test "uString(u8).visualInsertSlice" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertSlice(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertSlice(Allocator, "@", 99));
        }

        test "uString(u8).visualInsertChar" {
            var s = try uString(u8).initWithSlice(Allocator, "👨‍🏭");
            defer s.deinit(Allocator);

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "👨‍🏭H",            .pos=1, .size=24 },
                .{ .value  = '!',   .expected = "👨‍🏭H!",           .pos=2, .size=24 },
                .{ .value  = 'o',   .expected = "👨‍🏭Ho!",          .pos=2, .size=24 },
                .{ .value  = 'e',   .expected = "👨‍🏭Heo!",         .pos=2, .size=24 },
                .{ .value  = 'l',   .expected = "👨‍🏭Helo!",        .pos=3, .size=24 },
                .{ .value  = 'l',   .expected = "👨‍🏭Hello!",       .pos=3, .size=24 },
                .{ .value  = ' ',   .expected = "👨‍🏭Hello !",      .pos=6, .size=24 },
                .{ .value  = 'x',   .expected = "👨‍🏭Hello x!",     .pos=7, .size=24 },
            };

            for(cases) |c| {
                try s.visualInsertChar(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertChar(Allocator, '@', 99));
        }

        test "uString(u8).visualInsertSelf" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                var o = try uString(u8).initWithSlice(Allocator, c.value);
                defer o.deinit(Allocator);
                try s.visualInsertSelf(Allocator, o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            var o = try uString(u8).initWithSlice(Allocator, "@");
            defer o.deinit(Allocator);
            try expectError(error.OutOfRange, s.visualInsertSelf(Allocator, o, 99));
        }

        test "uString(u8).visualInsertFmt" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertFmt(Allocator, "{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertFmt(Allocator, "{s}", .{"@"}, 99));
        }

        test "uString(u8).visualInsert" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsert(Allocator, c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsert(Allocator, "@", 99));
        }

        test "uString(u8).appendSlice" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.appendSlice(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).appendChar" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H"         , .size=8 },
                .{ .value  = 'e',   .expected = "He"        , .size=8 },
                .{ .value  = 'l',   .expected = "Hel"       , .size=8 },
                .{ .value  = 'l',   .expected = "Hell"      , .size=8 },
                .{ .value  = 'o',   .expected = "Hello"     , .size=8 },
                .{ .value  = ' ',   .expected = "Hello "    , .size=8 },
                .{ .value  = '!',   .expected = "Hello !"   , .size=8 },
            };

            for(cases) |c| {
                try s.appendChar(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).appendSelf" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                var o = try uString(u8).initWithSlice(Allocator, c.value);
                defer o.deinit(Allocator);
                try s.appendSelf(Allocator, o);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).appendFmt" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.appendFmt(Allocator, "{s}", .{c.value});
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).append" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.append(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).prependSlice" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prependSlice(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).prependChar" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H"         , .size=8 },
                .{ .value  = 'e',   .expected = "eH"        , .size=8 },
                .{ .value  = 'l',   .expected = "leH"       , .size=8 },
                .{ .value  = 'l',   .expected = "lleH"      , .size=8 },
                .{ .value  = 'o',   .expected = "olleH"     , .size=8 },
                .{ .value  = ' ',   .expected = " olleH"    , .size=8 },
                .{ .value  = '!',   .expected = "! olleH"   , .size=8 },
            };

            for(cases) |c| {
                try s.prependChar(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).prependSelf" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                var o = try uString(u8).initWithSlice(Allocator, c.value);
                defer o.deinit(Allocator);
                try s.prependSelf(Allocator, o);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).prependFmt" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prependFmt(Allocator, "{s}", .{c.value});
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).prepend" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prepend(Allocator, c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "uString(u8).removeIndex" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello !");
            defer s.deinit(Allocator);

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
                try s.removeIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeIndex(1));
        }

        test "uString(u8).removeVisualIndex" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                _ = try s.removeVisualIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualIndex(1);
            try expectError(error.OutOfRange, res);

            var s2 = try uString(u8).initWithSlice(Allocator, "👨‍🏭");
            defer s2.deinit(Allocator);

            const res2 = s2.removeVisualIndex(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "uString(u8).removeRange" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello !");
            defer s.deinit(Allocator);

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
                try s.removeRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeRange(1, 1));
        }

        test "uString(u8).removeVisualRange" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                _ = try s.removeVisualRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualRange(1, 1);
            try expectError(error.OutOfRange, res);

            var s2 = try uString(u8).init(Allocator, "👨‍🏭");
            defer s2.deinit(Allocator);

            const res2 = s2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "uString(u8).pop" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                const res = s.pop();
                try expectStrings(c.removed, res.?);
                try expectStrings(c.expected, s.src());
            }

            // null case
            try expectEqual(null, s.pop());
        }

        test "uString(u8).shift" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                const res = s.shift();
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, s.src());
            }
        }

        test "uString(u8).trimStart" {
            var s = try uString(u8).initWithSlice(Allocator, "   Hello 👨‍🏭!");
            defer s.deinit(Allocator);
            s.trimStart(); // x1 (remove empty spaces)
            s.trimStart(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "uString(u8).trimEnd" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!    ");
            defer s.deinit(Allocator);
            s.trimEnd(); // x1 (remove empty spaces)
            s.trimEnd(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "uString(u8).trim" {
            var s = try uString(u8).initWithSlice(Allocator, "    Hello 👨‍🏭!    ");
            defer s.deinit(Allocator);
            s.trim(); // x1 (remove empty spaces)
            s.trim(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "uString(u8).replaceRange" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceRange(Allocator, 6, 11, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "uString(u8).replaceVisualRange" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceVisualRange(Allocator, 6, 1, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "uString(u8).replaceFirst" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceFirst(Allocator, "👨‍🏭", "World");
            try expectStrings("Hello World👨‍🏭!", s.src());
        }

        test "uString(u8).replaceFirstN" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);

            try s.replaceFirstN(Allocator, "👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceFirstN(Allocator, "👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorld👨‍🏭!", s.src());
            try s.replaceFirstN(Allocator, "👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "uString(u8).replaceLast" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceLast(Allocator, "👨‍🏭", "World");
            try expectStrings("Hello 👨‍🏭World!", s.src());
        }

        test "uString(u8).replaceLastN" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);

            try s.replaceLastN(Allocator, "👨‍🏭", "World", 1);
            try expectStrings("Hello 👨‍🏭👨‍🏭👨‍🏭World!", s.src());
            try s.replaceLastN(Allocator, "👨‍🏭", "World", 2);
            try expectStrings("Hello 👨‍🏭WorldWorldWorld!", s.src());
            try s.replaceLastN(Allocator, "👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "uString(u8).replaceAll" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceAll(Allocator, "👨‍🏭", "World");
            try expectStrings("Hello WorldWorld!", s.src());
        }

        test "uString(u8).replaceNth" {
            var s = try uString(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit(Allocator);
            try s.replaceNth(Allocator, "👨‍🏭", "World", 0);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceNth(Allocator, "👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭World👨‍🏭!", s.src());
            try s.replaceNth(Allocator, "👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭WorldWorld!", s.src());
            try s.replaceNth(Allocator, "👨‍🏭", "World", 0);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Repeat ───────────────────────────┐

        test "uString(u8).repeat" {
            var s = uString(u8).initEmpty();
            defer s.deinit(Allocator);

            // add 'H'x0
            try s.repeat(Allocator, 'H', 0);
            try expectStrings("", s.src());
            try expectEqual(0, s.len());

            // add 'H'x5
            try s.repeat(Allocator, 'H', 5);
            try expectStrings("HHHHH", s.src());
            try expectEqual(5, s.len());

            // add '@'x5
            try s.repeat(Allocator, '@', 5);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());

            // add '@'x0
            try s.repeat(Allocator, '@', 0);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "uString(u8).find" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                try expectEqual(c.expected, s.find(c.value));
            }
        }

        test "uString(u8).findVisual" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                try expectEqual(c.expected, s.findVisual(c.value));
            }
        }

        test "uString(u8).findLast" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                try expectEqual(c.expected, s.findLast(c.value));
            }
        }

        test "uString(u8).findLastVisual" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

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
                try expectEqual(c.expected, s.findLastVisual(c.value));
            }
        }

        test "uString(u8).includes" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

            try expect(s.includes("H"));
            try expect(s.includes("e"));
            try expect(s.includes("l"));
            try expect(s.includes("o"));
            try expect(s.includes(" "));
            try expect(s.includes("👨‍🏭"));
            try expect(s.includes("!"));
            try expect(!s.includes("@"));
        }

        test "uString(u8).startsWith" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

            try expect(s.startsWith("H"));
            try expect(!s.startsWith("👨‍🏭"));
        }

        test "uString(u8).endsWith" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

            try expect(s.endsWith("!"));
            try expect(!s.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "uString(u8).toLower" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

            s.toLower();
            try expectStrings("hello 👨‍🏭!", s.src());
        }

        test "uString(u8).toUpper" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);

            s.toUpper();
            try expectStrings("HELLO 👨‍🏭!", s.src());
        }

        test "uString(u8).toTitle" {
            var s = try uString(u8).initWithSlice(Allocator, "heLLo 👨‍🏭!");
            defer s.deinit(Allocator);

            s.toTitle();
            try expectStrings("Hello 👨‍🏭!", s.src());
        }

        test "uString(u8).reverse" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit(Allocator);
            try s.reverse(Allocator);
            try expectStrings("!👨‍🏭 olleH", s.src());
        }


    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Check ───────────────────────────┐

        test "uString(u8).isEqual" {
            var s1 = try uString(u8).initWithSlice(Allocator, "Hello, World!");
            defer s1.deinit(Allocator);

            var s2 = try uString(u8).initWithSlice(Allocator, "Hello, World!");
            defer s2.deinit(Allocator);

            var s3 = try uString(u8).initWithSlice(Allocator, "Goodbye, World!");
            defer s3.deinit(Allocator);

            try expect(s1.isEqual(s2.src()));
            try expect(!s1.isEqual(s3.src()));
        }

        test "uString(u8).isEmpty" {
            var empty = try uString(u8).initWithSlice(Allocator, "");
            defer empty.deinit(Allocator);

            var nonEmpty = try uString(u8).initWithSlice(Allocator, "Hello, World!");
            defer nonEmpty.deinit(Allocator);

            try expect(empty.isEmpty());
            try expect(!nonEmpty.isEmpty());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "uString(u8).Writer.write" {
            var s = try uString(u8).initWithAllocator(Allocator);
            defer s.deinit(Allocator);
            var writer = s.writer(Allocator);

            _ = try writer.write("Hello");
            try expectStrings("Hello", s.src());

            _ = try writer.write(" World");
            try expectStrings("Hello World", s.src());

            _ = try writer.write("!");
            try expectStrings("Hello World!", s.src());
        }

        test "uString(u8).iterator" {
            var s = try uString(u8).init(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit(Allocator);
            var iter = s.iterator();

            while(iter.nextCodepointSlice()) |slice| {
                try expect(utils.unicode.Utf8Validate(slice));
            }

            // Ensure all characters were iterated
            try expectEqual("!👨‍🏭@👨‍🏭#".len, iter.pos);
        }

        test "uString(u8).charAt and uString(u8).atVisual and uString(u8).sub and uString(u8).toViewer" {
            var s = try uString(u8).initWithSlice(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit(Allocator);

            try expectEqual('!',  s.charAt(0).?);
            try expectEqual('@',  s.charAt(12).?);
            try expectEqual('#',  s.charAt(24).?);
            try expectEqual(null, s.charAt(25));

            try expectStrings("!",  s.atVisual(0).?);
            try expectStrings("👨‍🏭",  s.atVisual(1).?);
            try expectStrings("@",  s.atVisual(2).?);
            try expectStrings("👨‍🏭",  s.atVisual(3).?);
            try expectStrings("#",  s.atVisual(4).?);
            try expectEqual(null, s.atVisual(5));

            try expectStrings("👨‍🏭", try s.sub(1, 12));

            const v = s.toViewer();
            try expectStrings(s.src(), v.src());
        }

        test "uString(u8).cString" {
            var s = try uString(u8).initWithSlice(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit(Allocator);

            const c_string = try s.cString(Allocator);

            try expectStrings("!👨‍🏭@👨‍🏭#", c_string);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "uString(u8).split" {
            var s = try uString(u8).init(Allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer s.deinit(Allocator);

            // Test basic splits
            try expectStrings("0", s.split("👨‍🏭", 0).?);
            try expectStrings("11", s.split("👨‍🏭", 1).?);
            try expectStrings("2", s.split("👨‍🏭", 2).?);
            try expectStrings("33", s.split("👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(s.split("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = uString(u8).initEmpty();
            defer s2.deinit(Allocator);
            try expectStrings("", s2.split("👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(s.src(), s.split("X", 0).?);
        }

        test "uString(u8).splitAll" {
            // Leading/trailing delimiters
            var s = try uString(u8).init(Allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer s.deinit(Allocator);

            const parts2 = try s.splitAll(Allocator, "👨‍🏭", true);
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try s.splitAll(Allocator, "👨‍🏭", false);
            defer Allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

        test "uString(u8).splitToSelf" {
            var s = try uString(u8).init(Allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer s.deinit(Allocator);

            // Test basic splits
            if(try s.splitToSelf(Allocator, "👨‍🏭", 0)) |res| {
                defer res.deinit(Allocator);
                try expectStrings("0", res.src());
            }
            if(try s.splitToSelf(Allocator, "👨‍🏭", 1)) |res| {
                defer res.deinit(Allocator);
                try expectStrings("11", res.src());
            }
            if(try s.splitToSelf(Allocator, "👨‍🏭", 2)) |res| {
                defer res.deinit(Allocator);
                try expectStrings("2", res.src());
            }
            if(try s.splitToSelf(Allocator, "👨‍🏭", 3)) |res| {
                defer res.deinit(Allocator);
                try expectStrings("33", res.src());
            }

            // Test out-of-bounds indices
            try expect(try s.splitToSelf(Allocator, "👨‍🏭", 4) == null);

            // Test empty input
            var s2 = uString(u8).initEmpty();
            try expectStrings("", (try s2.splitToSelf(Allocator, "👨‍🏭", 0)).?.src());

            // Test non-existent delimiter
            if(try s.splitToSelf(Allocator, "X", 0)) |res| {
                defer res.deinit(Allocator);
                try expectStrings(s.src(), res.src());
            }
        }

        test "uString(u8).splitAllToSelf" {
            // Leading/trailing delimiters
            var s = try uString(u8).init(Allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer s.deinit(Allocator);

            const parts2 = try s.splitAllToSelf(Allocator, "👨‍🏭");
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0].src());
            try expectStrings("a", parts2[1].src());
            try expectStrings("b", parts2[2].src());
            try expectStrings("", parts2[3].src());
            for(0..parts2.len) |i| { defer parts2[i].deinit(Allocator); }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "uString(u8).shrinkAndFree" {
            // shrink still sets length when resizing is disabled
            {
                var failing_allocator = std.testing.FailingAllocator.init(Allocator, .{ .resize_fail_index = 0 });
                const a = failing_allocator.allocator();

                var s = uString(u8).initEmpty();
                defer s.deinit(a);

                try s.append(a, 1);
                try s.append(a, 2);
                try s.append(a, 3);

                s.shrinkAndFree(a, 1);
                try expect(s.size() == 1);
            }

            // with a copy
            {
                var failing_allocator = std.testing.FailingAllocator.init(Allocator, .{ .resize_fail_index = 0 });
                const a = failing_allocator.allocator();

                var s = uString(u8).initEmpty();
                defer s.deinit(a);

                try s.repeat(a, 3, 16);
                s.shrinkAndFree(a, 4);
                try expect(std.mem.eql(u8, s.m_src[0..s.size()], &.{ 3, 3, 3, 3 }));
            }

            // growing memory preserves contents
            {
                const a = std.testing.allocator;

                var s = uString(u8).initEmpty();
                defer s.deinit(a);

                try s.appendSlice(a, "abcd");
                s.shrinkAndFree(a, 4);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcd");

                try s.appendSlice(a, "efgh");
                s.shrinkAndFree(a, 8);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcdefgh");

                try s.insertSlice(a, "ijkl", 4);
                s.shrinkAndFree(a, 12);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcdijklefgh");
            }
        }

        test "uString(u8).resize" {
            // empty
            {
                var s = uString(u8).initEmpty();
                defer s.deinit(Allocator);
                try expectEqual(0, s.size());
                try expectEqual(0, s.len());

                try s.resize(Allocator, 8);
                try expectEqual(8, s.size());
                try expectEqual(0, s.len());

                try s.resize(Allocator, 16);
                try expectEqual(16, s.size());
                try expectEqual(0, s.len());

                try s.resize(Allocator, 8);
                try expect(s.size() == 8);
                try expectEqual(0, s.len());

                try s.resize(Allocator, 0);
                try expect(s.size() == 0);
                try expectEqual(0, s.len());
            }

            // with value
            {
                var s = try uString(u8).initWithSlice(Allocator, "Hello");
                defer s.deinit(Allocator);

                try expectEqual(5, s.len());
                try expectEqual(5, s.size()); // not 8 because it uses appendSlice.

                try s.resize(Allocator, 8);
                try expectEqual(5, s.len());
                try expectEqual(8, s.size());
                try expectStrings("Hello", s.src());

                try s.resize(Allocator, 2);
                try expectEqual(2, s.len());
                try expectEqual(2, s.size());
                try expectStrings("He", s.src());

                try s.resize(Allocator, 0);
                try expectEqual(0, s.len());
                try expectEqual(0, s.size());
                try expectStrings("", s.src());
            }
        }

        test "uString(u8).toManaged" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello, World!");

            var managed = s.toManaged(Allocator);
            defer managed.deinit();

            // TODO: un-comment these lines after implementing the replaceAllSlices function.
            // _ = try managed.replaceAllSlices("World", "Maysara");
            // try expectStrings("Hello, Maysara!", managed.src());
        }

        test "uString(u8).fromOwnedSlice" {
            var slice = try utils.chars.initWithSlice(u8, 13, "Hello, World!");
            const s = uString(u8).fromOwnedSlice(&slice);
            try expectStrings(&slice, s.src());
        }

        test "uString(u8).toOwnedSlice" {
            var s = try uString(u8).initWithSlice(Allocator, "Hello, World!");

            var ownedSlice = try s.toOwnedSlice(Allocator);
            ownedSlice[0] = 'X';
            defer Allocator.free(ownedSlice);

            try expectStrings(ownedSlice, "Xello, World!");
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ String ═════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test "String(u8).initWithAllocator" {
            const s = try String(u8).initWithAllocator(Allocator);
            try expectEqual(0, s.len());
            try expectEqual(0, s.size());
            try expectStrings("", s.src());
        }

        test "String(u8).initWithCapacity" {
            var s = try String(u8).initWithCapacity(Allocator, 10);
            defer s.deinit();
            try expectEqual(0, s.len());
            try expectEqual(10, s.size());
            try expectStrings("", s.src());

            // zero
            const s2 = try String(u8).initWithCapacity(Allocator, 0);
            try expectEqual(0, s2.len());
            try expectEqual(0, s2.size());
            try expectStrings("", s2.src());
        }

        test "String(u8).initWithSlice" {
            var s = try String(u8).initWithSlice(Allocator, "Hello");
            defer s.deinit();
            try expectEqual(5, s.len());
            try expectEqual(5, s.size());
            try expectStrings("Hello", s.src());
        }

        test "String(u8).initWithChar" {
            var s = try String(u8).initWithChar(Allocator, 'H');
            defer s.deinit();
            try expectEqual(1, s.len());
            try expectEqual(1, s.size());
            try expectStrings("H", s.src());
        }

        test "String(u8).initWithSelf" {
            var s = try String(u8).initWithSlice(Allocator, "Hello");
            defer s.deinit();
            var s2 = try String(u8).initWithSelf(Allocator, s);
            defer s2.deinit();
            try expectEqual(5, s2.len());
            try expectEqual(5, s2.size());
            try expectStrings("Hello", s2.src());
        }

        test "String(u8).initWithFmt" {
            var s = try String(u8).initWithFmt(Allocator, "{s}", .{"Hello"});
            defer s.deinit();
            try expectStrings("Hello", s.src());

            var s2 = try String(u8).initWithFmt(Allocator, "{s} {s}", .{"Hello", "World"});
            defer s2.deinit();
            try expectStrings("Hello World", s2.src());

            var s3 = try String(u8).initWithFmt(Allocator, "{s}{s}", .{"Hello", "!"});
            defer s3.deinit();
            try expectStrings("Hello!", s3.src());
        }

        test "String(u8).init (all types)" {
            // with char
            const s = try String(u8).init(Allocator, 'H'); defer s.deinit();
            try expectEqual(1, s.len());
            try expectStrings("H", s.src());

            // with slice
            const s2 = try String(u8).init(Allocator, "H"); defer s2.deinit();
            try expectEqual(1, s2.len());
            try expectStrings("H", s2.src());

            // with self
            const s3 = try String(u8).init(Allocator, s2); defer s3.deinit();
            try expectEqual(1, s3.len());
            try expectStrings("H", s3.src());

            // with positive integer
            const s4 = try String(u8).init(Allocator, 2099); defer s4.deinit();
            try expectEqual(4, s4.len());
            try expectStrings("2099", s4.src());

            // with negative integer
            const s5 = try String(u8).init(Allocator, -2099); defer s5.deinit();
            try expectEqual(5, s5.len());
            try expectStrings("-2099", s5.src());

            // with float
            const s6 = try String(u8).init(Allocator, 20.99); defer s6.deinit();
            try expectEqual(7, s6.len());
            try expectStrings("2.099e1", s6.src());

            // with small integer (not a character)
            // rules
            // 1. u8 is a character.
            // 2. comptime_int between the `u8` range is a character.
            const s7 = try String(u8).init(Allocator, @as(u16, 2)); defer s7.deinit();
            try expectEqual(1, s7.len());
            try expectStrings("2", s7.src());

            // with boolean
            const s8 = try String(u8).init(Allocator, true); defer s8.deinit();
            try expectEqual(4, s8.len());
            try expectStrings("true", s8.src());

            // with array (not a s)
            const arr = [_]bool{ true, false };
            const s9 = try String(u8).init(Allocator, arr); defer s9.deinit();
            try expectEqual(15, s9.len());
            try expectStrings("{ true, false }", s9.src());

            // with structure
            const s10 = try String(u8).init(Allocator, .{ .value = "Hello" }); defer s10.deinit();
            // the `id` of the struct changed every time, so i will comment it.
            // try expectEqual(100, s10.len());
            // try expectStrings("String(u8).String(u8).test.test.String(u8).init (with char)__struct_26510{ .value = { 72, 101, 108, 108, 111 } }", s10.src());

            // with null
            const s11 = try String(u8).init(Allocator, null); defer s11.deinit();
            try expectEqual(4, s11.len());
            try expectStrings("null", s11.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        test "String(u8).insertSlice" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insertSlice(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertSlice("@", 99));
        }

        test "String(u8).insertChar" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = '!',   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = 'o',   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = 'e',   .expected = "Heo!",         .pos=1, .size=8 },
                .{ .value  = 'l',   .expected = "Helo!",        .pos=2, .size=8 },
                .{ .value  = 'l',   .expected = "Hello!",       .pos=2, .size=8 },
                .{ .value  = ' ',   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = 'x',   .expected = "Hello x!",     .pos=6, .size=20 },
            };

            for(cases) |c| {
                try s.insertChar(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertChar('@', 99));
        }

        test "String(u8).insertSelf" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                var o = try String(u8).initWithSlice(Allocator, c.value);
                defer o.deinit();
                try s.insertSelf(o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            var o = try String(u8).initWithSlice(Allocator, "@");
            defer o.deinit();
            try expectError(error.OutOfRange, s.insertSelf(o, 99));
        }

        test "String(u8).insertFmt" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insertFmt("{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insertFmt("{s}", .{"@"}, 99));
        }

        test "String(u8).insert" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.insert(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.insert("@", 99));
        }

        test "String(u8).visualInsertSlice" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertSlice(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertSlice("@", 99));
        }

        test "String(u8).visualInsertChar" {
            var s = try String(u8).initWithSlice(Allocator, "👨‍🏭");
            defer s.deinit();

            const Cases = struct { value: u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "👨‍🏭H",            .pos=1, .size=24 },
                .{ .value  = '!',   .expected = "👨‍🏭H!",           .pos=2, .size=24 },
                .{ .value  = 'o',   .expected = "👨‍🏭Ho!",          .pos=2, .size=24 },
                .{ .value  = 'e',   .expected = "👨‍🏭Heo!",         .pos=2, .size=24 },
                .{ .value  = 'l',   .expected = "👨‍🏭Helo!",        .pos=3, .size=24 },
                .{ .value  = 'l',   .expected = "👨‍🏭Hello!",       .pos=3, .size=24 },
                .{ .value  = ' ',   .expected = "👨‍🏭Hello !",      .pos=6, .size=24 },
                .{ .value  = 'x',   .expected = "👨‍🏭Hello x!",     .pos=7, .size=24 },
            };

            for(cases) |c| {
                try s.visualInsertChar(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertChar('@', 99));
        }

        test "String(u8).visualInsertSelf" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                var o = try String(u8).initWithSlice(Allocator, c.value);
                defer o.deinit();
                try s.visualInsertSelf(o, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            var o = try String(u8).initWithSlice(Allocator, "@");
            defer o.deinit();
            try expectError(error.OutOfRange, s.visualInsertSelf(o, 99));
        }

        test "String(u8).visualInsertFmt" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "!",   .expected = "H!",           .pos=1, .size=8 },
                .{ .value  = "o",   .expected = "Ho!",          .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello!",       .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello !",      .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭!",    .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!!",   .pos=7, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsertFmt("{s}", .{c.value}, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsertFmt("{s}", .{"@"}, 99));
        }

        test "String(u8).visualInsert" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();
            const Cases = struct { value: []const u8, expected: []const u8, pos: usize, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H",            .pos=0, .size=8 },
                .{ .value  = "o",   .expected = "Ho",           .pos=1, .size=8 },
                .{ .value  = "ell", .expected = "Hello",        .pos=1, .size=8 },
                .{ .value  = " ",   .expected = "Hello ",       .pos=5, .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭",     .pos=6, .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!",    .pos=7, .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!",    .pos=2, .size=20 },
            };

            for(cases) |c| {
                try s.visualInsert(c.value, c.pos);
                try expectStrings(c.expected, s.src());
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.visualInsert("@", 99));
        }

        test "String(u8).appendSlice" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.appendSlice(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).appendChar" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H"         , .size=8 },
                .{ .value  = 'e',   .expected = "He"        , .size=8 },
                .{ .value  = 'l',   .expected = "Hel"       , .size=8 },
                .{ .value  = 'l',   .expected = "Hell"      , .size=8 },
                .{ .value  = 'o',   .expected = "Hello"     , .size=8 },
                .{ .value  = ' ',   .expected = "Hello "    , .size=8 },
                .{ .value  = '!',   .expected = "Hello !"   , .size=8 },
            };

            for(cases) |c| {
                try s.appendChar(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).appendSelf" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                var o = try String(u8).initWithSlice(Allocator, c.value);
                defer o.deinit();
                try s.appendSelf(o);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).appendFmt" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.appendFmt("{s}", .{c.value});
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).append" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "He"        , .size=8 },
                .{ .value  = "llo", .expected = "Hello"     , .size=8 },
                .{ .value  = " ",   .expected = "Hello "    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "Hello 👨‍🏭"  , .size=20 },
                .{ .value  = "!",   .expected = "Hello 👨‍🏭!" , .size=20 },
                .{ .value  = "",    .expected = "Hello 👨‍🏭!" , .size=20 },
            };

            for(cases) |c| {
                try s.append(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).prependSlice" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prependSlice(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).prependChar" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = 'H',   .expected = "H"         , .size=8 },
                .{ .value  = 'e',   .expected = "eH"        , .size=8 },
                .{ .value  = 'l',   .expected = "leH"       , .size=8 },
                .{ .value  = 'l',   .expected = "lleH"      , .size=8 },
                .{ .value  = 'o',   .expected = "olleH"     , .size=8 },
                .{ .value  = ' ',   .expected = " olleH"    , .size=8 },
                .{ .value  = '!',   .expected = "! olleH"   , .size=8 },
            };

            for(cases) |c| {
                try s.prependChar(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).prependSelf" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                var o = try String(u8).initWithSlice(Allocator, c.value);
                defer o.deinit();
                try s.prependSelf(o);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).prependFmt" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prependFmt("{s}", .{c.value});
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).prepend" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            const Cases = struct { value: []const u8, expected: []const u8, size: usize };
            const cases = &[_]Cases{
                .{ .value  = "H",   .expected = "H"         , .size=8 },
                .{ .value  = "e",   .expected = "eH"        , .size=8 },
                .{ .value  = "oll", .expected = "olleH"     , .size=8 },
                .{ .value  = " ",   .expected = " olleH"    , .size=8 },
                .{ .value  = "👨‍🏭",  .expected = "👨‍🏭 olleH"  , .size=20 },
                .{ .value  = "!",   .expected = "!👨‍🏭 olleH" , .size=20 },
                .{ .value  = "",    .expected = "!👨‍🏭 olleH" , .size=20 },
            };

            for(cases) |c| {
                try s.prepend(c.value);
                try expectEqual(c.expected.len, s.len());
                try expectEqual(c.size, s.size());
                try expectStrings(c.expected, s.src());
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        test "String(u8).removeIndex" {
            var s = try String(u8).initWithSlice(Allocator, "Hello !");
            defer s.deinit();

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
                try s.removeIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeIndex(1));
        }

        test "String(u8).removeVisualIndex" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                _ = try s.removeVisualIndex(c.pos);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualIndex(1);
            try expectError(error.OutOfRange, res);

            var s2 = try String(u8).initWithSlice(Allocator, "👨‍🏭");
            defer s2.deinit();

            const res2 = s2.removeVisualIndex(2);
            try expectError(error.InvalidPosition, res2);
        }

        test "String(u8).removeRange" {
            var s = try String(u8).initWithSlice(Allocator, "Hello !");
            defer s.deinit();

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
                try s.removeRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            try expectError(error.OutOfRange, s.removeRange(1, 1));
        }

        test "String(u8).removeVisualRange" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                _ = try s.removeVisualRange(c.pos, c.len);
                try expectStrings(c.expected, s.src());
            }

            // Failure Cases.
            const res = s.removeVisualRange(1, 1);
            try expectError(error.OutOfRange, res);

            var s2 = try String(u8).init(Allocator, "👨‍🏭");
            defer s2.deinit();

            const res2 = s2.removeVisualRange(2, 1);
            try expectError(error.InvalidPosition, res2);
        }

        test "String(u8).pop" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                const res = s.pop();
                try expectStrings(c.removed, res.?);
                try expectStrings(c.expected, s.src());
            }

            // null case
            try expectEqual(null, s.pop());
        }

        test "String(u8).shift" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                const res = s.shift();
                try expectEqual(c.removed.len, res);
                try expectStrings(c.expected, s.src());
            }
        }

        test "String(u8).trimStart" {
            var s = try String(u8).initWithSlice(Allocator, "   Hello 👨‍🏭!");
            defer s.deinit();
            s.trimStart(); // x1 (remove empty spaces)
            s.trimStart(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "String(u8).trimEnd" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!    ");
            defer s.deinit();
            s.trimEnd(); // x1 (remove empty spaces)
            s.trimEnd(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

        test "String(u8).trim" {
            var s = try String(u8).initWithSlice(Allocator, "    Hello 👨‍🏭!    ");
            defer s.deinit();
            s.trim(); // x1 (remove empty spaces)
            s.trim(); // x2 (no effect)
            try expectStrings("Hello 👨‍🏭!", s.src());
            try expectEqual(18, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        test "String(u8).replaceRange" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();
            try s.replaceRange(6, 11, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "String(u8).replaceVisualRange" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();
            try s.replaceVisualRange(6, 1, "World");
            try expectStrings("Hello World!", s.src());
        }

        test "String(u8).replaceFirst" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit();
            try s.replaceFirst("👨‍🏭", "World");
            try expectStrings("Hello World👨‍🏭!", s.src());
        }

        test "String(u8).replaceFirstN" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit();

            try s.replaceFirstN("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceFirstN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorld👨‍🏭!", s.src());
            try s.replaceFirstN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "String(u8).replaceLast" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit();
            try s.replaceLast("👨‍🏭", "World");
            try expectStrings("Hello 👨‍🏭World!", s.src());
        }

        test "String(u8).replaceLastN" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit();

            try s.replaceLastN("👨‍🏭", "World", 1);
            try expectStrings("Hello 👨‍🏭👨‍🏭👨‍🏭World!", s.src());
            try s.replaceLastN("👨‍🏭", "World", 2);
            try expectStrings("Hello 👨‍🏭WorldWorldWorld!", s.src());
            try s.replaceLastN("👨‍🏭", "World", 2);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

        test "String(u8).replaceAll" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭!");
            defer s.deinit();
            try s.replaceAll("👨‍🏭", "World");
            try expectStrings("Hello WorldWorld!", s.src());
        }

        test "String(u8).replaceNth" {
            var s = try String(u8).init(Allocator, "Hello 👨‍🏭👨‍🏭👨‍🏭👨‍🏭!");
            defer s.deinit();
            try s.replaceNth("👨‍🏭", "World", 0);
            try expectStrings("Hello World👨‍🏭👨‍🏭👨‍🏭!", s.src());
            try s.replaceNth("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭World👨‍🏭!", s.src());
            try s.replaceNth("👨‍🏭", "World", 1);
            try expectStrings("Hello World👨‍🏭WorldWorld!", s.src());
            try s.replaceNth("👨‍🏭", "World", 0);
            try expectStrings("Hello WorldWorldWorldWorld!", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Repeat ───────────────────────────┐

        test "String(u8).repeat" {
            var s = try String(u8).initEmpty(Allocator);
            defer s.deinit();

            // add 'H'x0
            try s.repeat('H', 0);
            try expectStrings("", s.src());
            try expectEqual(0, s.len());

            // add 'H'x5
            try s.repeat('H', 5);
            try expectStrings("HHHHH", s.src());
            try expectEqual(5, s.len());

            // add '@'x5
            try s.repeat( '@', 5);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());

            // add '@'x0
            try s.repeat('@', 0);
            try expectStrings("HHHHH@@@@@", s.src());
            try expectEqual(10, s.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐
        test "String(u8).find" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                try expectEqual(c.expected, s.find(c.value));
            }
        }

        test "String(u8).findVisual" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                try expectEqual(c.expected, s.findVisual(c.value));
            }
        }

        test "String(u8).findLast" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                try expectEqual(c.expected, s.findLast(c.value));
            }
        }

        test "String(u8).findLastVisual" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

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
                try expectEqual(c.expected, s.findLastVisual(c.value));
            }
        }

        test "String(u8).includes" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

            try expect(s.includes("H"));
            try expect(s.includes("e"));
            try expect(s.includes("l"));
            try expect(s.includes("o"));
            try expect(s.includes(" "));
            try expect(s.includes("👨‍🏭"));
            try expect(s.includes("!"));
            try expect(!s.includes("@"));
        }

        test "String(u8).startsWith" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

            try expect(s.startsWith("H"));
            try expect(!s.startsWith("👨‍🏭"));
        }

        test "String(u8).endsWith" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

            try expect(s.endsWith("!"));
            try expect(!s.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "String(u8).toLower" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

            s.toLower();
            try expectStrings("hello 👨‍🏭!", s.src());
        }

        test "String(u8).toUpper" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();

            s.toUpper();
            try expectStrings("HELLO 👨‍🏭!", s.src());
        }

        test "String(u8).toTitle" {
            var s = try String(u8).initWithSlice(Allocator, "heLLo 👨‍🏭!");
            defer s.deinit();

            s.toTitle();
            try expectStrings("Hello 👨‍🏭!", s.src());
        }

        test "String(u8).reverse" {
            var s = try String(u8).initWithSlice(Allocator, "Hello 👨‍🏭!");
            defer s.deinit();
            try s.reverse();
            try expectStrings("!👨‍🏭 olleH", s.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Check ───────────────────────────┐

        test "String(u8).isEqual" {
            const s1 = try String(u8).initWithSlice(Allocator, "Hello, World!");
            defer s1.deinit();

            const s2 = try String(u8).initWithSlice(Allocator, "Hello, World!");
            defer s2.deinit();

            const s3 = try String(u8).initWithSlice(Allocator, "Goodbye, World!");
            defer s3.deinit();

            try expect(s1.isEqual(s2.src()));
            try expect(!s1.isEqual(s3.src()));
        }

        test "String(u8).isEmpty" {
            const empty = try String(u8).initWithSlice(Allocator, "");
            defer empty.deinit();

            const nonEmpty = try String(u8).initWithSlice(Allocator, "Hello, World!");
            defer nonEmpty.deinit();

            try expect(empty.isEmpty());
            try expect(!nonEmpty.isEmpty());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ────────────────────────────┐

        test "String(u8).Writer.write" {
            var s = try String(u8).initWithAllocator(Allocator);
            defer s.deinit();
            var writer = s.writer();

            _ = try writer.write("Hello");
            try expectStrings("Hello", s.src());

            _ = try writer.write(" World");
            try expectStrings("Hello World", s.src());

            _ = try writer.write("!");
            try expectStrings("Hello World!", s.src());
        }

        test "String(u8).iterator" {
            var s = try String(u8).init(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit();
            var iter = s.iterator();

            while(iter.nextCodepointSlice()) |slice| {
                try expect(utils.unicode.Utf8Validate(slice));
            }

            // Ensure all characters were iterated
            try expectEqual("!👨‍🏭@👨‍🏭#".len, iter.pos);
        }

        test "String(u8).charAt and String(u8).atVisual and String(u8).sub and String(u8).toViewer" {
            var s = try String(u8).initWithSlice(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit();

            try expectEqual('!',  s.charAt(0).?);
            try expectEqual('@',  s.charAt(12).?);
            try expectEqual('#',  s.charAt(24).?);
            try expectEqual(null, s.charAt(25));

            try expectStrings("!",  s.atVisual(0).?);
            try expectStrings("👨‍🏭",  s.atVisual(1).?);
            try expectStrings("@",  s.atVisual(2).?);
            try expectStrings("👨‍🏭",  s.atVisual(3).?);
            try expectStrings("#",  s.atVisual(4).?);
            try expectEqual(null, s.atVisual(5));

            try expectStrings("👨‍🏭", try s.sub(1, 12));

            const v = s.toViewer();
            try expectStrings(s.src(), v.src());
        }

        test "String(u8).cString" {
            var s = try String(u8).initWithSlice(Allocator, "!👨‍🏭@👨‍🏭#");
            defer s.deinit();

            const c_string = try s.cString();

            try expectStrings("!👨‍🏭@👨‍🏭#", c_string);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        test "String(u8).split" {
            var s = try String(u8).init(Allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer s.deinit();

            // Test basic splits
            try expectStrings("0", s.split("👨‍🏭", 0).?);
            try expectStrings("11", s.split("👨‍🏭", 1).?);
            try expectStrings("2", s.split("👨‍🏭", 2).?);
            try expectStrings("33", s.split("👨‍🏭", 3).?);

            // Test out-of-bounds indices
            try expect(s.split("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = try String(u8).initEmpty(Allocator);
            defer s2.deinit();
            try expectStrings("", s2.split("👨‍🏭", 0).?);

            // Test non-existent delimiter
            try expectStrings(s.src(), s.split("X", 0).?);
        }

        test "String(u8).splitAll" {
            // Leading/trailing delimiters
            var s = try String(u8).init(Allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer s.deinit();

            const parts2 = try s.splitAll("👨‍🏭", true);
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0]);
            try expectStrings("a", parts2[1]);
            try expectStrings("b", parts2[2]);
            try expectStrings("", parts2[3]);

            // Test with include_empty = false
            const parts3 = try s.splitAll("👨‍🏭", false);
            defer Allocator.free(parts3);
            try expectStrings("a", parts3[0]);
            try expectStrings("b", parts3[1]);
        }

        test "String(u8).splitToSelf" {
            var s = try String(u8).init(Allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
            defer s.deinit();

            // Test basic splits
            if(try s.splitToSelf("👨‍🏭", 0)) |res| {
                defer res.deinit();
                try expectStrings("0", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 1)) |res| {
                defer res.deinit();
                try expectStrings("11", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 2)) |res| {
                defer res.deinit();
                try expectStrings("2", res.src());
            }
            if(try s.splitToSelf("👨‍🏭", 3)) |res| {
                defer res.deinit();
                try expectStrings("33", res.src());
            }

            // Test out-of-bounds indices
            try expect(try s.splitToSelf("👨‍🏭", 4) == null);

            // Test empty input
            var s2 = try String(u8).initEmpty(Allocator);
            try expectStrings("", (try s2.splitToSelf("👨‍🏭", 0)).?.src());

            // Test non-existent delimiter
            if(try s.splitToSelf("X", 0)) |res| {
                defer res.deinit();
                try expectStrings(s.src(), res.src());
            }
        }

        test "String(u8).splitAllToSelf" {
            // Leading/trailing delimiters
            var s = try String(u8).init(Allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
            defer s.deinit();

            const parts2 = try s.splitAllToSelf("👨‍🏭");
            defer Allocator.free(parts2);
            try expectStrings("", parts2[0].src());
            try expectStrings("a", parts2[1].src());
            try expectStrings("b", parts2[2].src());
            try expectStrings("", parts2[3].src());
            for(0..parts2.len) |i| { defer parts2[i].deinit(); }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "String(u8).shrinkAndFree" {
            // shrink still sets length when resizing is disabled
            {
                var failing_allocator = std.testing.FailingAllocator.init(Allocator, .{ .resize_fail_index = 0 });
                const a = failing_allocator.allocator();

                var s = try String(u8).initEmpty(a);
                defer s.deinit();

                try s.append(1);
                try s.append(2);
                try s.append(3);

                s.shrinkAndFree(1);
                try expect(s.size() == 1);
            }

            // with a copy
            {
                var failing_allocator = std.testing.FailingAllocator.init(Allocator, .{ .resize_fail_index = 0 });
                const a = failing_allocator.allocator();

                var s = try String(u8).initEmpty(a);
                defer s.deinit();

                try s.repeat(3, 16);
                s.shrinkAndFree(4);
                try expect(std.mem.eql(u8, s.m_src[0..s.size()], &.{ 3, 3, 3, 3 }));
            }

            // growing memory preserves contents
            {
                const a = std.testing.allocator;

                var s = try String(u8).initEmpty(a);
                defer s.deinit();

                try s.appendSlice("abcd");
                s.shrinkAndFree(4);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcd");

                try s.appendSlice("efgh");
                s.shrinkAndFree(8);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcdefgh");

                try s.insertSlice("ijkl", 4);
                s.shrinkAndFree(12);
                try std.testing.expectEqualSlices(u8, s.m_src[0..s.size()], "abcdijklefgh");
            }
        }

        test "String(u8).resize" {
            // empty
            {
                var s = try String(u8).initEmpty(Allocator);
                defer s.deinit();
                try expectEqual(0, s.size());
                try expectEqual(0, s.len());

                try s.resize(8);
                try expectEqual(8, s.size());
                try expectEqual(0, s.len());

                try s.resize(16);
                try expectEqual(16, s.size());
                try expectEqual(0, s.len());

                try s.resize(8);
                try expect(s.size() == 8);
                try expectEqual(0, s.len());

                try s.resize(0);
                try expect(s.size() == 0);
                try expectEqual(0, s.len());
            }

            // with value
            {
                var s = try String(u8).initWithSlice(Allocator, "Hello");
                defer s.deinit();

                try expectEqual(5, s.len());
                try expectEqual(5, s.size()); // not 8 because it uses appendSlice.

                try s.resize(8);
                try expectEqual(5, s.len());
                try expectEqual(8, s.size());
                try expectStrings("Hello", s.src());

                try s.resize(2);
                try expectEqual(2, s.len());
                try expectEqual(2, s.size());
                try expectStrings("He", s.src());

                try s.resize(0);
                try expectEqual(0, s.len());
                try expectEqual(0, s.size());
                try expectStrings("", s.src());
            }
        }

        test "String(u8).toUnmanaged" {
            var s = try String(u8).initWithSlice(Allocator, "Hello, World!");

            var unmanaged = s.toUnmanaged();
            defer unmanaged.deinit(Allocator);

            // TODO: un-comment these lines after implementing the replaceAllSlices function.
            // _ = try managed.replaceAllSlices("World", "Maysara");
            // try expectStrings("Hello, Maysara!", unmanaged.src());
        }

        test "String(u8).fromOwnedSlice" {
            var slice = try utils.chars.initWithSlice(u8, 13, "Hello, World!");
            const s = String(u8).fromOwnedSlice(Allocator, &slice);
            try expectStrings(&slice, s.src());
        }

        test "String(u8).toOwnedSlice" {
            var s = try String(u8).initWithSlice(Allocator, "Hello, World!");

            var ownedSlice = try s.toOwnedSlice();
            ownedSlice[0] = 'X';
            defer Allocator.free(ownedSlice);

            try expectStrings(ownedSlice, "Xello, World!");
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝