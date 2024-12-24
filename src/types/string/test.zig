// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const string = @import("./src.zig").string;
    const chars = @import("../../utils/chars/src.zig");

    const EQ = std.testing.expect;
    const EQL = std.testing.expectEqual;
    const EQLS = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────────── BASICS ───────────────────────────┐

        test "Empty constant" {
            // size = 0
            const res = string.init();
            try EQL(0, res.size());
            try EQL(0,  res.bytes());
        }

        test "Empty mutable" {
            // size = 0
            var res = string.init();
            try EQL(0, res.size());
            try EQL(0,  res.bytes());
            res.deinit();
        }

        test "Non-Empty" {
            // size = 5*2
            var res = string.init();

            // Append a string.
            try res.append("Hello");
            try EQL(12, res.size());
            try EQL(5,  res.bytes());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.append(' ');
            try EQL(12, res.size());
            try EQL(6,  res.bytes());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 30 => 10(current size) + 5(length of "World") = 15*2
            try res.append("World");
            try EQL(24, res.size());
            try EQL(11, res.bytes());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.prepend("--");
            try EQL(24, res.size());
            try EQL(13, res.bytes());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.prepend('!');
            try EQL(24, res.size());
            try EQL(14, res.bytes());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.insert("^^", 1);
            try EQL(24, res.size());
            try EQL(16, res.bytes());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.insert(' ', 1);
            try EQL(24, res.size());
            try EQL(17, res.bytes());
            try EQLS("! ^^--Hello World", res.src());

            res.deinit();

        }

        test "Non-Empty mutable (fmt)" {
            // size = 5*2
            var res = string.init();

            // Append a string.
            try res.write("{s}", .{"Hello"});
            try EQL(12, res.size());
            try EQL(5,  res.bytes());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.write("{c}", .{' '});
            try EQL(12, res.size());
            try EQL(6,  res.bytes());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 24 => 11*2
            try res.write("{s}", .{"World"});
            try EQL(24, res.size());
            try EQL(11, res.bytes());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.writeStart("{s}", .{"--"});
            try EQL(24, res.size());
            try EQL(13, res.bytes());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.writeStart("{c}", .{'!'});
            try EQL(24, res.size());
            try EQL(14, res.bytes());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.writeAt("{s}", .{"^^"}, 1);

            try EQL(24, res.size());
            try EQL(16, res.bytes());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.writeAt("{c}", .{' '}, 1);
            try EQL(24, res.size());
            try EQL(17, res.bytes());
            try EQLS("! ^^--Hello World", res.src());

            // Iterator
            var i: chars.types.unsigned = 0;
            var iter = res.iterator();
            while (iter.next()) |ch| {
                if (i == 0) {
                    try EQLS("!", ch);
                }
                i += 1;
            }

            res.deinit();
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── INIT ────────────────────────────┐

        test "Init empty string" {
            var str = string.init();    // Creates a new string structure.
            defer str.deinit();         // Cleans up the allocated memory (if allocated) when the scope ends.

            try EQL(0, str.size());     // 👉 0
            try EQL(0, str.bytes());    // 👉 0
            try EQL(0, str.ubytes());   // 👉 0
            try EQLS("", str.src());    // 👉 ""
        }

        test "Init string using array of characters" {
            var str = try string.initWith("Hello 🌍!");
            defer str.deinit();

            try EQL(24, str.size());            // 👉 24
            try EQL(11, str.bytes());           // 👉 11
            try EQL(8, str.ubytes());           // 👉 8
            try EQLS("Hello 🌍!", str.src());   // 👉 "Hello 🌍!"
        }

        test "Init string using character" {
            var str = try string.initWith('!');
            defer str.deinit();

            try EQL(4, str.size());     // 👉 2
            try EQL(1, str.bytes());    // 👉 1
            try EQL(1, str.ubytes());   // 👉 1
            try EQLS("!", str.src());   // 👉 "!"
        }

        test "Init string using another string" {
            var str1 = try string.initWith("Hello 🌍!");
            defer str1.deinit();

            var str2 = try string.initWith(str1);
            defer str2.deinit();

            try EQL(str1.size(), str2.size());      // 👉 24
            try EQL(str1.bytes(), str2.bytes());    // 👉 11
            try EQL(str1.ubytes(), str2.ubytes());  // 👉 8
            try EQLS(str1.src(), str2.src());       // 👉 "Hello 🌍!"
        }

        test "Allocate a new size" {
            var str = string.init();

            try EQL(0, str.size());   // 👉 0
            try str.allocate(10);
            try EQL(0,  str.bytes()); // 👉 0
            try EQL(10, str.size());  // 👉 10
            str.deinit();
            try EQL(0, str.size());   // 👉 0
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── INSERT ───────────────────────────┐

        test "Append a string" {
            var str = string.init(); defer str.deinit();

            try str.append("Hello");
            try str.append(" ");
            try str.append("🌍");
            try str.append("!");
            try EQLS("Hello 🌍!", str.src());

            try str.append("🌟");
            try str.append("🌍");
            try str.append("!");
            try EQLS("Hello 🌍!🌟🌍!", str.src());
        }

        test "Append a string (using insertReal function)" {
            var str = string.init(); defer str.deinit();

            try str.insertReal("Hello", 0);
            try str.insertReal(" ", 5);
            try str.insertReal("🌍", 6);
            try str.insertReal("!", 10);
            try EQLS("Hello 🌍!", str.src());

            try str.insertReal("🌟", 11);
            try str.insertReal("🌍", 15);
            try str.insertReal("!", 19);
            try EQLS("Hello 🌍!🌟🌍!", str.src());
        }

        test "Append a string (using insert function)" {
            var str = string.init(); defer str.deinit();

            try str.insert("Hello", 0);
            try str.insert(" ", 5);
            try str.insert("🌍", 6);
            try str.insert("!", 7);
            try EQLS("Hello 🌍!", str.src());

            try str.insert("🌟", 8);
            try str.insert("🌍", 9);
            try str.insert("!", 10);
            try EQLS("Hello 🌍!🌟🌍!", str.src());
        }

        test "Append a character" {
            var str = string.init(); defer str.deinit();

            try str.append('H');
            try str.append(' ');
            try str.append('W');
            try str.append('!');
            try EQLS("H W!", str.src());
        }

        test "Append a character (using insert function)" {
            var str = string.init(); defer str.deinit();

            try str.insert('H', 0);
            try str.insert(' ', 1);
            try str.insert('W', 2);
            try str.insert('!', 3);
            try EQLS("H W!", str.src());
        }

        test "Prepend a string" {
            var str = string.init(); defer str.deinit();

            try str.prepend("Hello");
            try str.prepend(" ");
            try str.prepend("🌍");
            try str.prepend("!");
            try EQLS("!🌍 Hello", str.src());

            try str.prepend("🌟");
            try str.prepend("🌍");
            try str.prepend("!");
            try EQLS("!🌍🌟!🌍 Hello", str.src());
        }

        test "Prepend a string (using insert function)" {
            var str = string.init(); defer str.deinit();

            try str.insert("Hello", 0);
            try str.insert(" ", 0);
            try str.insert("🌍", 0);
            try str.insert("!", 0);
            try EQLS("!🌍 Hello", str.src());

            try str.insert("🌟", 0);
            try str.insert("🌍", 0);
            try str.insert("!", 0);
            try EQLS("!🌍🌟!🌍 Hello",str.src());
        }

        test "Prepend a character" {
            var str = string.init(); defer str.deinit();

            try str.prepend('H');
            try str.prepend(' ');
            try str.prepend('W');
            try str.prepend('!');
            try EQLS("!W H", str.src());
        }

        test "Prepend a character (using insert function)" {
            var str = string.init(); defer str.deinit();

            try str.insert('H', 0);
            try str.insert(' ', 0);
            try str.insert('W', 0);
            try str.insert('!', 0);
            try EQLS("!W H", str.src());
        }

        test "Insert a character into a specifiec position" {
            var str = string.init(); defer str.deinit();

            try str.insert('!', 0);
            try str.insert('H', 0);
            try str.insert(' ', 1);
            try str.insert('W', 2);
            try EQLS("H W!", str.src());
        }

        test "Insert a string into a specifiec position" {
            var str = string.init(); defer str.deinit();

            try str.insert("!", 0);
            try str.insert("🌍", 0);
            try str.insert("Hello", 0);
            try str.insert(" ", 5);

            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.src());
        }

        test "Insert a character into a specifiec position (using insertReal function)" {
            var str = string.init(); defer str.deinit();

            try str.insertReal('!', 0);
            try str.insertReal('H', 0);
            try str.insertReal(' ', 1);
            try str.insertReal('W', 2);
            try EQLS("H W!", str.src());
        }

        test "Insert a string into a specifiec position (using insertReal function)" {
            var str = string.init(); defer str.deinit();

            try str.insertReal("!", 0);
            try str.insertReal("🌍", 0);
            try str.insertReal("Hello", 0);
            try str.insertReal(" ", 5);

            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── WRITER ───────────────────────────┐

        test "Make a writer for a string and write some string using print function (fmt)" {
            var str = string.init(); defer str.deinit();

            var writer = str.writer();
            try writer.print("Hello {s}!", .{"🌍"});
            try EQL(11, str.bytes());
            try EQLS("Hello 🌍!", str.src());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── ITERATOR ──────────────────────────┐

        test "Iterate over a string" {
            var str = try string.initWith("Hello 🌍"); defer str.deinit();
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
            var str = string.init();            // Creates a new string structure.
            defer str.deinit();                 // Cleans up the allocated memory (if allocated) when the scope ends.

            try str.append("Hello 🌍!");        // 👉 "Hello 🌍!"
            try EQL(8, str.ubytes());           // 👉 8     (Unicode characters are counted as regular characters).
            try EQL(11, str.bytes());           // 👉 11    Regular characters = 1, Unicode characters = 4.
            try EQL(24, str.size());            // 👉 24    Total size of the allocated memory.
            try EQLS("Hello 🌍!", str.src());   // 👉 "Hello 🌍!"
        }

        test "docs: allocate" {
            var str = string.init(); defer str.deinit();

            try EQL(0, str.size());     // 👉 0
            try str.allocate(10);
            try EQL(10, str.size());    // 👉 10
        }

        test "docs: init" {
            var str = string.init(); defer str.deinit();
            try EQL(0, str.size());     // 👉 0
            try EQL(0, str.bytes());    // 👉 0
            try EQLS("", str.src());    // 👉 ""
        }

        test "docs: initWith" {
            var str = try string.initWith("Hello 🌍!"); defer str.deinit();
            try EQL(24, str.size());     // 👉 24
            try EQL(11, str.bytes());    // 👉 11
            try EQL(8, str.ubytes());    // 👉 8
            try EQLS("Hello 🌍!", str.src());    // 👉 "Hello 🌍!"
        }

        test "docs: bytes" {
            var str = string.init(); defer str.deinit();

            try EQL(0, str.bytes());    // 👉 0
            try str.append("Hello 🌍!");
            try EQL(11, str.bytes());   // 👉 11
        }

        test "docs: ubytes" {
            var str = string.init(); defer str.deinit();

            try EQL(0, str.ubytes());   // 👉 0
            try str.append("Hello 🌍!");
            try EQL(8, str.ubytes());   // 👉 8
        }

        test "docs: src" {
            var str = string.init(); defer str.deinit();

            try EQLS("", str.src());            // 👉 ""
            try str.append("Hello 🌍!");
            try EQLS("Hello 🌍!", str.src());   // 👉 "Hello 🌍!"
        }

        test "docs: append" {
            var str = string.init(); defer str.deinit();

            try str.append('=');    // 👉 "="
            try EQLS("=", str.src());

            try str.append("🌍");   // 👉 "=🌍"
            try EQLS("=🌍", str.src());

            try str.append("🌟");   // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", str.src());

            var other = try string.initWith("!!");
            defer other.deinit();

            try str.append(other);  // 👉 "=🌍🌟!!"
            try EQLS("=🌍🌟!!", str.src());
        }

        test "docs: prepend" {
            var str = string.init(); defer str.deinit();

            try str.prepend('=');
            try EQLS("=", str.src());   // 👉 "="

            try str.prepend("🌍");      // 👉 "🌍="
            try EQLS("🌍=", str.src());

            try str.prepend("🌟");      // 👉 "🌟🌍="
            try EQLS("🌟🌍=", str.src());

            var other = try string.initWith("!!");
            defer other.deinit();

            try str.prepend(other);     // 👉 "!!🌟🌍="
            try EQLS("!!🌟🌍=", str.src());
        }

        test "docs: insert" {
            var str = string.init(); defer str.deinit();

            try str.insert('=', 0);      // 👉 "="
            try EQLS("=", str.src());

            try str.insert("🌍", 1);    // 👉 "=🌍"
            try EQLS("=🌍", str.src());

            try str.insert("🌟", 1);    // 👉 "=🌟🌍"
            try EQLS("=🌟🌍", str.src());

            var other = try string.initWith("!!");
            defer other.deinit();

            try str.insert(other, 3);   // 👉 "=🌟🌍!!"
            try EQLS("=🌟🌍!!", str.src());
        }

        test "docs: insertReal" {
            var str = string.init(); defer str.deinit();

            try str.insertReal('=', 0);      // 👉 "="
            try EQLS("=", str.src());

            try str.insertReal("🌍", 1);    // 👉 "=🌍"
            try EQLS("=🌍", str.src());

            try str.insertReal("🌟", 1);    // 👉 "=🌟🌍"
            try EQLS("=🌟🌍", str.src());

            var other = try string.initWith("!!");
            defer other.deinit();

            try str.insertReal(other, 9);   // 👉 "=🌟🌍!!"
            try EQLS("=🌟🌍!!", str.src());
        }

        test "docs: write" {
            var str = string.init(); defer str.deinit();

            try str.write( "{c}", .{ '=' } );     // 👉 "="
            try EQLS("=", str.src());
            try str.write( "{s}", .{ "🌍" } );    // 👉 "=🌍"
            try EQLS("=🌍", str.src());
            try str.write( "{s}", .{ "🌟" } );    // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", str.src());
            try str.write( "{d}", .{ 99 } );      // 👉 "=🌍🌟99"
            try EQLS("=🌍🌟99", str.src());
        }

        test "docs: writeStart" {
            var str = string.init(); defer str.deinit();

            try str.writeStart( "{c}", .{ '=' } );     // 👉 "="
            try EQLS("=", str.src());
            try str.writeStart( "{s}", .{ "🌍" } );    // 👉 "🌍="
            try EQLS("🌍=", str.src());
            try str.writeStart( "{s}", .{ "🌟" } );    // 👉 "🌟🌍="
            try EQLS("🌟🌍=", str.src());
            try str.writeStart( "{d}", .{ 99 } );      // 👉 "99🌟🌍="
            try EQLS("99🌟🌍=", str.src());
        }

        test "docs: writeAt" {
            var str = string.init(); defer str.deinit();

            try str.writeAt( "{c}", .{ '='  }, 0 );     // 👉 "="
            try EQLS("=", str.src());
            try str.writeAt( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
            try EQLS("🌍=", str.src());
            try str.writeAt( "{s}", .{ "🌟" }, 1 );     // 👉 "🌍🌟="
            try EQLS("🌍🌟=", str.src());
            try str.writeAt( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
            try EQLS("99🌍🌟=", str.src());
        }

        test "docs: writeAtReal" {
            var str = string.init(); defer str.deinit();

            try str.writeAtReal( "{c}", .{ '='  }, 0 );     // 👉 "="
            try EQLS("=", str.src());
            try str.writeAtReal( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
            try EQLS("🌍=", str.src());
            try str.writeAtReal( "{s}", .{ "🌟" }, 4 );     // 👉 "🌍🌟="
            try EQLS("🌍🌟=", str.src());
            try str.writeAtReal( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
            try EQLS("99🌍🌟=", str.src());
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝