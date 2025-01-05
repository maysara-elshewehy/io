// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../mods/Bytes.zig");
    const String = @import("../mods/String.zig").String;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.init" {
            var str = String.init(); defer str.deinit();
            try std.testing.expect(str.size() == 0);
            try std.testing.expect(str.len() == 0);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.initAlloc" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = String.initAlloc(gpa.allocator()); defer str.deinit();
            try std.testing.expect(str.size() == 0);
            try std.testing.expect(str.len() == 0);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.initWith (empty value)" {
            var str = try String.initWith(""); defer str.deinit();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.len());
            try std.testing.expectEqual(0, str.size());
        }

        test "String.initWith (non-empty value)" {
            var str = try String.initWith("Hello 🌍!"); defer str.deinit();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.initWith (character value)" {
            var str = try String.initWith('H'); defer str.deinit();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(2, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.initWith (String value)" {
            var ref = try String.initWith('H'); defer ref.deinit();
            var str = try String.initWith(ref); defer str.deinit();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(2, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.initWith (constant array)" {
            const src = "Hello 🌍!";
            var str = try String.initWith(src); defer str.deinit();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.initWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            var str = try String.initWith(src[0..]); defer str.deinit();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());

            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.initAllocWith (empty value)" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.initAllocWith(gpa.allocator(), ""); defer str.deinit();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.len());
            try std.testing.expectEqual(0, str.size());
        }

        test "String.initAllocWith (non-empty value)" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.initAllocWith(gpa.allocator(), "Hello 🌍!"); defer str.deinit();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.initAllocWith (constant array)" {
            const src = "Hello 🌍!";
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.initAllocWith(gpa.allocator(), src); defer str.deinit();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.initAllocWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.initAllocWith(gpa.allocator(), src[0..]); defer str.deinit();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());

            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.instant (empty value)" {
            var str = try String.instant(""); defer str.deinit();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.size());
            try std.testing.expectEqual(0, str.len());
        }

        test "String.instant (non-empty value)" {
            var str = try String.instant("Hello 🌍!"); defer str.deinit();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(11, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.instant (character)" {
            var str = try String.instant('H'); defer str.deinit();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(1, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.instant (constant array)" {
            const src = "Hello 🌍!";
            var str = try String.instant(src); defer str.deinit();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(11, str.size());
            try std.testing.expectEqual(11, str.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.len/size (empty value)" {
            var str = try String.instant(""); defer str.deinit();
            try std.testing.expect(str.len() == 0);
            try std.testing.expect(str.size() == 0);
        }

        test "String.len/size (non-empty value) (instant)" {
            var str = try String.instant("Hello 🌍!"); defer str.deinit();
            try std.testing.expect(str.len() == 11);
            try std.testing.expect(str.size() == 11);
        }

        test "String.len/size (non-empty value) (initWith)" {
            var str = try String.initWith("Hello 🌍!"); defer str.deinit();
            try std.testing.expect(str.len() == 11);
            try std.testing.expect(str.size() == 22);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝