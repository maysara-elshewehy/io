// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std               = @import("std");
    const utils             = @import("./ansi.zig");
    const BigBuffer         = @import("../../string/string.zig").Buffer(u8, 256);
    const expect            = std.testing.expect;
    const expectEqual       = std.testing.expectEqual;
    const expectError       = std.testing.expectError;
    const expectStrings     = std.testing.expectEqualStrings;
    const expectSlices      = std.testing.expectEqualSlices;
    const help              = @import("./ansi.help.zig");
    const csi               = "\x1b[";
    const some_text         = "some_text";

    fn print (msg: []const u8) void { std.debug.print("{s} \n", .{msg}); }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    // ┌──────────────────────────── Clear ───────────────────────────┐

        test "terminal.utils.clear.all" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.all(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_all,
                buffer.m_src[0..some_text.len+csi.len+help.clear_all.len]
            );
        }

        test "terminal.utils.clear.line" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.line(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_line,
                buffer.m_src[0..some_text.len+csi.len+help.clear_line.len]
            );
        }

        test "terminal.utils.clear.screenFromCursor" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.screenFromCursor(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_screen_from_cursor,
                buffer.m_src[0..some_text.len+csi.len+help.clear_screen_from_cursor.len]
            );
        }

        test "terminal.utils.clear.screenToCursor" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.screenToCursor(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_screen_to_cursor,
                buffer.m_src[0..some_text.len+csi.len+help.clear_screen_to_cursor.len]
            );
        }

        test "terminal.utils.clear.lineFromCursor" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.lineFromCursor(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_line_from_cursor,
                buffer.m_src[0..some_text.len+csi.len+help.clear_line_from_cursor.len]
            );
        }

        test "terminal.utils.clear.lineToCursor" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.clear.lineToCursor(buffer.writer());
            try expectSlices(u8,
                some_text++csi++help.clear_line_to_cursor,
                buffer.m_src[0..some_text.len+csi.len+help.clear_line_to_cursor.len]
            );
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Cursor ───────────────────────────┐

        test "terminal.utils.cursor.goTo" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.goTo(buffer.writer(), 3, 7);
            const x = "7;3H";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.goUp" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.goUp(buffer.writer(), 7);
            const x = "7A";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.goDown" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.goDown(buffer.writer(), 7);
            const x = "7B";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.goLeft" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.goLeft(buffer.writer(), 3);
            const x = "3D";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.goRight" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.goRight(buffer.writer(), 3);
            const x = "3C";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.hide" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.hide(buffer.writer());
            const x = "?25l";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.show" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.show(buffer.writer());
            const x = "?25h";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.save" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.save(buffer.writer());
            const x = "u";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.cursor.restore" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.cursor.restore(buffer.writer());
            const x = "s";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Colors ──────────────────────────┐

        test "terminal.utils.colors.fg256" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.colors.fg256(buffer.writer(), .red);
            const x = help.fg_256 ++ "1m";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.colors.bg256" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.colors.bg256(buffer.writer(), .red);
            const x = help.bg_256 ++ "1m";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.colors.fgRGB" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.colors.fgRGB(buffer.writer(), 255, 244, 233);
            const x = help.fg_rgb ++ "255;244;233m";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.colors.bgRGB" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.colors.bgRGB(buffer.writer(), 255, 244, 233);
            const x = help.bg_rgb ++ "255;244;233m";
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.colors.resetAll" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.colors.resetAll(buffer.writer());
            const x = help.reset_all;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Attributes ────────────────────────┐

        test "terminal.utils.attr.reset" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.reset(buffer.writer());
            const x = help.reset_all;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.bold" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.bold(buffer.writer());
            const x = help.attr_bold;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noBold" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noBold(buffer.writer());
            const x = help.attr_no_bold;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.dim" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.dim(buffer.writer());
            const x = help.attr_dim;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noDim" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noDim(buffer.writer());
            const x = help.attr_no_dim;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.italic" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.italic(buffer.writer());
            const x = help.attr_italic;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noItalic" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noItalic(buffer.writer());
            const x = help.attr_no_italic;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.underline" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.underline(buffer.writer());
            const x = help.attr_underline;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noUnderline" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noUnderline(buffer.writer());
            const x = help.attr_no_underline;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.blinking" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.blinking(buffer.writer());
            const x = help.attr_blinking;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noBlinking" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noBlinking(buffer.writer());
            const x = help.attr_no_blinking;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.reverse" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.reverse(buffer.writer());
            const x = help.attr_reverse;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noReverse" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noReverse(buffer.writer());
            const x = help.attr_no_reverse;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.hidden" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.hidden(buffer.writer());
            const x = help.attr_invisible;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noHidden" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noHidden(buffer.writer());
            const x = help.attr_no_invisible;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.strikethrough" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.strikethrough(buffer.writer());
            const x = help.attr_strikethrough;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

        test "terminal.utils.attr.noStrikethrough" {
            var buffer = BigBuffer.initWithSlice(some_text);
            try utils.attr.noStrikethrough(buffer.writer());
            const x = help.attr_no_strikethrough;
            try expectSlices(u8,
                some_text++csi++x,
                buffer.m_src[0..some_text.len+csi.len+x.len]
            );
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
