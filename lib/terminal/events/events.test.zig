// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std       = @import("std");
    const testing   = std.testing;
    const types     = @import("./events.types.zig");
    const Buffer    = @import("../../string/string.zig").Buffer;
    const Key       = types.Key;
    const Mouse     = types.Mouse;
    const Event     = types.Event;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    // ┌──────────────────────────── Key ─────────────────────────────┐

        test "Key.isAlphabetic" {
            var k1 : Key = .{};
            try testing.expect(!k1.isAlphabetic());

            for ('A'..'Z' + 1) |c| {
                var k : Key = .{ .m_key = .{ @intCast(c), 0, 0, 0 } };
                try testing.expect(k.isAlphabetic());

                // format test
                var b = Buffer(u8, 256).initEmpty();
                try k.printTo(b.writer());
                try testing.expectEqualSlices(u8, &.{@intCast(c)}, b.src());
            }
        }

        test "Key.isNumeric" {
            var k1 : Key = .{};
            try testing.expect(!k1.isNumeric());

            for ('0'..'9' + 1) |c| {
                var k : Key = .{ .m_key = .{ @intCast(c), 0, 0, 0 } };
                try testing.expect(k.isNumeric());

                // format test
                var b = Buffer(u8, 256).initEmpty();
                try k.printTo(b.writer());
                try testing.expectEqualSlices(u8, &.{@intCast(c)}, b.src());
            }
        }

        test "Key.isShift" {
            var k : Key = .{};
            try testing.expect(!k.isShift());

            k.m_mask |= Key.Bitmask.Shift;
            try testing.expect(k.isShift());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Shift + ", b.src());
        }

        test "Key.isAlt" {
            var k : Key = .{};
            try testing.expect(!k.isAlt());

            k.m_mask |= Key.Bitmask.Alt;
            try testing.expect(k.isAlt());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Alt + ", b.src());
        }

        test "Key.isAltCtrl" {
            var k : Key = .{};
            try testing.expect(!k.isAltCtrl());

            k.m_mask |= (Key.Bitmask.Alt | Key.Bitmask.Ctrl);
            try testing.expect(k.isAltCtrl());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Alt + ", b.src());
        }

        test "Key.isAltShift" {
            var k : Key = .{};
            try testing.expect(!k.isAltShift());

            k.m_mask |= (Key.Bitmask.Alt | Key.Bitmask.Shift);
            try testing.expect(k.isAltShift());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Shift + Alt + ", b.src());
        }

        test "Key.isCtrl" {
            var k : Key = .{};
            try testing.expect(!k.isCtrl());

            k.m_mask |= Key.Bitmask.Ctrl;
            try testing.expect(k.isCtrl());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Ctrl + ", b.src());
        }

        test "Key.isCtrlShift" {
            var k : Key = .{};
            try testing.expect(!k.isCtrlShift());

            k.m_mask |= (Key.Bitmask.Ctrl | Key.Bitmask.Shift);
            try testing.expect(k.isCtrlShift());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Shift + ", b.src());
        }

        test "Key.isCtrlAltShift" {
            var k : Key = .{};
            try testing.expect(!k.isCtrlAltShift());

            k.m_mask |= (Key.Bitmask.Ctrl | Key.Bitmask.Alt | Key.Bitmask.Shift);
            try testing.expect(k.isCtrlAltShift());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Shift + Alt + ", b.src());
        }

        test "Key.isModifier" {
            var k : Key = .{};
            try testing.expect(!k.isModifier());

            // format test
            var B = Buffer(u8, 256).initEmpty();
            try k.printTo(B.writer());
            try testing.expectEqualSlices(u8, "", B.src());

            k.m_mask |= Key.Bitmask.Alt;
            try testing.expect(k.isModifier());

            // format test
            var b2 = Buffer(u8, 256).initEmpty();
            try k.printTo(b2.writer());
            try testing.expectEqualSlices(u8, "Alt + ", b2.src());
        }

        test "Key (Character and Modifiers)" {
            var k: Key = .{ .m_read = &[_]u8{0, 0, 0, 0}, .m_key = .{ 'A', 0, 0, 0}, .m_mask = Key.Bitmask.Ctrl | Key.Bitmask.Shift };
            try testing.expect(k.isAlphabetic());
            try testing.expect(k.isCtrlShift());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Shift + A", b.src());

            k.m_mask |= Key.Bitmask.Alt;
            try testing.expect(k.isAlt());

            // format test
            var b2 = Buffer(u8, 256).initEmpty();
            try k.printTo(b2.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Shift + Alt + A", b2.src());
        }

        test "Key.isF1" {
            var k : Key = .{};
            try testing.expect(!k.isF1());

            k.m_mask |= Key.Bitmask.F1;
            try testing.expect(k.isF1());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F1", b.src());
        }

        test "Key.isF2" {
            var k : Key = .{};
            try testing.expect(!k.isF2());

            k.m_mask |= Key.Bitmask.F2;
            try testing.expect(k.isF2());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F2", b.src());
        }

        test "Key.isF3" {
            var k : Key = .{};
            try testing.expect(!k.isF3());

            k.m_mask |= Key.Bitmask.F3;
            try testing.expect(k.isF3());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F3", b.src());
        }

        test "Key.isF4" {
            var k : Key = .{};
            try testing.expect(!k.isF4());

            k.m_mask |= Key.Bitmask.F4;
            try testing.expect(k.isF4());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F4", b.src());
        }

        test "Key.isF5" {
            var k : Key = .{};
            try testing.expect(!k.isF5());

            k.m_mask |= Key.Bitmask.F5;
            try testing.expect(k.isF5());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F5", b.src());
        }

        test "Key.isF6" {
            var k : Key = .{};
            try testing.expect(!k.isF6());

            k.m_mask |= Key.Bitmask.F6;
            try testing.expect(k.isF6());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F6", b.src());
        }

        test "Key.isF7" {
            var k : Key = .{};
            try testing.expect(!k.isF7());

            k.m_mask |= Key.Bitmask.F7;
            try testing.expect(k.isF7());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F7", b.src());
        }

        test "Key.isF8" {
            var k : Key = .{};
            try testing.expect(!k.isF8());

            k.m_mask |= Key.Bitmask.F8;
            try testing.expect(k.isF8());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F8", b.src());
        }

        test "Key.isF9" {
            var k : Key = .{};
            try testing.expect(!k.isF9());

            k.m_mask |= Key.Bitmask.F9;
            try testing.expect(k.isF9());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F9", b.src());
        }

        test "Key.isF10" {
            var k : Key = .{};
            try testing.expect(!k.isF10());

            k.m_mask |= Key.Bitmask.F10;
            try testing.expect(k.isF10());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F10", b.src());
        }

        test "Key.isF11" {
            var k : Key = .{};
            try testing.expect(!k.isF11());

            k.m_mask |= Key.Bitmask.F11;
            try testing.expect(k.isF11());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F11", b.src());
        }

        test "Key.isF12" {
            var k : Key = .{};
            try testing.expect(!k.isF12());

            k.m_mask |= Key.Bitmask.F12;
            try testing.expect(k.isF12());

            // format test
            var b = Buffer(u8, 256).initEmpty();
            try k.printTo(b.writer());
            try testing.expectEqualSlices(u8, "F12", b.src());
        }

        test "Key (Function and Modifiers)" {
            var k : Key = .{};
            try testing.expect(!k.isF1());
            k.m_mask |= Key.Bitmask.F1;
            try testing.expect(k.isF1());

            // format test
            var b1 = Buffer(u8, 256).initEmpty();
            try k.printTo(b1.writer());
            try testing.expectEqualSlices(u8, "F1", b1.src());

            k.m_mask |= Key.Bitmask.Alt;
            try testing.expect(k.isF1());
            try testing.expect(k.isAlt());

            // format test
            var b2 = Buffer(u8, 256).initEmpty();
            try k.printTo(b2.writer());
            try testing.expectEqualSlices(u8, "Alt + F1", b2.src());

            k.m_mask |= Key.Bitmask.Ctrl;
            try testing.expect(k.isF1());
            try testing.expect(k.isAlt());
            try testing.expect(k.isCtrl());

            // format test
            var b3 = Buffer(u8, 256).initEmpty();
            try k.printTo(b3.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Alt + F1", b3.src());

            k.m_mask |= Key.Bitmask.Shift;
            try testing.expect(k.isF1());
            try testing.expect(k.isAlt());
            try testing.expect(k.isCtrl());
            try testing.expect(k.isShift());

            // format test
            var b4 = Buffer(u8, 256).initEmpty();
            try k.printTo(b4.writer());
            try testing.expectEqualSlices(u8, "Ctrl + Shift + Alt + F1", b4.src());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
