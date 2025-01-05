// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../mods/Bytes.zig");
    const Buffer = @import("../mods/Buffer.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.init (> 0)" {
            const buf = try Buffer.init(64);
            try std.testing.expect(buf.size() == 64);
            try std.testing.expect(buf.len() == 0);
        }

        test "Buffer.init (0) error ZeroValue" {
            try std.testing.expectError(error.ZeroValue, Buffer.init(0));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐


        test "Buffer.initWith (empty value)" {
            try std.testing.expectError(error.ZeroValue, Buffer.initWith(64, ""));
        }

        test "Buffer.initWith (non-empty value)" {
            const buf = try Buffer.initWith(64, "Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.initWith (character)" {
            const buf = try Buffer.initWith(64, 'H');
            try std.testing.expectEqualStrings("H", buf.m_buff[0..1]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(1, buf.len());
        }

        test "Buffer.initWith (constant array)" {
            const src = "Hello 🌍!";
            const buf = try Buffer.initWith(64, src);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.initWith (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            const buf = try Buffer.initWith(64, src[0..]);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);

            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.initWith (OutOfRange)" {
            try std.testing.expectError(error.OutOfRange, Buffer.initWith(1, "122"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.instant (empty value)" {
            const buf = Buffer.instant("");
            try std.testing.expectEqualStrings("", buf.m_buff[0..0]);
            try std.testing.expectEqual(0, buf.size());
            try std.testing.expectEqual(0, buf.len());
        }

        test "Buffer.instant (non-empty value)" {
            const buf = Buffer.instant("Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);
            try std.testing.expectEqual(11, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.instant (constant array)" {
            const src = "Hello 🌍!";
            const buf = Buffer.instant(src);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(11, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.len" {
            try std.testing.expect(Buffer.instant("").len()           == 0);
            try std.testing.expect(Buffer.instant("Hello 🌍!").len()  == 11);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝