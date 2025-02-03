// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../../Bytes/Bytes.zig");
    const utils = @import("./utils.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const exceptString = std.testing.expectEqualStrings;
    const exceptSlice = std.testing.expectEqualSlices;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── COUNT ───────────────────────────┐

        test "firstCpSlice" {
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

                try exceptSlice(u8, expected, utils.firstCpSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, utils.firstCpSlice(""));
        }

        test "lastCpSlice" {
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

                try exceptSlice(u8, expected, utils.lastCpSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, utils.lastCpSlice(""));
        }

        test "firstGcSlice" {
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

                try exceptSlice(u8, expected, utils.firstGcSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, utils.firstGcSlice(""));
        }

        test "lastGcSlice" {
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

                try exceptSlice(u8, expected, utils.lastGcSlice(input).?);
            }

            // invalid value cases
            try expectEqual(null, utils.lastGcSlice(""));
        }

        test "getRealPosition" {
            const _Str = try Bytes.init(18, "Hello 👨‍🏭!");

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
                try expectEqual(__case[1], try utils.getRealPosition(&_Str, __case[0]));
            }

            try expectError(error.OutOfRange, utils.getRealPosition(&_Str, 19));
        }

        test "getVisualPosition" {
            const _Str = try Bytes.init(18, "Hello 👨‍🏭!");

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
                try expectEqual(__case[1], try utils.getVisualPosition(&_Str, __case[0]));
            }

            try expectError(error.OutOfRange, utils.getVisualPosition(&_Str, 19));
        }

    // └──────────────────────────────────────────────────────────────┘


// ╚══════════════════════════════════════════════════════════════════════════════════╝