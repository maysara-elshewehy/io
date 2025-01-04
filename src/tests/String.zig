// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../modules/Bytes.zig");
    const String = @import("../modules/String.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.make" {
            var str = String.make(); defer str.free();
            try std.testing.expect(str.size() == 0);
            try std.testing.expect(str.len() == 0);
        }

        test "String.makeAlloc" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = String.makeAlloc(gpa.allocator()); defer str.free();
            try std.testing.expect(str.size() == 0);
            try std.testing.expect(str.len() == 0);
        }

        test "String.makeWith (empty value)" {
            var str = try String.makeWith(""); defer str.free();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.len());
            try std.testing.expectEqual(0, str.size());
        }

        test "String.makeAllocWith (empty value)" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.makeAllocWith(gpa.allocator(), ""); defer str.free();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.len());
            try std.testing.expectEqual(0, str.size());
        }

        test "String.makeWith (non-empty value)" {
            var str = try String.makeWith("Hello 🌍!"); defer str.free();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.makeWith (character value)" {
            var str = try String.makeWith('H'); defer str.free();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(2, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.makeWith (String value)" {
            var ref = try String.makeWith('H'); defer ref.free();
            var str = try String.makeWith(ref); defer str.free();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(2, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.makeAllocWith (non-empty value)" {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.makeAllocWith(gpa.allocator(), "Hello 🌍!"); defer str.free();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.makeWith (constant array)" {
            const src = "Hello 🌍!";
            var str = try String.makeWith(src); defer str.free();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.makeAllocWith (constant array)" {
            const src = "Hello 🌍!";
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.makeAllocWith(gpa.allocator(), src); defer str.free();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.makeWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            var str = try String.makeWith(src[0..]); defer str.free();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());

            try std.testing.expectEqual(22, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.makeAllocWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            var str = try String.makeAllocWith(gpa.allocator(), src[0..]); defer str.free();
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

        test "String.clone (empty value)" {
            var str = try String.clone(""); defer str.free();
            try std.testing.expectEqualStrings("", str.src());
            try std.testing.expectEqual(0, str.size());
            try std.testing.expectEqual(0, str.len());
        }

        test "String.clone (non-empty value)" {
            var str = try String.clone("Hello 🌍!"); defer str.free();
            try std.testing.expectEqualStrings("Hello 🌍!", str.src());
            try std.testing.expectEqual(11, str.size());
            try std.testing.expectEqual(11, str.len());
        }

        test "String.clone (character)" {
            var str = try String.clone('H'); defer str.free();
            try std.testing.expectEqualStrings("H", str.src());
            try std.testing.expectEqual(1, str.size());
            try std.testing.expectEqual(1, str.len());
        }

        test "String.clone (constant array)" {
            const src = "Hello 🌍!";
            var str = try String.clone(src); defer str.free();
            try std.testing.expectEqualStrings(src[0..11], str.src());
            try std.testing.expectEqual(11, str.size());
            try std.testing.expectEqual(11, str.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "String.len" {
            var str1 = try String.clone(""); defer str1.free();
            var str2 = try String.clone("Hello 🌍!"); defer str2.free();
            try std.testing.expect(str1.len()           == 0);
            try std.testing.expect(str2.len()  == 11);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝