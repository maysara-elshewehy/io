// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const string = @import("./src.zig").string;

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
            try EQL(10, res.size());
            try EQL(5,  res.bytes());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.append(' ');
            try EQL(10, res.size());
            try EQL(6,  res.bytes());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 30 => 10(current size) + 5(length of "World") = 15*2
            try res.append("World");
            try EQL(30, res.size());
            try EQL(11, res.bytes());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.prepend("--");
            try EQL(30, res.size());
            try EQL(13, res.bytes());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.prepend('!');
            try EQL(30, res.size());
            try EQL(14, res.bytes());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.insert("^^", 1);
            try EQL(30, res.size());
            try EQL(16, res.bytes());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.insert(' ', 1);
            try EQL(30, res.size());
            try EQL(17, res.bytes());
            try EQLS("! ^^--Hello World", res.src());

            res.deinit();

        }

        test "Non-Empty mutable(fmt)" {
            // size = 5*2
            var res = string.init();

            // Append a string.
            try res.appendf("{s}", .{"Hello"});
            try EQL(10, res.size());
            try EQL(5,  res.bytes());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.appendf("{c}", .{' '});
            try EQL(10, res.size());
            try EQL(6,  res.bytes());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 30 => 10(current size) + 5(length of "World") = 15*2
            try res.appendf("{s}", .{"World"});
            try EQL(30, res.size());
            try EQL(11, res.bytes());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.prependf("{s}", .{"--"});
            try EQL(30, res.size());
            try EQL(13, res.bytes());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.prependf("{c}", .{'!'});
            try EQL(30, res.size());
            try EQL(14, res.bytes());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.insertf("{s}", .{"^^"}, 1);

            try EQL(30, res.size());
            try EQL(16, res.bytes());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.insertf("{c}", .{' '}, 1);
            try EQL(30, res.size());
            try EQL(17, res.bytes());
            try EQLS("! ^^--Hello World", res.src());

            // Iterator
            var i: usize = 0;
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

            try EQL(22, str.size());            // 👉 22
            try EQL(11, str.bytes());           // 👉 11
            try EQL(8, str.ubytes());           // 👉 8
            try EQLS("Hello 🌍!", str.src());   // 👉 "Hello 🌍!"
        }

        test "Init string using character" {
            var str = try string.initWith('!');
            defer str.deinit();

            try EQL(2, str.size());     // 👉 2
            try EQL(1, str.bytes());    // 👉 1
            try EQL(1, str.ubytes());   // 👉 1
            try EQLS("!", str.src());   // 👉 "!"
        }

        test "Init string using another string" {
            var str1 = try string.initWith("Hello 🌍!");
            defer str1.deinit();

            var str2 = try string.initWith(str1);
            defer str2.deinit();

            try EQL(str1.size(), str2.size());      // 👉 22
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


// ╚══════════════════════════════════════════════════════════════════════════════════╝