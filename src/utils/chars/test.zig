// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const chars = @import("./src.zig");

    const EQ = std.testing.expect;
    const EQL = std.testing.expectEqual;
    const EQLS = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── UTILS ────────────────────────────┐

        test "isCtype and isUtype" {
            const _str : []u8 = undefined;
            const _cstr : []const u8 = undefined;
            const _u8 : u8 = undefined;
            const _comptime_int : comptime_int = undefined;
            const _unsigned : chars.types.unsigned = undefined;

            // isCtype
            try EQL(true,  chars.utils.isCtype(_u8));
            try EQL(true,  chars.utils.isCtype(_comptime_int));
            try EQL(false, chars.utils.isCtype(_str));
            try EQL(false, chars.utils.isCtype(_cstr));

            // isUtype
            try EQL(true,  chars.utils.isUtype(_unsigned));
            try EQL(true,  chars.utils.isUtype(_comptime_int));
            try EQL(false, chars.utils.isUtype(_cstr));
            try EQL(false, chars.utils.isUtype(_str));
        }

        test "isPartOfUTF8" {
            const str = "=🌍🌟!";
            try EQL(false, chars.utils.isPartOfUTF8(str[0]));
            try EQL(false, chars.utils.isPartOfUTF8(str[1]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[2]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[3]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[4]));
            try EQL(false, chars.utils.isPartOfUTF8(str[5]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[6]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[7]));
            try EQL(true,  chars.utils.isPartOfUTF8(str[8]));
            try EQL(false, chars.utils.isPartOfUTF8(str[9]));
        }

        test "sizeOf" {
            const str = "=🌍🌟!";
            try EQL(1, chars.utils.sizeOf(str[0]));
            try EQL(4, chars.utils.sizeOf(str[1]));
            try EQL(1, chars.utils.sizeOf(str[2]));
            try EQL(1, chars.utils.sizeOf(str[3]));
            try EQL(1, chars.utils.sizeOf(str[4]));
            try EQL(4, chars.utils.sizeOf(str[5]));
            try EQL(1, chars.utils.sizeOf(str[6]));
            try EQL(1, chars.utils.sizeOf(str[7]));
            try EQL(1, chars.utils.sizeOf(str[8]));
            try EQL(1, chars.utils.sizeOf(str[9]));
            try EQL(1, chars.utils.sizeOf(str[10]));
        }

        test "indexOf" {
            const str = "=🌍🌟!";
            try EQL(0, chars.utils.indexOf(str, 0).?); // '='
            try EQL(1, chars.utils.indexOf(str, 1).?); // beg of "🌍"
            try EQL(5, chars.utils.indexOf(str, 2).?); // beg of "🌟"
            try EQL(9, chars.utils.indexOf(str, 3).?); // '!'
            try EQL(null, chars.utils.indexOf(str, 99));
        }

        test "begOf" {
            const str = "=🌍🌟!";
            try EQL(0, chars.utils.begOf(str, 0)); // '='
            try EQL(0, chars.utils.begOf(str, 1)); // beg of "🌍"
            try EQL(1, chars.utils.begOf(str, 2)); // #02 of "🌍"
            try EQL(2, chars.utils.begOf(str, 3)); // #03 of "🌍"
            try EQL(3, chars.utils.begOf(str, 4)); // #04 of "🌍"
            try EQL(0, chars.utils.begOf(str, 5)); // beg of "🌟"
            try EQL(1, chars.utils.begOf(str, 6)); // #02 of "🌟"
            try EQL(2, chars.utils.begOf(str, 7)); // #03 of "🌟"
            try EQL(3, chars.utils.begOf(str, 8)); // #04 of "🌟"
            try EQL(0, chars.utils.begOf(str, 9)); // '!'
        }

        test "rangeOf" {
            const str = "=🌍🌟!";
            try EQL(.{0, 1},  chars.utils.rangeOf(str, 0));
            try EQL(.{1, 5},  chars.utils.rangeOf(str, 1));
            try EQL(.{5, 9},  chars.utils.rangeOf(str, 2));
            try EQL(.{9, 10}, chars.utils.rangeOf(str, 3));
        }

        test "moveRight" {
            var str : [64]chars.types.char = undefined;
            str[0] = 'H';
            str[1] = '-';
            str[2] = 'e';
            str[3] = 'l';
            str[4] = 'l';
            str[5] = 'o';
            try EQLS("H-ello", str[0..6]);

            // "H-ello" => "HHello"
            chars.utils.moveRight(&str, 0, 1, 1);
            try EQLS("HHello", str[0..6]);

            // "HHello" => "HHeHeo"
            chars.utils.moveRight(&str, 1, 2, 2);
            try EQLS("HHeHeo", str[0..6]);

            // "HHeHeo" => "HHHHeo"
            chars.utils.moveRight(&str, 1, 1, 1);
            try EQLS("HHHHeo", str[0..6]);

            // "HHHHeo" => "HHHHeH"
            chars.utils.moveRight(&str, 3, 1, 2);
            try EQLS("HHHHeH", str[0..6]);

            // "HHHHeH" => "HHHHHH"
            chars.utils.moveRight(&str, 3, 1, 1);
            try EQLS("HHHHHH", str[0..6]);
        }

        test "moveLeft" {
            var str : [64]chars.types.char = undefined;
            str[0] = 'H';
            str[1] = '-';
            str[2] = 'e';
            str[3] = 'l';
            str[4] = 'l';
            str[5] = 'o';
            try EQLS("H-ello", str[0..6]);

            // "H-ello" => "Helllo"
            chars.utils.moveLeft(&str, 2, 3, 1);
            try EQLS("Helllo", str[0..6]);

            // "Helllo" => "Hello"
            chars.utils.moveLeft(&str, 5, 1, 1);
            try EQLS("Hello", str[0..5]);
        }

        test "copy" {
            var str : [64]chars.types.char = undefined;
            chars.utils.copy(&str, 0, "Hello");
            try EQLS("Hello", str[0..5]);

            chars.utils.copy(&str, 5, " ");
            try EQLS("Hello ", str[0..6]);

            chars.utils.copy(&str, 6, "🌍");
            try EQLS("Hello 🌍", str[0..10]);

            chars.utils.copy(&str, 10, "🌟");
            try EQLS("Hello 🌍🌟", str[0..14]);

            chars.utils.copy(&str, 14, "!");
            try EQLS("Hello 🌍🌟!", str[0..15]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── BASICS ───────────────────────────┐

        test "Empty constant" {
            // size > 0
            const res = chars.make(64, null);
            try EQL(64, chars.size(res));
            try EQL(0,  chars.bytes(res[0..]));

            // size = 0
            const res2 = chars.make(0, null);
            try EQL(0,  chars.size(res2));
            try EQL(0,  chars.bytes(res2[0..]));
        }

        test "Non-empty constant" {
            // size > 0
            const res = chars.make(64, "Hello");
            try EQL(64, chars.size(res));
            try EQL(5,  chars.bytes(res[0..])); // cuz, make method adds '\0' after appending the string.
        }

        test "Get the character/unicode at the non-real position" {
            const res = chars.make(64, "Hello 🌍🌟!");

            try EQLS("H", chars.get(res[0..], 0).?);
            try EQLS("e", chars.get(res[0..], 1).?);
            try EQLS("l", chars.get(res[0..], 2).?);
            try EQLS("l", chars.get(res[0..], 3).?);
            try EQLS("o", chars.get(res[0..], 4).?);
            try EQLS(" ", chars.get(res[0..], 5).?);
            try EQLS("🌍", chars.get(res[0..], 6).?);
            try EQLS("🌟", chars.get(res[0..], 7).?);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── INSERT ───────────────────────────┐

        test "Append a string" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello");
            chars.append(res[0..], 5, " ");
            chars.append(res[0..], 6, "🌍");
            chars.append(res[0..], 10, "!");
            try EQLS("Hello 🌍!", res[0..11]);

            chars.append(res[0..], 11, "🌟");
            chars.append(res[0..], 15, "🌍");
            chars.append(res[0..], 19, "!");
            try EQLS("Hello 🌍!🌟🌍!", res[0..20]);
        }

        test "Append a string (using insert function)" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, "Hello", 0);
            chars.insert(res[0..], 5, " ", 5);
            chars.insert(res[0..], 6, "🌍", 6);
            chars.insert(res[0..], 10, "!", 7);
            try EQLS("Hello 🌍!", res[0..11]);

            chars.insert(res[0..], 11, "🌟", 8);
            chars.insert(res[0..], 15, "🌍", 9);
            chars.insert(res[0..], 19, "!", 10);
            try EQLS("Hello 🌍!🌟🌍!", res[0..20]);
        }

        test "Append a character" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, 'H');
            chars.append(res[0..], 1, ' ');
            chars.append(res[0..], 2, 'W');
            chars.append(res[0..], 3, '!');
            try EQLS("H W!", res[0..4]);
        }

        test "Append a character (using insert function)" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, 'H', 0);
            chars.insert(res[0..], 1, ' ', 1);
            chars.insert(res[0..], 2, 'W', 2);
            chars.insert(res[0..], 3, '!', 3);
            try EQLS("H W!", res[0..4]);
        }

        test "Prepend a string" {
            var res = chars.make(64, null);

            chars.prepend(res[0..], 0, "Hello");
            chars.prepend(res[0..], 5, " ");
            chars.prepend(res[0..], 6, "🌍");
            chars.prepend(res[0..], 10, "!");
            try EQLS("!🌍 Hello", res[0..11]);

            chars.prepend(res[0..], 11, "🌟");
            chars.prepend(res[0..], 15, "🌍");
            chars.prepend(res[0..], 19, "!");
            try EQLS("!🌍🌟!🌍 Hello", res[0..20]);
        }

        test "Prepend a string (using insert function)" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, "Hello", 0);
            chars.insert(res[0..], 5, " ", 0);
            chars.insert(res[0..], 6, "🌍", 0);
            chars.insert(res[0..], 10, "!", 0);
            try EQLS("!🌍 Hello", res[0..11]);

            chars.insert(res[0..], 11, "🌟", 0);
            chars.insert(res[0..], 15, "🌍", 0);
            chars.insert(res[0..], 19, "!", 0);
            try EQLS("!🌍🌟!🌍 Hello", res[0..20]);
        }

        test "Prepend a character" {
            var res = chars.make(64, null);

            chars.prepend(res[0..], 0, 'H');
            chars.prepend(res[0..], 1, ' ');
            chars.prepend(res[0..], 2, 'W');
            chars.prepend(res[0..], 3, '!');
            try EQLS("!W H", res[0..4]);
        }

        test "Prepend a character (using insert function)" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, 'H', 0);
            chars.insert(res[0..], 1, ' ', 0);
            chars.insert(res[0..], 2, 'W', 0);
            chars.insert(res[0..], 3, '!', 0);
            try EQLS("!W H", res[0..4]);
        }

        test "Insert a character into a specifiec position" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, '!', 0);
            chars.insert(res[0..], 1, 'H', 0);
            chars.insert(res[0..], 2, ' ', 1);
            chars.insert(res[0..], 3, 'W', 2);
            try EQLS("H W!", res[0..4]);
        }

        test "Insert a string into a specifiec position" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, "!", 0);
            chars.insert(res[0..], 1, "🌍", 0);
            chars.insert(res[0..], 5, "Hello", 0);
            chars.insert(res[0..], 10, " ", 5);

            try EQLS("Hello 🌍!", res[0..11]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REMOVE ───────────────────────────┐

        test "Remove a rang of string (single character)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello");
            try EQLS("Hello", res[0..5]);

            chars.remove(res[0..], .{0, 1});
            try EQLS("ello", res[0..4]);

            chars.remove(res[0..], .{0, 2});
            try EQLS("lo", res[0..2]);

            chars.remove(res[0..], .{1, 2});
            try EQLS("l", res[0..1]);

            chars.remove(res[0..], .{0, 1});
            try EQLS("", res[0..0]);
        }

        test "Remove a range of string (multiple characters)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello World");
            try EQLS("Hello World", res[0..11]);

            chars.remove(res[0..], .{0, 6});
            try EQLS("World", res[0..5]);

            chars.remove(res[0..], .{0, 5});
            try EQLS("", res[0..0]);
        }

        test "Remove a single character" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello");
            try EQLS("Hello", res[0..5]);

            chars.remove(res[0..], 0);
            try EQLS("ello", res[0..4]);

            chars.remove(res[0..], 2);
            try EQLS("elo", res[0..3]);

            chars.remove(res[0..], 2);
            try EQLS("el", res[0..2]);

            chars.remove(res[0..], 0);
            try EQLS("l", res[0..1]);

            chars.remove(res[0..], 0);
            try EQLS("", res[0..0]);
        }

        test "Remove a unicode character (fake position)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", res[0..21]);

            chars.remove(res[0..], 0);
            try EQLS("🌍🌟!,=🌍🌟!", res[0..20]);

            chars.remove(res[0..], 4);
            try EQLS("🌍🌟!,🌍🌟!", res[0..19]);

            chars.remove(res[0..], 0);
            try EQLS("🌟!,🌍🌟!", res[0..15]);

            chars.remove(res[0..], 0);
            try EQLS("!,🌍🌟!", res[0..11]);

            chars.remove(res[0..], 0);
            try EQLS(",🌍🌟!", res[0..10]);

            chars.remove(res[0..], 2);
            try EQLS(",🌍!", res[0..6]);

            chars.remove(res[0..], 0);
            try EQLS("🌍!", res[0..5]);

            chars.remove(res[0..], 1);
            try EQLS("🌍", res[0..4]);

            chars.remove(res[0..], 0);
            try EQLS("", res[0..0]);
        }

        test "Remove a unicode character (fake range)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", res[0..21]);

            chars.remove(res[0..], .{0, 1});
            try EQLS("🌍🌟!,=🌍🌟!", res[0..20]);

            chars.remove(res[0..], .{4, 5});
            try EQLS("🌍🌟!,🌍🌟!", res[0..19]);

            chars.remove(res[0..], 0);
            try EQLS("🌟!,🌍🌟!", res[0..15]);

            chars.remove(res[0..], 0);
            try EQLS("!,🌍🌟!", res[0..11]);

            chars.remove(res[0..], 0);
            try EQLS(",🌍🌟!", res[0..10]);

            chars.remove(res[0..], 2);
            try EQLS(",🌍!", res[0..6]);

            chars.remove(res[0..], 0);
            try EQLS("🌍!", res[0..5]);

            chars.remove(res[0..], 1);
            try EQLS("🌍", res[0..4]);

            chars.remove(res[0..], 0);
            try EQLS("", res[0..0]);
        }

        test "Remove a unicode character (real position)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", res[0..21]);

            chars.removeReal(res[0..], 0);
            try EQLS("🌍🌟!,=🌍🌟!", res[0..20]);

            chars.removeReal(res[0..], 10);
            try EQLS("🌍🌟!,🌍🌟!", res[0..19]);

            chars.removeReal(res[0..], 0);
            try EQLS("🌟!,🌍🌟!", res[0..15]);

            chars.removeReal(res[0..], 0);
            try EQLS("!,🌍🌟!", res[0..11]);

            chars.removeReal(res[0..], 0);
            try EQLS(",🌍🌟!", res[0..10]);

            chars.removeReal(res[0..], 5);
            try EQLS(",🌍!", res[0..6]);

            chars.removeReal(res[0..], 0);
            try EQLS("🌍!", res[0..5]);

            chars.removeReal(res[0..], 4);
            try EQLS("🌍", res[0..4]);

            chars.removeReal(res[0..], 0);
            try EQLS("", res[0..0]);
        }

        test "Remove a unicode character (real range)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "=🌍🌟!,=🌍🌟!");
            try EQLS("=🌍🌟!,=🌍🌟!", res[0..21]);

            chars.removeReal(res[0..], .{0, 1});
            try EQLS("🌍🌟!,=🌍🌟!", res[0..20]);

            chars.removeReal(res[0..], .{10, 11});
            try EQLS("🌍🌟!,🌍🌟!", res[0..19]);

            chars.removeReal(res[0..], .{0, 4});
            try EQLS("🌟!,🌍🌟!", res[0..15]);

            chars.removeReal(res[0..], .{0, 4});
            try EQLS("!,🌍🌟!", res[0..11]);

            chars.removeReal(res[0..], .{0, 1});
            try EQLS(",🌍🌟!", res[0..10]);

            chars.removeReal(res[0..], .{5, 9});
            try EQLS(",🌍!", res[0..6]);

            chars.removeReal(res[0..], .{0, 1});
            try EQLS("🌍!", res[0..5]);

            chars.removeReal(res[0..], .{4, 5});
            try EQLS("🌍", res[0..4]);

            chars.removeReal(res[0..], .{0, 4});
            try EQLS("", res[0..0]);
        }

        test "Remove N characters from the end of the string (using pop function)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello World!");
            try EQLS("Hello World!", res[0..12]);

            try EQL(1, chars.pop(res[0..12], 1));
            try EQLS("Hello World", res[0..11]);

            try EQL(6, chars.pop(res[0..11], 6));
            try EQLS("Hello", res[0..5]);

            try EQL(4, chars.pop(res[0..5], 5));
            try EQLS("", res[0..0]);
        }

        test "Remove N characters from the beginning of the string (using shift function)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello World!");
            try EQLS("Hello World!", res[0..12]);

            try EQL(1, chars.shift(res[0..], 12, 1));
            try EQLS("ello World!", res[0..11]);

            try EQL(5, chars.shift(res[0..], 11, 5));
            try EQLS("World!", res[0..6]);

            try EQL(6, chars.shift(res[0..], 6, 6));
            try EQLS("", res[0..0]);
        }

        test "Fill the string with (`0` character)" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, "Hello World!");
            try EQLS("Hello World!", res[0..12]);

            chars.zeros(res[0..]);
            try EQL(0, res[0]);
            try EQL(0, res[1]);
            try EQL(0, res[2]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── FIND ────────────────────────────┐

        test "Find a first character in a string" {
            const str = "=🌍🌟!=🌍🌟!";
            try EQL(null, chars.find(str, '@')); // 0
            try EQL(0, chars.find(str, '=').?); // 0
            try EQL(9, chars.find(str, '!').?); // 9
        }

        test "Find a first string/unicode in a string" {
            const str = "=🌍🌟!=🌍🌟!";
            try EQL(1, chars.find(str, "🌍").?); // 1
            try EQL(5, chars.find(str, "🌟").?); // 5
        }

        test "Find a last character in a string" {
            const str = "=🌍🌟!=🌍🌟!";
            try EQL(10, chars.rfind(str, '=').?); // 10
            try EQL(19, chars.rfind(str, '!').?); // 19
        }

        test "Find a last string/unicode in a string" {
            const str = "=🌍🌟!=🌍🌟!";
            try EQL(11, chars.rfind(str, "🌍").?); // 11
            try EQL(15, chars.rfind(str, "🌟").?); // 15
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── CASE ────────────────────────────┐

        test "Convert a string to lower case" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "HELLO WORLD!");

            chars.toLower(res[0..12]);
            try EQLS("hello world!", res[0..12]);
        }

        test "Convert a string to upper case" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "hello world!");

            chars.toUpper(res[0..12]);
            try EQLS("HELLO WORLD!", res[0..12]);
        }

        test "Convert a string to title case" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "hello world!");

            chars.toTitle(res[0..12]);
            try EQLS("Hello World!", res[0..12]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── CHECKS ───────────────────────────┐

        test "Is strings equals?" {
            try EQ(!chars.eql("", "!"));
            try EQ(chars.eql("", ""));
            try EQ(chars.eql("!", "!"));
            try EQ(chars.eql("Hello World!", "Hello World!"));
            try EQ(chars.eql("!🌍🌟=", "!🌍🌟="));
        }

        test "Is string starts with ?" {
            try EQ(!chars.startsWith("", "!"));
            try EQ(chars.startsWith("", ""));
            try EQ(chars.startsWith("!🌍🌟=", "!"));
            try EQ(chars.startsWith("!🌍🌟=", "!🌍"));
            try EQ(chars.startsWith("!🌍🌟=", "!🌍🌟"));
            try EQ(chars.startsWith("!🌍🌟=", "!🌍🌟"));
        }

        test "Is string ends with ?" {
            // try EQ(!chars.endsWith("", "!")); // invalid because lengths not equals.
            try EQ(chars.endsWith("", ""));
            try EQ(chars.endsWith("!🌍🌟=", "="));
            try EQ(chars.endsWith("!🌍🌟=", "🌟="));
            try EQ(chars.endsWith("!🌍🌟=", "🌍🌟="));
            try EQ(chars.endsWith("!🌍🌟=", "!🌍🌟="));
        }

        test "Is string includes ?" {
            try EQ(chars.includes("!🌍🌟=", '!'));
            try EQ(chars.includes("!🌍🌟=", '='));
            try EQ(!chars.includes("!🌍🌟=", '@'));

            try EQ(chars.includes("!🌍🌟=", "🌍"));
            try EQ(chars.includes("!🌍🌟=", "🌟"));
            try EQ(chars.includes("!🌍🌟=", "🌍🌟"));
            try EQ(chars.includes("!🌍🌟=", "!🌍🌟"));
            try EQ(chars.includes("!🌍🌟=", "!🌍🌟="));
            try EQ(!chars.includes("!🌍🌟=", "!🌍!🌟="));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── TRIM ────────────────────────────┐

        test "Trim start of string" {
            var res = chars.make(64, null);
            try EQL(0, chars.trimStart(res[0..], ' '));

            chars.append(res[0..], 0, "   !🌍🌟=   ");
            try EQL(3, chars.trimStart(res[0..], ' '));
            try EQLS("!🌍🌟=   ", res[0..13]);
        }

        test "Trim end of string" {
            var res = chars.make(64, null);
            try EQL(0, chars.trimEnd(res[0..], ' '));

            chars.append(res[0..], 0, "   !🌍🌟=   ");
            try EQL(3, chars.trimEnd(res[0..16], ' '));
            try EQLS("   !🌍🌟=", res[0..13]);
        }

        test "Trim start and end of string" {
            var res = chars.make(64, null);
            try EQL(0, chars.trimEnd(res[0..], ' '));

            chars.append(res[0..], 0, "   !🌍🌟=   ");
            try EQL(6, chars.trim(res[0..16], ' '));
            try EQLS("!🌍🌟=", res[0..10]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REPLACE ──────────────────────────┐

        test "Replace N character with character in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "=1=1=1");

            const r1 = chars.replace(res[0..], 6, '=', '0', 1);
            try EQL(1, r1);
            try EQLS("01=1=1", res[0..6]);

            const r2 = chars.replace(res[0..], 6, '=', '0', 2);
            try EQL(2, r2);
            try EQLS("010101", res[0..6]);

            const r3 = chars.replace(res[0..], 6, '1', '=', 0);
            try EQL(3, r3);
            try EQLS("0=0=0=", res[0..6]);
        }

        test "Replace N string with string in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "==11==11==11");

            const r1 = chars.replace(res[0..], 12, "==", "00", 1);
            try EQL(1, r1);
            try EQLS("0011==11==11", res[0..12]);

            const r2 = chars.replace(res[0..], 12, "==", "00", 2);
            try EQLS("001100110011", res[0..12]);
            try EQL(2, r2);

            const r3 = chars.replace(res[0..], 12, "11", "==", 0);
            try EQL(3, r3);
            try EQLS("00==00==00==", res[0..12]);
        }

        test "Replace N unicode with string in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "🌍🌟🌍🌟🌍🌟");

            const r1 = chars.replace(res[0..], 24, "🌍", "!", 1);
            try EQL(4, r1);
            try EQLS("!🌟🌍🌟🌍🌟", res[0..21]);

            const r2 = chars.replace(res[0..], 24, "🌍", "!", 2);
            try EQL(8, r2);
            try EQLS("!🌟!🌟!🌟", res[0..15]);
        }

        test "Replace last N character with character in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "=1=1=1");

            const r1 = chars.rreplace(res[0..], 6, '=', '0', 1);
            try EQL(1, r1);
            try EQLS("=1=101", res[0..6]);

            const r2 = chars.rreplace(res[0..], 6, '=', '0', 2);
            try EQL(2, r2);
            try EQLS("010101", res[0..6]);

            const r3 = chars.rreplace(res[0..], 6, '1', '=', 0);
            try EQL(3, r3);
            try EQLS("0=0=0=", res[0..6]);
        }

        test "Replace last N string with string in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "==11==11==11");

            const r1 = chars.rreplace(res[0..], 12, "==", "00", 1);
            try EQL(1, r1);
            try EQLS("==11==110011", res[0..12]);

            const r2 = chars.rreplace(res[0..], 12, "==", "00", 2);
            try EQL(2, r2);
            try EQLS("001100110011", res[0..12]);

            const r3 = chars.rreplace(res[0..], 12, "11", "==", 0);
            try EQL(3, r3);
            try EQLS("00==00==00==", res[0..12]);
        }

        test "Replace last N unicode with string in string" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "🌍🌟🌍🌟🌍🌟");

            const r1 = chars.rreplace(res[0..], 24, "🌍", "!", 1);
            try EQL(4, r1);
            try EQLS("🌍🌟🌍🌟!🌟", res[0..21]);

            const r2 = chars.rreplace(res[0..], 24, "🌍", "!", 2);
            try EQL(8, r2);
            try EQLS("!🌟!🌟!🌟", res[0..15]);
        }

        test "Basics of replace" {
            // replace a character with a character
            {
                var res = chars.make(64, "0123");

                // replace a #1 character in a string with a character
                try EQL(1, chars.replace(res[0..], 4, '0', 'A', 1)); // 👉 (res = 1), "A123"
                try EQLS("A123", res[0..4]);

                // replace a #2 character in a string with a character
                try EQL(1, chars.replace(res[0..], 4, '1', 'B', 1)); // 👉 (res = 1), "AB23"
                try EQLS("AB23", res[0..4]);

                // replace a #3 character in a string with a character
                try EQL(1, chars.replace(res[0..], 4, '2', 'C', 1)); // 👉 (res = 1), "ABC3"
                try EQLS("ABC3", res[0..4]);

                // replace a #4 character in a string with a character
                try EQL(1, chars.replace(res[0..], 4, '3', 'D', 1)); // 👉 (res = 1), "ABCD"
                try EQLS("ABCD", res[0..4]);
            }

            // replace a character with a string
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, '0', "A", 1)); // 👉 (res = 1), "A123"
                try EQLS("A123", res[0..4]);
            }

            // replace a character with a long string
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, '0', "ABC", 1)); // 👉 (res = 1), "ABC123"
                try EQLS("ABC123", res[0..6]);
            }

            // replace a string with a character
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, "0", 'A', 1)); // 👉 (res = 1), "A123"
                try EQLS("A123", res[0..4]);
            }

            // replace a long string with a character
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, "012", 'A', 1)); // 👉 (res = 1), "A3"
                try EQLS("A3", res[0..2]);
            }

            // replace a string with a string
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, "0", "A", 1)); // 👉 (res = 1), "A123"
                try EQLS("A123", res[0..4]);
            }

            // replace a character with unicode
            {
                var res = chars.make(64, "0123");
                try EQL(1, chars.replace(res[0..], 4, '0', "🌍", 1)); // 👉 (res = 1), "🌍123"
                try EQLS("🌍123", res[0..7]);
            }

            // replace a unicode with character
            {
                var res = chars.make(64, "🌍123");
                try EQL(4, chars.replace(res[0..], 7, "🌍", 'A', 1)); // 👉 (res = 1), "A123"
                try EQLS("A123", res[0..4]);
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REPEAT ───────────────────────────┐

        test "Repeat character N times in string" {
            var res = chars.make(64, null);

            chars.repeat(res[0..], 0, '0', 1);
            try EQLS("0", res[0..1]);

            chars.repeat(res[0..], 1, '0', 2);
            try EQLS("000", res[0..3]);
        }

        test "Repeat string N times in string" {
            var res = chars.make(64, null);

            chars.repeat(res[0..], 0, "00", 1);
            try EQLS("00", res[0..2]);

            chars.repeat(res[0..], 2, "00", 2);
            try EQLS("000000", res[0..6]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── REVERSE ───────────────────────────┐

        test "Reverse a string containing a unicode character" {
            var res = chars.make(64, "Hello 🌍!");

            chars.reverse(res[0..11]);
            try EQLS("!🌍 olleH", res[0..11]);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── SPLIT ────────────────────────────┐

        test "Split a string into slice" {
            var res = chars.make(64, null);
            chars.append(res[0..], 0, "🌍1🌍🌍2🌍🌍3🌍");       // 👉 "🌍1🌍🌍2🌍🌍3🌍"
            const len = 27;

            try EQLS(chars.split(res[0..len], "🌍", 0).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..len], "🌍", 1).?, "1"); // 👉 "1"
            try EQLS(chars.split(res[0..len], "🌍", 2).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..len], "🌍", 3).?, "2"); // 👉 "2"
            try EQLS(chars.split(res[0..len], "🌍", 5).?, "3"); // 👉 "3"
            try EQLS(chars.split(res[0..len], "🌍", 6).?,  ""); // 👉 ""
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── DOCS ────────────────────────────┐

        test "readme example" {
            // Creates a new array of characters with undefined value.
            var str = chars.make(64, null);

            // Appends a string to the array.
            chars.append(str[0..], 0, "Hello 🌍");                  // 👉 "Hello 🌍"
            try EQLS("Hello 🌍",str[0..10]);

            // Appends a character to the array.
            chars.append(str[0..], 10, '!');                        // 👉 "Hello 🌍!"
            try EQLS("Hello 🌍!",str[0..11]);

            // Removes a character using its positions.
            chars.remove(str[0..], 1);                              // 👉 "Hllo 🌍!"
            try EQLS("Hllo 🌍!",str[0..10]);

            // Removes a range of string.
            chars.remove(str[0..], .{ 0, 6});                       // 👉 "!"
            try EQLS("!",str[0..1]);

            // Replace a part of string with another
            _ = chars.replace(str[0..], 1, "!", "Hello 🌍!", 1);    // 👉 "Hello 🌍!"
            try EQLS("Hello 🌍!",str[0..11]);
        }
        test "docs: make" {

            // init with undefined.
            const src1 = chars.make(64, null);
            try EQL(undefined,src1); // 👉 undefined

            // init with value.
            const src2 = chars.make(64, "=🌍🌟!");
            try EQLS("=🌍🌟!",src2[0..10]); // 👉 =🌍🌟!..
        }

        test "docs: size" {
            var res = chars.make(64, "=🌍🌟!");

            // size of array.
            try EQL(64, chars.size(res[0..])); // 👉 64

            // size of single characters.
            try EQL(1,  chars.size(res[0])); // 👉 1

            // size of unicode.
            try EQL(4,chars.size(res[1])); // 👉 4 'beg  of 🌍'
            try EQL(1,chars.size(res[2])); // 👉 1 'part of 🌍'
            try EQL(1,chars.size(res[3])); // 👉 1 'part of 🌍'
            try EQL(1,chars.size(res[4])); // 👉 1 'end  of 🌍'

            try EQL(4,chars.size(res[5])); // 👉 4 'beg  of 🌟'
            try EQL(1,chars.size(res[6])); // 👉 1 'part of 🌟'
            try EQL(1,chars.size(res[7])); // 👉 1 'part of 🌟'
            try EQL(1,chars.size(res[8])); // 👉 1 'end  of 🌟'

            // size of single character.
            try EQL(1,chars.size(res[9])); // 👉 1 '!'
        }

        test "docs: bytes" {
            var src = chars.make(64, null);

            // non-terminated string.
            try EQL(0,chars.bytes(src[0..])); // 👉 64

            // append some string.
            chars.append(src[0..], 0, "=🌍🌟!");

            // terminate the string
            src[11] = 0;

            // try again
            try EQL(10,chars.bytes(src[0..])); // 👉 10
        }

        test "docs: ubytes" {
            var src = chars.make(64, null);

            // non-terminated string.
            try EQL(0,chars.ubytes(src[0..])); // 👉 64

            // append some string.
            chars.append(src[0..], 0, "=🌍🌟!");

            // terminate the string
            src[11] = 0;

            // try again
            try EQL(4, chars.ubytes(src[0..10])); // 👉 4
        }

        test "docs: get" {
            var res = chars.make(64, "=🌍🌟!");
            try EQLS(chars.get(res[0..], 0).?,  "="); // 👉 "="
            try EQLS(chars.get(res[0..], 1).?, "🌍"); // 👉 "🌍"
            try EQLS(chars.get(res[0..], 2).?, "🌟"); // 👉 "🌟"
            try EQLS(chars.get(res[0..], 3).?,  "!"); // 👉 "!"
        }

        test "docs: append" {
            var res = chars.make(64, null);

            chars.append(res[0..], 0, '=');
            try EQLS("=", res[0..1]);   // 👉 "="

            chars.append(res[0..], 1, "🌍");    // 👉 "=🌍"
            try EQLS("=🌍", res[0..5]);

            chars.append(res[0..], 5, "🌟");    // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", res[0..9]);

            chars.append(res[0..], 9, "!!");    // 👉 "=🌍🌟!!"
            try EQLS("=🌍🌟!!", res[0..11]);
        }

        test "docs: prepend" {
            var res = chars.make(64, null);

            chars.prepend(res[0..], 0, '=');
            try EQLS("=", res[0..1]);   // 👉 "="

            chars.prepend(res[0..], 1, "🌍");    // 👉 "🌍="
            try EQLS("🌍=", res[0..5]);

            chars.prepend(res[0..], 5, "🌟");    // 👉 "🌟🌍="
            try EQLS("🌟🌍=", res[0..9]);

            chars.prepend(res[0..], 9, "!!");    // 👉 "!!🌟🌍="
            try EQLS("!!🌟🌍=", res[0..11]);
        }

        test "docs: insert" {
            var res = chars.make(64, null);

            chars.insert(res[0..], 0, '=', 0);      // 👉 "="
            try EQLS("=", res[0..1]);

            chars.insert(res[0..], 1, "🌍", 1);    // 👉 "=🌍"
            try EQLS("=🌍", res[0..5]);

            chars.insert(res[0..], 5, "🌟", 1);    // 👉 "=🌟🌍"
            try EQLS("=🌟🌍", res[0..9]);

            chars.insert(res[0..], 9, "!!", 3);    // 👉 "=🌟🌍!!"
            try EQLS("=🌟🌍!!", res[0..11]);
        }

        test "docs: remove" {
            var res = chars.make(64, "=🌍🌟!");

            chars.remove(res[0..], 0);              // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", res[0..9]);
            chars.remove(res[0..], .{ 1, 2 });      // 👉 "🌍!"
            try EQLS("🌍!", res[0..5]);
            chars.remove(res[0..], .{ 0, 1 });      // 👉 "!"
            try EQLS("!", res[0..1]);
        }

        test "docs: removeReal" {
            var res = chars.make(64, "=🌍🌟!");

            chars.removeReal(res[0..], 0);          // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", res[0..9]);
            chars.removeReal(res[0..], .{ 4, 8 });  // 👉 "🌍!"
            try EQLS("🌍!", res[0..5]);
            chars.removeReal(res[0..], .{ 0, 4 });  // 👉 "!"
            try EQLS("!", res[0..1]);
        }

        test "docs: pop" {
            var res = chars.make(64, "=🌍🌟!");
            try EQL(1, chars.pop(res[0..10], 1)); // 👉 "=🌍🌟"
            try EQLS("=🌍🌟", res[0..9]);

            try EQL(4, chars.pop(res[0..9], 1));  // 👉 "=🌍"
            try EQLS("=🌍", res[0..5]);

            try EQL(4, chars.pop(res[0..5], 1));  // 👉 "="
            try EQLS("=", res[0..1]);
        }

        test "docs: shift" {
            var res = chars.make(64, "=🌍🌟!");

            try EQL(1, chars.shift(res[0..], 10, 1)); // 👉 "🌍🌟!"
            try EQLS("🌍🌟!", res[0..9]);
            try EQL(4, chars.shift(res[0..], 9, 1));  // 👉 "🌟!"
            try EQLS("🌟!", res[0..5]);
            try EQL(4, chars.shift(res[0..], 5, 1));  // 👉 "!"
            try EQLS("!", res[0..1]);
        }

        test "docs: zeros" {
            var res = chars.make(64, "=🌍🌟!");

            chars.zeros(res[0..]);  // 👉 ""
            try EQL(0, res[0]);
            try EQLS("", res[0..0]);
        }

        test "docs: trimStart" {
            var res = chars.make(64, "  =🌍🌟!");
            try EQL(2, chars.trimStart(res[0..12], ' ')); // 👉 (r = 2), "=🌍🌟!"
        }

        test "docs: trimEnd" {
            var res = chars.make(64, "=🌍🌟!  ");
            try EQL(2, chars.trimEnd(res[0..12], ' ')); // 👉 (r = 2), "=🌍🌟!"
        }

        test "docs: trim" {
            var res = chars.make(64, "  =🌍🌟!  ");
            try EQL(4, chars.trim(res[0..14], ' '));    // 👉 (r = 4), "=🌍🌟!"
        }

        test "docs: find" {
            var res = chars.make(64, "==🌍🌟!!");
            try EQL(0, chars.find(res[0..12], '='));    // 👉 0   ("=")
            try EQL(2, chars.find(res[0..12], "🌍"));   // 👉 2   (beg of "🌍")
            try EQL(6, chars.find(res[0..12], "🌟"));   // 👉 6   (beg of "🌟")
            try EQL(10, chars.find(res[0..12], "!!"));  // 👉 10  ("!!")
        }

        test "docs: rfind" {
            var res = chars.make(64, "==🌍🌟!!");
            try EQL(1, chars.rfind(res[0..12], '='));    // 👉 1   ("=")
            try EQL(2, chars.rfind(res[0..12], "🌍"));   // 👉 2   (beg of "🌍")
            try EQL(6, chars.rfind(res[0..12], "🌟"));   // 👉 6   (beg of "🌟")
            try EQL(10, chars.rfind(res[0..12], "!!"));  // 👉 10  ("!!")
        }

        test "docs: toLower" {
            var res = chars.make(64, "HELLO 🌍!");
            chars.toLower(res[0..11]); // 👉 "hello 🌍!"
            try EQLS("hello 🌍!", res[0..11]);
        }

        test "docs: toUpper" {
            var res = chars.make(64, "hello 🌍!");
            chars.toUpper(res[0..11]); // 👉 "HELLO 🌍!"
            try EQLS("HELLO 🌍!", res[0..11]);
        }

        test "docs: toTitle" {
            var res = chars.make(64, "hello 🌍!");
            chars.toTitle(res[0..11]); // 👉 "Hello 🌍!"
            try EQLS("Hello 🌍!", res[0..11]);
        }

        test "docs: eql" {
            try EQ(chars.eql("", ""));               // 👉 true
            try EQ(chars.eql("=🌍🌟!", "=🌍🌟!"));   // 👉 true
            try EQ(!chars.eql("=🌍🌟!", "====="));   // 👉 false
            try EQ(chars.eql("!", '!'));            // 👉 true

            // two characters
            try EQ(chars.eql('@', '@'));            // 👉 true
            // string and character
            try EQ(chars.eql("@", '@'));            // 👉 true
            // character and string
            try EQ(chars.eql('@', "@"));            // 👉 true
        }

        test "docs: startsWith" {
            const str = chars.make(64, "=🌍🌟!");

            try EQ(!chars.startsWith(str[0..10], ""));      // 👉 false
            try EQ(!chars.startsWith(str[0..10], "🌍"));    // 👉 false
            try EQ(chars.startsWith(str[0..10], '='));      // 👉 true
        }

        test "docs: endsWith" {
            const str = chars.make(64, "=🌍🌟!");

            try EQ(!chars.endsWith(str[0..10], ""));    // 👉 false
            try EQ(!chars.endsWith(str[0..10], "🌟"));  // 👉 false
            try EQ(chars.endsWith(str[0..10], '!'));    // 👉 true
        }

        test "docs: includes" {
            const res = chars.make(64, "=🌍🌟!");
            try EQ(chars.includes(res[0..10], '='));    // 👉 true
            try EQ(chars.includes(res[0..10], "🌍"));   // 👉 true
            try EQ(chars.includes(res[0..10], "🌟"));   // 👉 true
            try EQ(chars.includes(res[0..10], "!"));    // 👉 true
            try EQ(!chars.includes(res[0..10], '@'));   // 👉 false
        }

        test "docs: replace" {
            var res = chars.make(64, "==🌍🌟!!");

            // replace character.
            try EQL(1, chars.replace(res[0..], 12, '=', '@', 1));    // 👉 (res = 1), "@=🌍🌟!!"
            try EQLS("@=🌍🌟!!", res[0..12]);

            // replace unicode.
            try EQL(4, chars.replace(res[0..], 12, "🌍", '!', 1));   // 👉 (res = 4), "@=!🌟!!"
            try EQLS("@=!🌟!!", res[0..9]);

            // replace string.
            try EQL(4, chars.replace(res[0..], 9, "🌟", '!', 1));    // 👉 (res = 4), "@=!!!!"
            try EQLS("@=!!!!", res[0..6]);
        }

        test "docs: rreplace" {
            var res = chars.make(64, "==🌍🌟!!");

            // replace character.
            try EQL(1, chars.rreplace(res[0..], 12, '=', '@', 1));    // 👉 (res = 1), "=@🌍🌟!!"
            try EQLS("=@🌍🌟!!", res[0..12]);

            // replace unicode.
            try EQL(4, chars.rreplace(res[0..], 12, "🌍", '!', 1));   // 👉 (res = 4), "=@!🌟!!"
            try EQLS("=@!🌟!!", res[0..9]);

            // replace string.
            try EQL(4, chars.rreplace(res[0..], 9, "🌟", '!', 1));    // 👉 (res = 4), "=@!!!!"
            try EQLS("=@!!!!", res[0..6]);
        }

        test "docs: repeat" {
            var res = chars.make(64, null);

            // repeat character.
            chars.repeat(res[0..], 0, '0', 1); // 👉 "0"
            try EQLS("0", res[0..1]);

            chars.repeat(res[0..], 1, '0', 2); // 👉 "000"
            try EQLS("000", res[0..3]);

            // repeat string.
            chars.repeat(res[0..], 3, "@#", 2); // 👉 "000@#@#"
            try EQLS("000@#@#", res[0..7]);

            // repeat unicode.
            chars.repeat(res[0..], 7, "🌍", 2); // 👉 "000@#@#🌍🌍"
            try EQLS("000@#@#🌍🌍", res[0..15]);
        }

        test "docs: reverse" {
            var res = chars.make(64, "=🌍🌟!");

            chars.reverse(res[0..10]); // 👉 "!🌟🌍="
            try EQLS("!🌟🌍=", res[0..10]);
        }

        test "docs: split" {
            var res = chars.make(64, "🌍1🌍🌍2🌍🌍3🌍");
            try EQLS(chars.split(res[0..27], "🌍", 0).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..27], "🌍", 1).?, "1"); // 👉 "1"
            try EQLS(chars.split(res[0..27], "🌍", 2).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..27], "🌍", 3).?, "2"); // 👉 "2"
            try EQLS(chars.split(res[0..27], "🌍", 5).?, "3"); // 👉 "3"
            try EQLS(chars.split(res[0..27], "🌍", 6).?,  ""); // 👉 ""
        }

        test "docs: split using character" {
            var res = chars.make(64, ",1,,2,,3,");
            try EQLS(chars.split(res[0..9], ',', 0).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..9], ',', 1).?, "1"); // 👉 "1"
            try EQLS(chars.split(res[0..9], ',', 2).?,  ""); // 👉 ""
            try EQLS(chars.split(res[0..9], ',', 3).?, "2"); // 👉 "2"
            try EQLS(chars.split(res[0..9], ',', 5).?, "3"); // 👉 "3"
            try EQLS(chars.split(res[0..9], ',', 6).?,  ""); // 👉 ","
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝