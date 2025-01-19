// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("../../bytes/bytes.zig");
    const utils = @import("./utils.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── COUNT ───────────────────────────┐

        test "utils.lengthOfStartByte" {
            const test_cases = .{
                .{"A", 1},
                .{"أ", 2},
                .{"你", 3}, 
                .{"🌟", 4}, 
                .{"☹️", 6}, 
                .{"👨‍🏭", 11},
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected_length = test_case[1];
                
                try expectEqual(expected_length, try utils.lengthOfFirstGrapheme(input));
                try expectEqual(expected_length, try utils.lengthOfFirstGrapheme(input ++ "-"));
            }

            // invalid value cases
            const invalid_utf8 = &[_]u8{0x80, 0x81, 0x82};
            try expectError(error.InvalidValue, utils.lengthOfFirstGrapheme(invalid_utf8));
        }

        test "utils.lengthOfFirst #2" {
            const test_cases = .{
                .{"AA", 1},
                .{"أأ", 2},
                .{"🌟🌟", 4},
                .{"☹️☹️", 6},
                .{"👨‍🏭👨‍🏭", 11},
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected_length = test_case[1];

                try expectEqual(expected_length, try utils.lengthOfFirstGrapheme(input[0..]));
                try expectEqual(expected_length, try utils.lengthOfFirstGrapheme(input[expected_length..]));
            }
        }

        test "utils.lengthOfFirstGrapheme #3" {
            const test_cases = .{
                .{"A-", 1},
                .{"أ-", 2},
                .{"你-", 3},
                .{"🌟-", 4},
                .{"☹️-", 6},
                .{"👨‍🏭-", 11},
            };

            inline for (test_cases) |test_case| {
                const input = test_case[0];
                const expected_length = test_case[1];

                try expectEqual(expected_length, try utils.lengthOfFirstGrapheme(input));
            }

            // invalid value cases
            const invalid_utf8 = &[_]u8{0x80, 0x81, 0x82};
            try expectError(error.InvalidValue, utils.lengthOfFirstGrapheme(invalid_utf8));
        }


        test "utils.getRealPosition edge cases" {
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

        test "utils.getVisualPosition edge cases" {
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