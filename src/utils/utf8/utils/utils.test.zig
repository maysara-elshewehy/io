// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utils = @import("./utils.zig");

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "utils.lengthOfFirst #1" {
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
            
            try expectEqual(expected_length, try utils.lengthOfFirst(input));
            try expectEqual(expected_length, try utils.lengthOfFirst(input ++ "-"));
        }

        // invalid value cases
        const invalid_values = .{ 256, -1, true, 0.5, };

        inline for (invalid_values) |invalid_value| {
            try expectError(error.InvalidValue, utils.lengthOfFirst(invalid_value));
        }
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

            try expectEqual(expected_length, try utils.lengthOfFirst(input[0..]));
            try expectEqual(expected_length, try utils.lengthOfFirst(input[expected_length..]));
        }
    }

    test "utils.lengthOfFirst #3" {
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

            try expectEqual(expected_length, try utils.lengthOfFirst(input));
        }

        // invalid value cases
        const invalid_values = .{ 256, -1, true, 0.5, };

        inline for (invalid_values) |invalid_value| {
            try expectError(error.InvalidValue, utils.lengthOfFirst(invalid_value));
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝