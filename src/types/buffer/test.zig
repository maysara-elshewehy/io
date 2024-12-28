// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const buffer = @import("./src.zig").buffer;
    const chars = @import("../../utils/chars/src.zig");

    const EQ = std.testing.expect;
    const EQL = std.testing.expectEqual;
    const EQLS = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────────── BASICS ───────────────────────────┐

        test "Empty constant" {
            const _buf = chars.make(64, null); const res = buffer(&_buf);
            try EQL(64, res.size());
            try EQL(0,  res.bytes());
        }

        test "Empty mutable" {
            const _buf = chars.make(64, null); const str = buffer(&_buf);
            try EQL(64, str.size());
            try EQL(0,  str.bytes());
        }

        test "Non-Empty" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            // Append a string.
            try str.append("Hello");
            try EQL(5,  str.bytes());
            try EQLS("Hello", str.m_buff[0..str.m_bytes]);

            // Append a character.
            try str.append(' ');
            try EQL(6,  str.bytes());
            try EQLS("Hello ", str.m_buff[0..str.m_bytes]);

            // Append a string.
            try str.append("World");
            try EQL(11, str.bytes());
            try EQLS("Hello World", str.m_buff[0..str.m_bytes]);

            // Prepend a string.
            try str.prepend("--");
            try EQL(13, str.bytes());
            try EQLS("--Hello World", str.m_buff[0..str.m_bytes]);

            // Prepend a character.
            try str.prepend('!');
            try EQL(14, str.bytes());
            try EQLS("!--Hello World", str.m_buff[0..str.m_bytes]);

            // Insert a string.
            try str.insert("^^", 1);
            try EQL(16, str.bytes());
            try EQLS("!^^--Hello World", str.m_buff[0..str.m_bytes]);

            // Insert a character.
            try str.insert(' ', 1);
            try EQL(17, str.bytes());
            try EQLS("! ^^--Hello World", str.m_buff[0..str.m_bytes]);
        }

        test "Non-Empty mutable (fmt)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            // Append a string.
            try str.write("{s}", .{"Hello"});
            try EQL(5,  str.bytes());
            try EQLS("Hello", str.m_buff[0..str.m_bytes]);

            // Append a character.
            try str.write("{c}", .{' '});
            try EQL(6,  str.bytes());
            try EQLS("Hello ", str.m_buff[0..str.m_bytes]);

            // Append a string.
            try str.write("{s}", .{"World"});
            try EQL(11, str.bytes());
            try EQLS("Hello World", str.m_buff[0..str.m_bytes]);

            // Prepend a string.
            try str.writeStart("{s}", .{"--"});
            try EQL(13, str.bytes());
            try EQLS("--Hello World", str.m_buff[0..str.m_bytes]);

            // Prepend a character.
            try str.writeStart("{c}", .{'!'});
            try EQL(14, str.bytes());
            try EQLS("!--Hello World", str.m_buff[0..str.m_bytes]);

            // Insert a string.
            try str.writeAt("{s}", .{"^^"}, 1);

            try EQL(16, str.bytes());
            try EQLS("!^^--Hello World", str.m_buff[0..str.m_bytes]);

            // Insert a character.
            try str.writeAt("{c}", .{' '}, 1);
            try EQL(17, str.bytes());
            try EQLS("! ^^--Hello World", str.m_buff[0..str.m_bytes]);

            // Iterator
            var i: chars.types.unsigned = 0;
            var iter = str.iterator();
            while (iter.next()) |ch| {
                if (i == 0) {
                    try EQLS("!", ch);
                }
                i += 1;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── INSERT ───────────────────────────┐

        test "Append a string" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello");
            try str.append(" ");
            try str.append("🌍");
            try str.append("!");
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);

            try str.append("🌟");
            try str.append("🌍");
            try str.append("!");
            try EQLS("Hello 🌍!🌟🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "Append a string (using insertReal function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insertReal("Hello", 0);
            try str.insertReal(" ", 5);
            try str.insertReal("🌍", 6);
            try str.insertReal("!", 10);
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);

            try str.insertReal("🌟", 11);
            try str.insertReal("🌍", 15);
            try str.insertReal("!", 19);
            try EQLS("Hello 🌍!🌟🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "Append a string (using insert function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert("Hello", 0);
            try str.insert(" ", 5);
            try str.insert("🌍", 6);
            try str.insert("!", 7);
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);

            try str.insert("🌟", 8);
            try EQLS("Hello 🌍!🌟", str.m_buff[0..str.m_bytes]);

            try str.insert("🌍", 9);
            try EQLS("Hello 🌍!🌟🌍", str.m_buff[0..str.m_bytes]);

            try str.insert("!", 10);
            try EQLS("Hello 🌍!🌟🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "Append a character" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append('H');
            try str.append(' ');
            try str.append('W');
            try str.append('!');
            try EQLS("H W!", str.m_buff[0..str.m_bytes]);
        }

        test "Append a character (using insert function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert('H', 0);
            try str.insert(' ', 1);
            try str.insert('W', 2);
            try str.insert('!', 3);
            try EQLS("H W!", str.m_buff[0..str.m_bytes]);
        }

        test "Prepend a string" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.prepend("Hello");
            try str.prepend(" ");
            try str.prepend("🌍");
            try str.prepend("!");
            try EQLS("!🌍 Hello", str.m_buff[0..str.m_bytes]);

            try str.prepend("🌟");
            try str.prepend("🌍");
            try str.prepend("!");
            try EQLS("!🌍🌟!🌍 Hello", str.m_buff[0..str.m_bytes]);
        }

        test "Prepend a string (using insert function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert("Hello", 0);
            try str.insert(" ", 0);
            try str.insert("🌍", 0);
            try str.insert("!", 0);
            try EQLS("!🌍 Hello", str.m_buff[0..str.m_bytes]);

            try str.insert("🌟", 0);
            try str.insert("🌍", 0);
            try str.insert("!", 0);
            try EQLS("!🌍🌟!🌍 Hello",str.m_buff[0..str.m_bytes]);
        }

        test "Prepend a character" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.prepend('H');
            try str.prepend(' ');
            try str.prepend('W');
            try str.prepend('!');
            try EQLS("!W H", str.m_buff[0..str.m_bytes]);
        }

        test "Prepend a character (using insert function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert('H', 0);
            try str.insert(' ', 0);
            try str.insert('W', 0);
            try str.insert('!', 0);
            try EQLS("!W H", str.m_buff[0..str.m_bytes]);
        }

        test "Insert a character into a specifiec position" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert('!', 0);
            try str.insert('H', 0);
            try str.insert(' ', 1);
            try str.insert('W', 2);
            try EQLS("H W!", str.m_buff[0..str.m_bytes]);
        }

        test "Insert a string into a specifiec position" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert("!", 0);
            try str.insert("🌍", 0);
            try str.insert("Hello", 0);
            try str.insert(" ", 5);

            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "Insert a character into a specifiec position (using insertReal function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insertReal('!', 0);
            try str.insertReal('H', 0);
            try str.insertReal(' ', 1);
            try str.insertReal('W', 2);
            try EQLS("H W!", str.m_buff[0..str.m_bytes]);
        }

        test "Insert a string into a specifiec position (using insertReal function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insertReal("!", 0);
            try str.insertReal("🌍", 0);
            try str.insertReal("Hello", 0);
            try str.insertReal(" ", 5);

            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REMOVE ───────────────────────────┐

        test "Remove a rang of string (single character)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello");
            try EQLS("Hello", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 1});
            try EQLS("ello", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 2});
            try EQLS("lo", str.m_buff[0..str.m_bytes]);

            try str.remove(.{1, 2});
            try EQLS("l", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 1});
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a range of string (multiple characters)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello World");
            try EQLS("Hello World", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 6});
            try EQLS("World", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 5});
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a single character" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello");
            try EQLS("Hello", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("ello", str.m_buff[0..str.m_bytes]);

            try str.remove(2);
            try EQLS("elo", str.m_buff[0..str.m_bytes]);

            try str.remove(2);
            try EQLS("el", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("l", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a unicode character (fake position)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(4);
            try EQLS("🌍🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS(",🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(2);
            try EQLS(",🌍!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);

            try str.remove(2);
            try EQLS("🌍", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a unicode character (fake range)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(.{0, 1});
            try EQLS("🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(.{4, 5});
            try EQLS("🌍🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS(",🌍🌟!", str.m_buff[0..str.m_bytes]);

            try str.remove(2);
            try EQLS(",🌍!", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);

            try str.remove(1);
            try EQLS("🌍", str.m_buff[0..str.m_bytes]);

            try str.remove(0);
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a unicode character (real position)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS("🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(10);
            try EQLS("🌍🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS("🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS("!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS(",🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(5);
            try EQLS(",🌍!", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);

            str.removeReal(4);
            try EQLS("🌍", str.m_buff[0..str.m_bytes]);

            str.removeReal(0);
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove a unicode character (real range)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 1});
            try EQLS("🌍🌟!,=🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{10, 11});
            try EQLS("🌍🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 4});
            try EQLS("🌟!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 4});
            try EQLS("!,🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 1});
            try EQLS(",🌍🌟!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{5, 9});
            try EQLS(",🌍!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 1});
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{4, 5});
            try EQLS("🌍", str.m_buff[0..str.m_bytes]);

            str.removeReal(.{0, 4});
            try EQLS("", str.m_buff[0..str.m_bytes]);
        }

        test "Remove N characters from the end of the string (using pop function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello World!");
            try EQLS("Hello World!", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(12, str.bytes());

            str.pop(1);
            try EQLS("Hello World", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(11, str.bytes());

            str.pop(6);
            try EQLS("Hello", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(5, str.bytes());

            str.pop(5);
            try EQLS("", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(0, str.bytes());
        }

        test "Remove N characters from the beginning of the string (using shift function)" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append("Hello World!");
            try EQLS("Hello World!", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(12, str.bytes());

            str.shift(1);
            try EQLS("ello World!", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(11, str.bytes());

            str.shift(5);
            try EQLS("World!", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(6, str.bytes());

            str.shift(6);
            try EQLS("", str.m_buff[0..str.m_bytes]);
            try EQL(64, str.size());
            try EQL(0, str.bytes());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── TRIM ────────────────────────────┐

        test "Trim start of string" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);
            str.trimStart(' ');

            try str.append("   !🌍🌟=   ");
            str.trimStart(' ');
            try EQLS("!🌍🌟=   ", str.m_buff[0..str.m_bytes]);
        }

        test "Trim end of string" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);
            str.trimEnd(' ');

            try str.append("   !🌍🌟=   ");
            str.trimEnd(' ');
            try EQLS("   !🌍🌟=", str.m_buff[0..str.m_bytes]);
        }

        test "Trim start and end of string" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);
            str.trimEnd(' ');

            try str.append("   !🌍🌟=   ");
            str.trim(' ');
            try EQLS("!🌍🌟=", str.m_buff[0..str.m_bytes]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── WRITER ───────────────────────────┐

        test "Make a writer for a string and write some string using print function (fmt)" {
            var buf = chars.make(64, null); var str = buffer(&buf);

            try EQL(0, str.bytes());
            const writer = str.writer();
            try writer.print("Hello {s}!", .{"🌍"});
            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── ITERATOR ──────────────────────────┐

        test "Iterate over a string" {
            var buf = chars.make(64, "Hello 🌍"); var str = buffer(&buf);

            var i: chars.types.unsigned = 0;
            var iter = str.iterator();
            while (iter.next()) |c| {
                if (5 == 0) try EQLS("🌍", c);
                i += 1;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── DOCS ────────────────────────────┐

        test "readme example" {
            var buf = chars.make(64, "Hello 🌍!"); // Creates a fixed array of characters.
            var str = buffer(&buf);                // Creates a new buffer structure.

            try EQL(8, str.ubytes());               // 👉 8     (Unicode characters are counted as regular characters).
            try EQL(11, str.bytes());               // 👉 11    Regular characters = 1, Unicode characters = 4.
            try EQL(64, str.size());                // 👉 64    Total size of the array.
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);   // 👉 "Hello 🌍!"
        }

        test "docs: bytes" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try EQL(0, str.bytes());    // 👉 0
            try str.append("Hello 🌍!");
            try EQL(11, str.bytes());   // 👉 11
        }

        test "docs: ubytes" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try EQL(0, str.ubytes());   // 👉 0
            try str.append("Hello 🌍!");
            try EQL(8, str.ubytes());   // 👉 8
        }

        test "docs: src" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try EQLS("", str.m_buff[0..str.m_bytes]);            // 👉 ""
            try str.append("Hello 🌍!");
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);   // 👉 "Hello 🌍!"
        }

        test "docs: append" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.append('=');    // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);

            try str.append("🌍");   // 👉 "=🌍"
            try EQLS("=🌍", str.m_buff[0..str.m_bytes]);

            try str.append("🌟");   // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", str.m_buff[0..str.m_bytes]);
        }

        test "docs: prepend" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.prepend('=');
            try EQLS("=", str.m_buff[0..str.m_bytes]);   // 👉 "="

            try str.prepend("🌍");      // 👉 "🌍="
            try EQLS("🌍=", str.m_buff[0..str.m_bytes]);

            try str.prepend("🌟");      // 👉 "🌟🌍="
            try EQLS("🌟🌍=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: insert" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insert('=', 0);      // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);

            try str.insert("🌍", 1);    // 👉 "=🌍"
            try EQLS("=🌍", str.m_buff[0..str.m_bytes]);

            try str.insert("🌟", 1);    // 👉 "=🌟🌍"
            try EQLS("=🌟🌍", str.m_buff[0..str.m_bytes]);
        }

        test "docs: insertReal" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.insertReal('=', 0);      // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);

            try str.insertReal("🌍", 1);    // 👉 "=🌍"
            try EQLS("=🌍", str.m_buff[0..str.m_bytes]);

            try str.insertReal("🌟", 1);    // 👉 "=🌟🌍"
            try EQLS("=🌟🌍", str.m_buff[0..str.m_bytes]);
        }

        test "docs: write" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.write( "{c}", .{ '=' } );     // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);
            try str.write( "{s}", .{ "🌍" } );    // 👉 "=🌍"
            try EQLS("=🌍", str.m_buff[0..str.m_bytes]);
            try str.write( "{s}", .{ "🌟" } );    // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", str.m_buff[0..str.m_bytes]);
            try str.write( "{d}", .{ 99 } );      // 👉 "=🌍🌟99"
            try EQLS("=🌍🌟99", str.m_buff[0..str.m_bytes]);
        }

        test "docs: writeStart" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.writeStart( "{c}", .{ '=' } );     // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);
            try str.writeStart( "{s}", .{ "🌍" } );    // 👉 "🌍="
            try EQLS("🌍=", str.m_buff[0..str.m_bytes]);
            try str.writeStart( "{s}", .{ "🌟" } );    // 👉 "🌟🌍="
            try EQLS("🌟🌍=", str.m_buff[0..str.m_bytes]);
            try str.writeStart( "{d}", .{ 99 } );      // 👉 "99🌟🌍="
            try EQLS("99🌟🌍=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: writeAt" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.writeAt( "{c}", .{ '='  }, 0 );     // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);
            try str.writeAt( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
            try EQLS("🌍=", str.m_buff[0..str.m_bytes]);
            try str.writeAt( "{s}", .{ "🌟" }, 1 );     // 👉 "🌍🌟="
            try EQLS("🌍🌟=", str.m_buff[0..str.m_bytes]);
            try str.writeAt( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
            try EQLS("99🌍🌟=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: writeAtReal" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            try str.writeAtReal( "{c}", .{ '='  }, 0 );     // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);
            try str.writeAtReal( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
            try EQLS("🌍=", str.m_buff[0..str.m_bytes]);
            try str.writeAtReal( "{s}", .{ "🌟" }, 4 );     // 👉 "🌍🌟="
            try EQLS("🌍🌟=", str.m_buff[0..str.m_bytes]);
            try str.writeAtReal( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
            try EQLS("99🌍🌟=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: remove" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");

            try str.remove(0);              // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", str.m_buff[0..str.m_bytes]);
            try str.remove(.{ 1, 2 });      // 👉 "🌍!"
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);
            try str.remove(.{ 0, 1 });      // 👉 "!"
            try EQLS("!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: removeReal" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");

            str.removeReal(0);          // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", str.m_buff[0..str.m_bytes]);
            str.removeReal(.{ 4, 8 });  // 👉 "🌍!"
            try EQLS("🌍!", str.m_buff[0..str.m_bytes]);
            str.removeReal(.{ 0, 4 });  // 👉 "!"
            try EQLS("!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: pop" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");

            str.pop(1); // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", str.m_buff[0..str.m_bytes]);

            str.pop(1); // 👉 "=🌍"
            try EQLS("=🌍", str.m_buff[0..str.m_bytes]);

            str.pop(1); // 👉 "="
            try EQLS("=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: shift" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");

            str.shift(1); // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", str.m_buff[0..str.m_bytes]);
            str.shift(1);  // 👉 "🌟!"
            try EQLS("🌟!"  , str.m_buff[0..str.m_bytes]);
            str.shift(1);  // 👉 "!"
            try EQLS("!"    , str.m_buff[0..str.m_bytes]);
        }

        test "docs: trimStart" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("  =🌍🌟!");
            str.trimStart(' '); // 👉 "=🌍🌟!"
            try EQLS("=🌍🌟!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: trimEnd" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!  ");
            str.trimEnd(' '); // 👉 "=🌍🌟!"
            try EQLS("=🌍🌟!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: trim" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("  =🌍🌟!  ");
            str.trim(' '); // 👉 "=🌍🌟!"
            try EQLS("=🌍🌟!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: find" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("==🌍🌟!!");
            try EQL(0, str.find('='));    // 👉 0   ("=")
            try EQL(2, str.find("🌍"));   // 👉 2   (beg of "🌍")
            try EQL(6, str.find("🌟"));   // 👉 6   (beg of "🌟")
            try EQL(10, str.find("!!"));  // 👉 10  ("!!")
        }

        test "docs: rfind" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("==🌍🌟!!");
            try EQL(1, str.rfind('='));    // 👉 1   ("=")
            try EQL(2, str.rfind("🌍"));   // 👉 2   (beg of "🌍")
            try EQL(6, str.rfind("🌟"));   // 👉 6   (beg of "🌟")
            try EQL(10, str.rfind("!!"));  // 👉 10  ("!!")
        }

        test "docs: toLower" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("HELLO 🌍!");
            str.toLower();    // 👉 "hello 🌍!"
            try EQLS("hello 🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: toUpper" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("hello 🌍!");
            str.toUpper();    // 👉 "HELLO 🌍!"
            try EQLS("HELLO 🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: toTitle" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("hello 🌍!");
            str.toTitle();    // 👉 "Hello 🌍!"
            try EQLS("Hello 🌍!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: eql" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");
            try EQL(false, str.eql(""));
            try EQL(false, str.eql("====="));
            try EQL(true, str.eql("=🌍🌟!"));
        }

        test "docs: startsWith" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");
            try EQL(false, str.startsWith(""));
            try EQL(false, str.startsWith("🌍"));
            try EQL(true, str.startsWith('='));
        }

        test "docs: endsWith" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);  try str.append("=🌍🌟!");
            try EQL(false, str.endsWith(""));
            try EQL(false, str.endsWith("🌍"));
            try EQL(true, str.endsWith('!'));
        }

        test "docs: startsWith Empty" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);
            try EQL(false, str.startsWith('='));
            try EQL(false, str.startsWith("🌍"));
            try EQL(true, str.startsWith(""));
        }

        test "docs: endsWith Empty" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);
            try EQL(false, str.endsWith('!'));
            try EQL(false, str.endsWith("🌍"));
            try EQL(true, str.endsWith(""));
        }


        test "docs: includes" {
            var _buf = chars.make(64, "=🌍🌟!"); var str = buffer(&_buf);
            try EQL(true, str.includes('='));
            try EQL(true, str.includes("🌍"));
            try EQL(true, str.includes("🌟"));
            try EQL(true, str.includes("!"));
            try EQL(false, str.includes('@'));
        }

        test "docs: replace" {
            var _buf = chars.make(64, "==🌍🌍🌟!!"); var str = buffer(&_buf);

            // replace character.
            try EQL(1, try str.replace('=', '@', 1));    // 👉 (res = 1), "@=🌍🌍🌟!!"
            try EQLS("@=🌍🌍🌟!!", str.m_buff[0..str.m_bytes]);

            // replace unicode.
            try EQL(8, try str.replace("🌍", '!', 2));   // 👉 (res = 1), "@=!!🌟!!"
            try EQLS("@=!!🌟!!", str.m_buff[0..str.m_bytes]);

            // replace string.
            try EQL(4, try str.replace("🌟", '!', 1));    // 👉 (res = 1), "@=!!!!!"
            try EQLS("@=!!!!!", str.m_buff[0..str.m_bytes]);
        }

        test "docs: rreplace" {
            var _buf = chars.make(64, "==🌍🌍🌟!!"); var str = buffer(&_buf);

            // replace character.
            try EQL(1, str.rreplace('=', '@', 1));    // 👉 (res = 1), "=@🌍🌍🌟!!"
            try EQLS("=@🌍🌍🌟!!", str.m_buff[0..str.m_bytes]);

            // replace unicode.
            try EQL(8, str.rreplace("🌍", '!', 2));   // 👉 (res = 1), "=@!!🌟!!"
            try EQLS("=@!!🌟!!", str.m_buff[0..str.m_bytes]);

            // replace string.
            try EQL(4, str.rreplace("🌟", '!', 1));    // 👉 (res = 1), "=@!!!!!"
            try EQLS("=@!!!!!", str.m_buff[0..str.m_bytes]);
        }

         test "docs: repeat" {
            var _buf = chars.make(64, null); var str = buffer(&_buf);

            // repeat character.
            try str.repeat('0', 1); // 👉 "0"
            try EQL(1, str.bytes());
            try EQL(64, str.size());
            try EQLS("0", str.m_buff[0..str.m_bytes]);

            try str.repeat('0', 2); // 👉 "000"
            try EQLS("000", str.m_buff[0..str.m_bytes]);

            // repeat string.
            try str.repeat("@#", 2); // 👉 "000@#@#"
            try EQLS("000@#@#", str.m_buff[0..str.m_bytes]);

            // repeat unicode.
            try str.repeat("🌍", 2); // 👉 "000@#@#🌍🌍"
            try EQLS("000@#@#🌍🌍", str.m_buff[0..str.m_bytes]);
        }

        test "docs: reverse" {
            var _buf = chars.make(64, "=🌍🌟!"); var str = buffer(&_buf);

            str.reverse(); // 👉 "!🌟🌍="
            try EQLS("!🌟🌍=", str.m_buff[0..str.m_bytes]);
        }

        test "docs: split" {
            var _buf = chars.make(64, "🌍1🌍🌍2🌍🌍3🌍"); var str = buffer(&_buf);

            try EQLS(str.split("🌍", 0).?,  ""); // 👉 ""
            try EQLS(str.split("🌍", 1).?, "1"); // 👉 "1"
            try EQLS(str.split("🌍", 2).?,  ""); // 👉 ""
            try EQLS(str.split("🌍", 3).?, "2"); // 👉 "2"
            try EQLS(str.split("🌍", 5).?, "3"); // 👉 "3"
            try EQLS(str.split("🌍", 6).?,  ""); // 👉 ""
        }

        test "docs: split using character" {
            var _buf = chars.make(64, ",1,,2,,3,"); var str = buffer(&_buf);

            try EQLS(str.split(',', 0).?,  ""); // 👉 ""
            try EQLS(str.split(',', 1).?, "1"); // 👉 "1"
            try EQLS(str.split(',', 2).?,  ""); // 👉 ""
            try EQLS(str.split(',', 3).?, "2"); // 👉 "2"
            try EQLS(str.split(',', 5).?, "3"); // 👉 "3"
            try EQLS(str.split(',', 6).?,  ""); // 👉 ""
        }

        test "docs: splitAll using character" {
            var _buf = chars.make(64, ",1,,2,,3,"); var str = buffer(&_buf);

            const res = try str.splitAll(',');

            try EQL(7, res.len);
            try EQLS("", res[0]);
            try EQLS("1", res[1]);
            try EQLS("", res[2]);
            try EQLS("2", res[3]);
            try EQLS("", res[4]);
            try EQLS("3", res[5]);
            try EQLS("", res[6]);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝