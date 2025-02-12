// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std               = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Core ═══════════════════════════════════════╗

    // ┌──────────────────────────── Clear ───────────────────────────┐

        /// CSI escape sequence
        pub const csi = "\x1b[";

        /// Sequence to clear all screen
        pub const clear_all = "2J";

        /// Clear entire line
        pub const clear_line = "2K";

        /// Sequence to clear from cursor until end of screen
        pub const clear_screen_from_cursor = "0J";

        /// Sequence to clear from beginning to cursor.
        pub const clear_screen_to_cursor = "1J";

        /// Clear from cursor to end of line
        pub const clear_line_from_cursor = "0K";

        /// Clear start of line to the cursor
        pub const clear_line_to_cursor = "1K";

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Cursor ───────────────────────────┐



    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Colors ──────────────────────────┐

        /// 256 colors
        pub const Color = enum(u8) {
            black = 0,
            red, green, yellow, blue, magenta, cyan, white, default,
        };

        /// Sequence to set foreground color using 256 colors table
        pub const fg_256 = "38;5;";

        /// Sequence to set foreground color using 256 colors table
        pub const bg_256 = "48;5;";

        /// Sequence to set foreground color using 256 colors table
        pub const fg_rgb = "38;2;";

        /// Sequence to set foreground color using 256 colors table
        pub const bg_rgb = "48;2;";

        /// Sequence to reset color and style
        pub const reset_all = "0m";

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Attributes ────────────────────────┐

        /// Returns the ANSI sequence to set bold mode
        pub const attr_bold = "1m";
        pub const attr_no_bold = "22m";

        /// Returns the ANSI sequence to set dim mode
        pub const attr_dim = "2m";
        pub const attr_no_dim = "22m";

        /// Returnattr_s the ANSI sequence to set italic mode
        pub const attr_italic = "3m";
        pub const attr_no_italic = "23m";

        /// Returnattr_s the ANSI sequence to set underline mode
        pub const attr_underline = "4m";
        pub const attr_no_underline = "24m";

        /// Returnattr_s the ANSI sequence to set blinking mode
        pub const attr_blinking = "5m";
        pub const attr_no_blinking = "25m";

        /// Returnattr_s the ANSI sequence to set reverse mode
        pub const attr_reverse = "7m";
        pub const attr_no_reverse = "27m";

        /// Returnattr_s the ANSI sequence to set hidden/invisible mode
        pub const attr_invisible = "8m";
        pub const attr_no_invisible = "28m";

        /// Returnattr_s the ANSI sequence to set strikethrough mode
        pub const attr_strikethrough = "9m";
        pub const attr_no_strikethrough = "29m";


        /// Returns the ANSI sequence as a []const u8
        pub const reset = comptimeCsi(reset_all, .{});

        /// Returns the ANSI sequence to set bold mode
        pub const bold = comptimeCsi(attr_bold, .{});
        pub const no_bold = comptimeCsi(attr_no_bold, .{});

        /// Returns the ANSI sequence to set dim mode
        pub const dim = comptimeCsi(attr_dim, .{});
        pub const no_dim = comptimeCsi(attr_no_dim, .{});

        /// Returns the ANSI sequence to set italic mode
        pub const italic = comptimeCsi(attr_italic, .{});
        pub const no_italic = comptimeCsi(attr_no_italic, .{});

        /// Returns the ANSI sequence to set underline mode
        pub const underline = comptimeCsi(attr_underline, .{});
        pub const no_underline = comptimeCsi(attr_no_underline, .{});

        /// Returns the ANSI sequence to set blinking mode
        pub const blinking = comptimeCsi(attr_blinking, .{});
        pub const no_blinking = comptimeCsi(attr_no_blinking, .{});

        /// Returns the ANSI sequence to set reverse mode
        pub const reverse = comptimeCsi(attr_reverse, .{});
        pub const no_reverse = comptimeCsi(attr_no_reverse, .{});

        /// Returns the ANSI sequence to set hidden/invisible mode
        pub const invisible = comptimeCsi(attr_invisible, .{});
        pub const no_invisible = comptimeCsi(attr_no_invisible, .{});

        /// Returns the ANSI sequence to set strikethrough mode
        pub const strikethrough = comptimeCsi(attr_strikethrough, .{});
        pub const no_strikethrough = comptimeCsi(attr_no_strikethrough, .{});

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Internal ─────────────────────────┐

        /// Create a comptime string from a format string.
        pub inline fn comptimeCsi(comptime fmt: []const u8, args: anytype) []const u8 {
            const str = csi ++ fmt;
            return std.fmt.comptimePrint(str, args);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
