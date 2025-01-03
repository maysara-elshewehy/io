// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../modules/Bytes.zig");

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

        test "Bytes.make      (> 0)" {
            const buf = try Bytes.make(64);
            try std.testing.expect(buf.len == 64);
            try std.testing.expect(buf[0] == 0);
        }

        test "Bytes.make      (0) error ZeroValue" {
            try std.testing.expectError(error.ZeroValue, Bytes.make(0));
        }

        test "Bytes.makeWith    (empty value)" {
            try std.testing.expectError(error.ZeroValue, Bytes.makeWith(64, ""));
        }

        test "Bytes.makeWith    (non-empty value)" {
            const buf = try Bytes.makeWith(64, "Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.makeWith    (constant array)" {
            const src = "Hello 🌍!";
            const buf = try Bytes.makeWith(64, src);
            try std.testing.expectEqualStrings(src[0..11], buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.makeWith    (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            const buf = try Bytes.makeWith(64, src[0..]);
            try std.testing.expectEqualStrings(src[0..11], buf[0..11]);
            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);

            try std.testing.expectEqual(64, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.makeWith    (OutOfRange)" {
            try std.testing.expectError(error.OutOfRange, Bytes.makeWith(1, "122"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Bytes.clone     (empty value)" {
            const buf = Bytes.clone("");
            try std.testing.expectEqualStrings("", buf[0..0]);
            try std.testing.expectEqual(0, buf.len);
            try std.testing.expectEqual(0, Bytes.count(buf[0..]));
        }

        test "Bytes.clone     (non-empty value)" {
            const buf = Bytes.clone("Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf[0..11]);
            try std.testing.expectEqual(11, buf.len);
            try std.testing.expectEqual(11, Bytes.count(buf[0..]));
        }

        test "Bytes.clone     (constant array)" {
            const src = "Hello 🌍!";
            const buf = Bytes.clone(src);
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