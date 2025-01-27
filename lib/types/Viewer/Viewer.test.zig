// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Viewer = @import("./Viewer.zig").Viewer;

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
            try expectError(error.ZeroSize, Viewer.init(emptyUtf8));

            // non empty input (valid UTF-8)
            const validUtf8: []const u8 = "Hello, 世界!";
            const buffer = try Viewer.init(validUtf8);
            try expectStrings(validUtf8, buffer.m_source[0..]);

            // non empty input (invalid UTF-8)
            // try expectError(unreachable, Viewer.init(&[_]u8{0x80, 0x81, 0x82}));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐

        test "iterator" {
            const validUtf8: []const u8 = "Hello, 世界!";
            const viewer = try Viewer.init(validUtf8);
            var iter = viewer.iterator();

            while(iter.nextSlice()) |slice| {
                try expect(utf8.utils.isValid(slice));
            }

            // Ensure all characters were iterated
            try expectEqual(validUtf8.len, iter.current_index);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "Viewer.find" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
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
                try expectEqual(c.expected, viewer.find(c.value));
            }
        }

        test "Viewer.findVisual" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
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
                try expectEqual(c.expected, viewer.findVisual(c.value));
            }
        }

        test "Viewer.rfind" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
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
                try expectEqual(c.expected, viewer.rfind(c.value));
            }
        }

        test "Viewer.rfindVisual" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
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
                try expectEqual(c.expected, viewer.rfindVisual(c.value));
            }
        }

        test "Viewer.includes" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
            try expect(viewer.includes("H"));
            try expect(viewer.includes("e"));
            try expect(viewer.includes("l"));
            try expect(viewer.includes("o"));
            try expect(viewer.includes(" "));
            try expect(viewer.includes("👨‍🏭"));
            try expect(viewer.includes("!"));
            try expect(!viewer.includes("@"));
        }

        test "Viewer.startsWith" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
            try expect(viewer.startsWith("H"));
            try expect(!viewer.startsWith("👨‍🏭"));
        }

        test "Viewer.endsWith" {
            const viewer = try Viewer.init("Hello 👨‍🏭!");
            try expect(viewer.endsWith("!"));
            try expect(!viewer.endsWith("👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "slice" {
            const txt = &[_]u8{ '1', 0, 0 };
            const viewer = try Viewer.init(txt);
            try expectStrings("1", viewer.slice());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝