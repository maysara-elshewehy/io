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
            try EQL(0,  res.len());
        }

        test "Empty mutable" {
            // size = 0
            var res = string.init();
            try EQL(0, res.size());
            try EQL(0,  res.len());
            res.deinit();
        }

        test "Non-Empty" {
            // size = 5*2
            var res = string.init();

            // Append a string.
            try res.append("Hello");
            try EQL(10, res.size());
            try EQL(5,  res.len());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.append(' ');
            try EQL(10, res.size());
            try EQL(6,  res.len());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 30 => 10(current size) + 5(length of "World") = 15*2
            try res.append("World");
            try EQL(30, res.size());
            try EQL(11, res.len());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.prepend("--");
            try EQL(30, res.size());
            try EQL(13, res.len());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.prepend('!');
            try EQL(30, res.size());
            try EQL(14, res.len());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.insert("^^", 1);
            try EQL(30, res.size());
            try EQL(16, res.len());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.insert(' ', 1);
            try EQL(30, res.size());
            try EQL(17, res.len());
            try EQLS("! ^^--Hello World", res.src());

            res.deinit();

        }

        test "Non-Empty mutable(fmt)" {
            // size = 5*2
            var res = string.init();

            // Append a string.
            try res.appendf("{s}", .{"Hello"});
            try EQL(10, res.size());
            try EQL(5,  res.len());
            try EQLS("Hello", res.src());

            // Append a character.
            try res.appendf("{c}", .{' '});
            try EQL(10, res.size());
            try EQL(6,  res.len());
            try EQLS("Hello ", res.src());

            // Append a string.
            // size 30 => 10(current size) + 5(length of "World") = 15*2
            try res.appendf("{s}", .{"World"});
            try EQL(30, res.size());
            try EQL(11, res.len());
            try EQLS("Hello World", res.src());

            // Prepend a string.
            try res.prependf("{s}", .{"--"});
            try EQL(30, res.size());
            try EQL(13, res.len());
            try EQLS("--Hello World", res.src());

            // Prepend a character.
            try res.prependf("{c}", .{'!'});
            try EQL(30, res.size());
            try EQL(14, res.len());
            try EQLS("!--Hello World", res.src());

            // Insert a string.
            try res.insertf("{s}", .{"^^"}, 1);

            try EQL(30, res.size());
            try EQL(16, res.len());
            try EQLS("!^^--Hello World", res.src());

            // Insert a character.
            try res.insertf("{c}", .{' '}, 1);
            try EQL(30, res.size());
            try EQL(17, res.len());
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

// ╚══════════════════════════════════════════════════════════════════════════════════╝