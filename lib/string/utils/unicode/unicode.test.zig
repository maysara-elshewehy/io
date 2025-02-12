// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std           = @import("std");
    const chars         = @import("../chars/chars.zig");
    const unicode       = @import("./unicode.zig");
    const Iterator      = unicode.Iterator;
    const Codepoint     = unicode.Codepoint;
    const expect        = std.testing.expect;
    const expectEqual   = std.testing.expectEqual;
    const expectError   = std.testing.expectError;
    const exceptSlice   = std.testing.expectEqualSlices;
    const exceptStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌────────────────────────── Codepoint ─────────────────────────┐

        test "unicode.Codepoint" {
            const ZWJ_array    : [3]u8 = .{0xE2, 0x80, 0x8D};
            const MOD_array    : [2]u8 = .{0xCC, 0x81};
            const invalid_utf8 : [2]u8 = .{0xc0, 0x80};

            const None = try Codepoint.init("A");          // Regular character.
            try expectEqual(.None, None.mode);
            try expectEqual(1, None.len);

            const ZWJ = try Codepoint.init(&ZWJ_array);    // Zero Width Joiner.
            try expectEqual(.ZWJ, ZWJ.mode);
            try expectEqual(3, ZWJ.len);

            const MOD = try Codepoint.init(&MOD_array);    // Combining Acute Accent.
            try expectEqual(.Mod, MOD.mode);
            try expectEqual(2, MOD.len);

            try expectError(error.InvalidValue, Codepoint.init(&invalid_utf8));

            // more complex
            {
                const txt = "Aأ你🌟☹️👨‍🏭@";
                {
                    const cp = try Codepoint.init(txt[0..1]);
                    try expectEqual(1, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[1..3]);
                    try expectEqual(2, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[3..6]);
                    try expectEqual(3, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[6..10]);
                    try expectEqual(4, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[10..13]);
                    try expectEqual(3, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[13..16]);
                    try expectEqual(3, cp.len);
                    try expectEqual(.Mod, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[16..20]);
                    try expectEqual(4, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[20..23]);
                    try expectEqual(3, cp.len);
                    try expectEqual(.ZWJ, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[23..27]);
                    try expectEqual(4, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    const cp = try Codepoint.init(txt[27..28]);
                    try expectEqual(1, cp.len);
                    try expectEqual(.None, cp.mode);
                }
                {
                    try expectError(error.InvalidValue, Codepoint.init(txt[6..8])); // 👉 error.InvalidValue (half of 🌟)
                }
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐

        fn testCodepointIterator() !void {
            var it1 = try Iterator.init("Hello 🌍");
            try expect(std.mem.eql(u8, "H", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, "e", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, "l", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, "l", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, "o", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, " ", it1.nextCodepointSlice().?));
            try expect(std.mem.eql(u8, "🌍", it1.nextCodepointSlice().?));
            try expect(it1.nextCodepointSlice() == null);

            // next
            var it2 = try Iterator.init("Hello 🌍");
            try expect(it2.next().? == 'H');
            try expect(it2.next().? == 'e');
            try expect(it2.next().? == 'l');
            try expect(it2.next().? == 'l');
            try expect(it2.next().? == 'o');
            try expect(it2.next().? == ' ');
            try expect(it2.next().? == '🌍');
            try expect(it2.next() == null);

            // peek
            var it3 = try Iterator.init("Hello 🌍");
            try exceptStrings("He", it3.peek(2).?);
        }

        fn testGraphemeClusterIterator() !void {
            @setEvalBranchQuota(2000);

            // nextCodepointSlice
            var it1 = try Iterator.init("👨‍🏭مرحبا");
            try expect(std.mem.eql(u8, "👨‍🏭", it1.nextGraphemeClusterSlice().?));
            try expect(std.mem.eql(u8, "م",  it1.nextGraphemeClusterSlice().?));
            try expect(std.mem.eql(u8, "ر",  it1.nextGraphemeClusterSlice().?));
            try expect(std.mem.eql(u8, "ح",  it1.nextGraphemeClusterSlice().?));
            try expect(std.mem.eql(u8, "ب",  it1.nextGraphemeClusterSlice().?));
            try expect(std.mem.eql(u8, "ا",  it1.nextGraphemeClusterSlice().?));
            try expect(it1.nextGraphemeClusterSlice() == null);

            // TODO: improve (next and peek) functions to use specific mode like (graphemeCluster) not just (codepoint).

            // next
            var it2 = try Iterator.init("👨‍🏭مرحبا");
            _ = it2.next().?; // "👨‍🏭"[0..4][0]
            _ = it2.next().?; // "👨‍🏭"[4..7][0]
            _ = it2.next().?; // "👨‍🏭"[7..11][0]
            try expect(it2.next().? == 'م');
            try expect(it2.next().? == 'ر');
            try expect(it2.next().? == 'ح');
            try expect(it2.next().? == 'ب');
            try expect(it2.next().? == 'ا');
            try expect(it2.next() == null);

            // peek
            var it3 = try Iterator.init("👨‍🏭مرحبا");
            try exceptStrings("👨‍🏭", it3.peek(3).?);
        }

        test "unicode.Iterator" {
            try comptime testCodepointIterator();
            try testCodepointIterator();

            try comptime testGraphemeClusterIterator();
            try testGraphemeClusterIterator();
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Getters ──────────────────────────┐

        test "unicode.getFirstCodepointSlice" {
            const test_cases = .{
                .{"A-", "A"},
                .{"أ-", "أ"},
                .{"你-", "你"},
                .{"🌟-", "🌟"},
                .{"☹️-",  &[_]u8{ 0xE2, 0x98, 0xB9 }},       // first codepoint at ☹️ (emojie)
                .{"👨‍🏭-", &[_]u8{ 0xF0, 0x9F, 0x91, 0xA8 }}, // first codepoint at 👨‍🏭 (emojie)
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected = test_case[1];

                try exceptSlice(u8, expected, unicode.getFirstCodepointSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, unicode.getFirstCodepointSlice(""));
        }

        test "unicode.getLastCodepointSlice" {
            const test_cases = .{
                .{"-A", "A"},
                .{"-أ", "أ"},
                .{"-你", "你"},
                .{"-🌟", "🌟"},
                .{"-☹️",  &[_]u8{ 0xEF, 0xB8, 0x8F }},       // second codepoint at ☹️ (modifier)
                .{"-👨‍🏭", &[_]u8{ 0xF0, 0x9F, 0x8F, 0xAD }}, // third codepoint at 👨‍🏭 (emojie)
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected = test_case[1];

                try exceptSlice(u8, expected, unicode.getLastCodepointSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, unicode.getLastCodepointSlice(""));
        }

        test "unicode.getFirstGraphemeClusterSlice" {
            const test_cases = .{
                .{"A-", "A"},
                .{"أ-", "أ"},
                .{"你-", "你"},
                .{"🌟-", "🌟"},
                .{"☹️-", "☹️"},
                .{"👨‍🏭-", "👨‍🏭"},
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected = test_case[1];

                try exceptSlice(u8, expected, unicode.getFirstGraphemeClusterSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, unicode.getFirstGraphemeClusterSlice(""));
        }

        test "unicode.getLastGraphemeClusterSlice" {
            const test_cases = .{
                .{"-A", "A"},
                .{"-أ", "أ"},
                .{"-你", "你"},
                .{"-🌟", "🌟"},
                .{"-☹️", "☹️"},
                .{"-👨‍🏭", "👨‍🏭"},
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected = test_case[1];

                try exceptSlice(u8, expected, unicode.getLastGraphemeClusterSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, unicode.getLastGraphemeClusterSlice(""));
        }

        test "unicode.getRealPosition" {
            const _Str = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");

            const _Cases = .{
                .{ 0, 0 },
                .{ 1, 1 },
                .{ 2, 2 },
                .{ 3, 3 },
                .{ 4, 4 },
                .{ 5, 5 },
                .{ 6, 6 },
                .{ 7, 17 },
                .{ 18, 18 },
            };

            inline for (_Cases) |__case| {
                try expectEqual(__case[1], try unicode.getRealPosition(&_Str, __case[0]));
            }

            try expectError(error.OutOfRange, unicode.getRealPosition(&_Str, 19));
        }

        test "unicode.getVisualPosition" {
            const _Str = try chars.initWithSlice(u8, 18, "Hello 👨‍🏭!");

            const _Cases = .{
                .{ 0, 0 },
                .{ 1, 1 },
                .{ 2, 2 },
                .{ 3, 3 },
                .{ 4, 4 },
                .{ 5, 5 },
                .{ 6, 6 },
                .{ 7, 7 },
                .{ 18, 8 },
            };

            inline for (_Cases) |__case| {
                try expectEqual(__case[1], try unicode.getVisualPosition(&_Str, __case[0]));
            }

            try expectError(error.OutOfRange, unicode.getVisualPosition(&_Str, 19));
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝