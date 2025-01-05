// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../mods/Bytes.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.isByte" {
            try std.testing.expect(Bytes.isByte(255));
            try std.testing.expect(!Bytes.isByte(256));

            try std.testing.expect(Bytes.isByte(@as(u8, 0)));
            try std.testing.expect(Bytes.isByte(@as(u8, 255)));

            try std.testing.expect(Bytes.isByte(@as(comptime_int, 0)));
            try std.testing.expect(Bytes.isByte(@as(comptime_int, 255)));
            try std.testing.expect(!Bytes.isByte(@as(comptime_int, 256)));

            try std.testing.expect(!Bytes.isByte(@as(u9, 255)));
            try std.testing.expect(!Bytes.isByte(@as(i4, -2)));
        }

        test "Bytes.isBytes" {
            try std.testing.expect(Bytes.isBytes(@as(Bytes.Types.bytes, &[_]u8{})));
            try std.testing.expect(Bytes.isBytes(@as(Bytes.Types.cbytes, &[_]u8{})));
            try std.testing.expect(Bytes.isBytes(@as(Bytes.Types.cbytes, &[_]u8{})));
            try std.testing.expect(!Bytes.isBytes(0));
            try std.testing.expect(!Bytes.isBytes(true));
            try std.testing.expect(!Bytes.isBytes(255));
            try std.testing.expect(!Bytes.isBytes('c'));
            try std.testing.expect(Bytes.isBytes(""));
            try std.testing.expect(Bytes.isBytes("Hello World!"));
        }

        test "Bytes.toByte" {
            try std.testing.expect(try Bytes.toByte(100) == 100);
            try std.testing.expect(@as(Bytes.Types.byte, try Bytes.toByte(255)) == 255);
            try std.testing.expectError(error.OutOfRange, Bytes.toByte(256));
            try std.testing.expectError(error.OutOfRange, Bytes.toByte(-1));

            try std.testing.expectError(error.InvalidType, Bytes.toByte(true));
            try std.testing.expectError(error.InvalidType, Bytes.toByte(".."));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.init (> 0)" {
            const buf = try Bytes.init(64);
            try std.testing.expect(buf.len == 64);
            try std.testing.expect(buf[0] == 0);
        }

        test "Bytes.init (0) error ZeroValue" {
            try std.testing.expectError(error.ZeroValue, Bytes.init(0));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.initWith (empty value)" {
            try std.testing.expectError(error.ZeroValue, Bytes.initWith(64, ""));
        }

        test "Bytes.initWith (non-empty value)" {
            const buf = try Bytes.initWith(64, "Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.initWith (character)" {
            const buf = try Bytes.initWith(64, 'H');
            try std.testing.expectEqualStrings("H", buf[0..1]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(1, Bytes.count(buf[0..]));
        }

        test "Bytes.initWith (constant array)" {
            const src = "Hello 🌍!";
            const buf = try Bytes.initWith(64, src);
            try std.testing.expectEqualStrings(src[0..11], buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.initWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            const buf = try Bytes.initWith(64, src[0..]);
            try std.testing.expectEqualStrings(src[0..11], buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);

            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.initWith (OutOfRange)" {
            try std.testing.expectError(error.OutOfRange, Bytes.initWith(1, "122"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.copy (non-empty value)" {
            var str = try Bytes.init(64);
            Bytes.copy(&str, "Hello 🌍!");
            try std.testing.expectEqualStrings(str[0..11], str[0..11]);
            try std.testing.expectEqual(64, str.len);
            try std.testing.expectEqual(11, Bytes.count(&str));
        }

        test "Bytes.copy (empty value)" {
            var str = try Bytes.init(64);
            Bytes.copy(&str, "");
            try std.testing.expectEqualStrings("", str[0..0]);
            try std.testing.expectEqual(64, str.len);
            try std.testing.expectEqual(0, Bytes.count(&str));
        }

        test "Bytes.copy (constant array)" {
            var str = try Bytes.init(64);
            const src = "Hello 🌍!";
            Bytes.copy(&str, src);
            try std.testing.expectEqualStrings(src[0..11], str[0..11]);
            try std.testing.expectEqual(64, str.len);
            try std.testing.expectEqual(11, Bytes.count(&str));
        }

        test "Bytes.copy (mutable array)" {
            var str = try Bytes.init(64);
            var src: [11]u8 = "Hello 🌍!".*;
            Bytes.copy(&str, src[0..]);
            try std.testing.expectEqualStrings(src[0..11], str[0..11]);
            try std.testing.expectEqual(64, str.len);
            try std.testing.expectEqual(11, Bytes.count(&str));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.instant (empty value)" {
            const buf = Bytes.instant("");
            try std.testing.expectEqualStrings("", buf[0..0]);
            try std.testing.expectEqual(0, buf.len);
            try std.testing.expectEqual(0, Bytes.count(buf[0..]));
        }

        test "Bytes.instant (non-empty value)" {
            const buf = Bytes.instant("Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);
            try std.testing.expectEqual(11, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.instant (constant array)" {
            const src = "Hello 🌍!";
            const buf = Bytes.instant(src);
            try std.testing.expectEqualStrings(src[0..11], buf[0..11]);
            try std.testing.expectEqual(11, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.count" {
            try std.testing.expectEqual(0, Bytes.count(""));
            try std.testing.expectEqual(1, Bytes.count("A"));
            try std.testing.expectEqual(2, Bytes.count("AB"));
            try std.testing.expectEqual(3, Bytes.count("ABC"));
            try std.testing.expectEqual(2, Bytes.count("ب"));
            try std.testing.expectEqual(3, Bytes.count("你"));
            try std.testing.expectEqual(4, Bytes.count("🌟"));
            try std.testing.expectEqual(6, Bytes.count("☹️"));
            try std.testing.expectEqual(11, Bytes.count("👨‍🏭"));
            try std.testing.expectEqual(17, Bytes.count("🚵🏻‍♀️"));
            try std.testing.expectEqual(25, Bytes.count("👨‍👩‍👧‍👦"));
            try std.testing.expectEqual(11, Bytes.count("Hello 🌍!"));
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝