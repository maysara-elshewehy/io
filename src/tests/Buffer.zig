// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../modules/Bytes.zig");
    const Buffer = @import("../modules/Buffer.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.make      (> 0)" {
            const buf = try Buffer.make(64);
            try std.testing.expect(buf.size() == 64);
            try std.testing.expect(buf.len() == 0);
        }

        test "Buffer.make      (0) error ZeroValue" {
            try std.testing.expectError(error.ZeroValue, Buffer.make(0));
        }

        test "Buffer.makeWith    (empty value)" {
            try std.testing.expectError(error.ZeroValue, Buffer.makeWith(64, ""));
        }

        test "Buffer.makeWith    (non-empty value)" {
            const buf = try Buffer.makeWith(64, "Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.makeWith    (constant array)" {
            const src = "Hello 🌍!";
            const buf = try Buffer.makeWith(64, src);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.makeWith    (mutable array)" {
            var src: [11]u8 = "Hello 🌍!".*;
            const buf = try Buffer.makeWith(64, src[0..]);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());

            src[0] = 'X';
            try std.testing.expectEqualStrings("Xello 🌍!", src[0..11]);
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);

            try std.testing.expectEqual(64, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.makeWith    (OutOfRange)" {
            try std.testing.expectError(error.OutOfRange, Buffer.makeWith(1, "122"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.clone     (empty value)" {
            const buf = Buffer.clone("");
            try std.testing.expectEqualStrings("", buf.m_buff[0..0]);
            try std.testing.expectEqual(0, buf.size());
            try std.testing.expectEqual(0, buf.len());
        }

        test "Buffer.clone     (non-empty value)" {
            const buf = Buffer.clone("Hello 🌍!");
            try std.testing.expectEqualStrings("Hello 🌍!", buf.m_buff[0..11]);
            try std.testing.expectEqual(11, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

        test "Buffer.clone     (constant array)" {
            const src = "Hello 🌍!";
            const buf = Buffer.clone(src);
            try std.testing.expectEqualStrings(src[0..11], buf.m_buff[0..11]);
            try std.testing.expectEqual(11, buf.size());
            try std.testing.expectEqual(11, buf.len());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "Buffer.len" {
            try std.testing.expect(Buffer.clone("").len()           == 0);
            try std.testing.expect(Buffer.clone("Hello 🌍!").len()  == 11);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝