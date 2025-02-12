// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Thanks to `https://github.com/xyaman/mibu/`
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std = @import("std");
    const help = @import("./ansi.help.zig");
    const unicodeIterator = @import("../../string/utils/unicode/unicode.zig").Iterator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌─────────────────────────── Clear ────────────────────────────┐

        pub const clear = struct {

            /// Clear all screen
            pub inline fn all(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_all, .{});
            }

            /// Clear entire line
            pub inline fn line(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_line, .{});
            }

            /// Clear from cursor until end of screen
            pub inline fn screenFromCursor(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_screen_from_cursor, .{});
            }

            /// Clear from cursor to beginning of screen
            pub inline fn screenToCursor(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_screen_to_cursor, .{});
            }

            /// Clear from cursor to end of line
            pub inline fn lineFromCursor(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_line_from_cursor, .{});
            }

            /// Clear start of line to the cursor
            pub inline fn lineToCursor(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.clear_line_to_cursor, .{});
            }
        };

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Cursor ───────────────────────────┐

        pub const cursor = struct {

            /// Moves cursor to `x` column and `y` row
            pub inline fn goTo(writer: anytype, x: anytype, y: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "{d};{d}H", .{ y, x });
            }

            /// Moves cursor up `y` rows
            pub inline fn goUp(writer: anytype, y: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "{d}A", .{ y });
            }

            /// Moves cursor up `y` rows
            pub inline fn goDown(writer: anytype, y: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "{d}B", .{ y });
            }

            /// Moves cursor left `x` columns
            pub inline fn goLeft(writer: anytype, x: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "{d}D", .{ x });
            }

            /// Moves cursor right `x` columns
            pub inline fn goRight(writer: anytype, x: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "{d}C", .{ x });
            }

            /// Hide the cursor
            pub inline fn hide(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "?25l", .{});
            }

            /// Show the cursor
            pub inline fn show(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "?25h", .{});
            }

            /// Save the cursor position
            pub inline fn save(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "u", .{});
            }

            /// Restore the cursor position
            pub inline fn restore(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ "s", .{});
            }
        };

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Colors ───────────────────────────┐

        pub const colors = struct {

            /// Writes the escape sequence code to change foreground to `color` (using 256 colors)
            pub fn fg256(writer: anytype, color: help.Color) !void {
                return std.fmt.format(writer, help.csi ++ help.fg_256 ++ "{d}m", .{@intFromEnum(color)});
            }

            /// Writes the escape sequence code to change background to `color` (using 256 colors)
            pub fn bg256(writer: anytype, color: help.Color) !void {
                return std.fmt.format(writer, help.csi ++ help.bg_256 ++ "{d}m", .{@intFromEnum(color)});
            }

            /// Writes the escape sequence code to change foreground to rgb color
            pub fn fgRGB(writer: anytype, r: u8, g: u8, b: u8) !void {
                return std.fmt.format(writer, help.csi ++ help.fg_rgb ++ "{d};{d};{d}m", .{ r, g, b });
            }

            /// Writes the escape sequence code to change background to rgb color
            pub fn bgRGB(writer: anytype, r: u8, g: u8, b: u8) !void {
                return std.fmt.format(writer, help.csi ++ help.bg_rgb ++ "{d};{d};{d}m", .{ r, g, b });
            }

            /// Writes the escape code to reset style and color
            pub fn resetAll(writer: anytype) !void {
                return std.fmt.format(writer, help.csi ++ help.reset_all, .{});
            }
        };

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Attributes ────────────────────────┐

        pub const attr = struct {

            /// Returns the ANSI sequence as a []const u8
            pub fn reset(writer: anytype) !void {
                return std.fmt.format(writer, help.reset, .{});
            }

            /// Returns the ANSI sequence to set bold mode
            pub fn bold(writer: anytype) !void {
                return std.fmt.format(writer, help.bold, .{});
            }

            /// Returns the ANSI sequence to unset bold mode
            pub fn noBold(writer: anytype) !void {
                return std.fmt.format(writer, help.no_bold, .{});
            }

            /// Returns the ANSI sequence to set dim mode
            pub fn dim(writer: anytype) !void {
                return std.fmt.format(writer, help.dim, .{});
            }

            /// Returns the ANSI sequence to unset dim mode
            pub fn noDim(writer: anytype) !void {
                return std.fmt.format(writer, help.no_dim, .{});
            }

            /// Returns the ANSI sequence to set italic mode
            pub fn italic(writer: anytype) !void {
                return std.fmt.format(writer, help.italic, .{});
            }

            /// Returns the ANSI sequence to unset italic mode
            pub fn noItalic(writer: anytype) !void {
                return std.fmt.format(writer, help.no_italic, .{});
            }

            /// Returns the ANSI sequence to set underline mode
            pub fn underline(writer: anytype) !void {
                return std.fmt.format(writer, help.underline, .{});
            }

            /// Returns the ANSI sequence to unset underline mode
            pub fn noUnderline(writer: anytype) !void {
                return std.fmt.format(writer, help.no_underline, .{});
            }

            /// Returns the ANSI sequence to set blinking mode
            pub fn blinking(writer: anytype) !void {
                return std.fmt.format(writer, help.blinking, .{});
            }

            /// Returns the ANSI sequence to unset blinking mode
            pub fn noBlinking(writer: anytype) !void {
                return std.fmt.format(writer, help.no_blinking, .{});
            }

            /// Returns the ANSI sequence to set reverse mode
            pub fn reverse(writer: anytype) !void {
                return std.fmt.format(writer, help.reverse, .{});
            }

            /// Returns the ANSI sequence to unset reverse mode
            pub fn noReverse(writer: anytype) !void {
                return std.fmt.format(writer, help.no_reverse, .{});
            }

            /// Returns the ANSI sequence to set hidden/invisible mode
            pub fn hidden(writer: anytype) !void {
                return std.fmt.format(writer, help.invisible, .{});
            }

            /// Returns the ANSI sequence to unset hidden/invisible mode
            pub fn noHidden(writer: anytype) !void {
                return std.fmt.format(writer, help.no_invisible, .{});
            }

            /// Returns the ansi sequence to set strikethrough mode
            pub fn strikethrough(writer: anytype) !void {
                return std.fmt.format(writer, help.strikethrough, .{});
            }

            /// Returns the ansi sequence to unset strikethrough mode
            pub fn noStrikethrough(writer: anytype) !void {
                return std.fmt.format(writer, help.no_strikethrough, .{});
            }
        };

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝