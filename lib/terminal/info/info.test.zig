// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std               = @import("std");
    const testing           = std.testing;
    const info              = @import("./info.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        test "info.TerminalInfo" {
            const TerminalInfo = info.TerminalInfo;
            try testing.expect(@hasField(TerminalInfo, "height"));
            try testing.expect(@hasField(TerminalInfo, "width"));
            try testing.expect(@hasField(TerminalInfo, "rows"));
            try testing.expect(@hasField(TerminalInfo, "cols"));
            try testing.expect(@hasField(TerminalInfo, "cursor"));
        }

        test "info.Cursor" {
            // struct
            const Cursor = info.Cursor;
            try testing.expect(@hasField(Cursor, "x"));
            try testing.expect(@hasField(Cursor, "y"));

            // set
            const cursor = Cursor{ .x = 0, .y = 0 };
            try info.setCursor(cursor);

            // get
            const new_cursor = try info.getCursor();
            try testing.expectEqual(cursor.x, new_cursor.x);
            try testing.expectEqual(cursor.y, new_cursor.y);

            // set and clear
            try info.setCursorAndClear(cursor);
        }

        test "info.get" {
            const _info = try info.get();
            try testing.expect(_info.height > 0);
            try testing.expect(_info.width > 0);
            try testing.expect(_info.rows > 0);
            try testing.expect(_info.cols > 0);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
