// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("./bytes.zig");

    const assert = std.debug.assert;
    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        test"initCapacity" {
            // Success Cases.
            {
                const array = try Bytes.initCapacity(1);
                try expect(array.len == 1);
                try expect(array[0] == 0);

                const array2 = try Bytes.initCapacity(2);
                try expect(array2.len == 2);
                try expect(array2[0] == 0);
                try expect(array2[1] == 0);
            }

            // Failure cases.
            try expectError(error.ZeroSize, Bytes.initCapacity(0)); // Invalid size.
        }

        test"init" {
            // Success Cases.
            {
                // Array of bytes.
                const multi_elem_arr = try Bytes.init(3, "012");
                try expect(multi_elem_arr.len == 3);
                for(0..3) |i| try expect(multi_elem_arr[i] == "012"[i]);

                // Array of bytes (with unfilled elements, automatically terminated with null byte).
                const multi_elem_arr2 = try Bytes.init(4, "012");
                try expect(multi_elem_arr2.len == 4);
                for(0..4) |i| try expect(multi_elem_arr2[i] == (if(i == 3) 0 else "012"[i]));
            }

            // Failure cases.
            try expectError(error.ZeroSize, Bytes.init(0, ""));       // Invalid size
            try expectError(error.OutOfRange, Bytes.init(1, "AB"));   // Out of range
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        test "Bytes.find" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected  :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 2 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 17 },
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, Bytes.find(&array, c.value));
            }
        }

        test "Bytes.findVisual" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 2 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 7 },
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, Bytes.findVisual(&array, c.value));
            }
        }

        test "Bytes.rfind" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value : []const u8 = undefined, expected :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 3 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 17},
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, Bytes.rfind(&array, c.value));
            }
        }

        test "Bytes.rfindVisual" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            const Cases = struct { value  : []const u8 = undefined, expected  :? usize = null, };
            const cases = &[_]Cases{
                .{ .value  = "H", .expected = 0 },
                .{ .value  = "e", .expected = 1 },
                .{ .value  = "l", .expected = 3 },
                .{ .value  = "o", .expected = 4 },
                .{ .value  = " ", .expected = 5 },
                .{ .value  = "👨‍🏭", .expected = 6 },
                .{ .value  = "!", .expected = 7},
                .{ .value  = "@", .expected = null },
            };

            for(cases) |c| {
                try expectEqual(c.expected, Bytes.rfindVisual(&array, c.value));
            }
        }

        test "Bytes.includes" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            try expect(Bytes.includes(&array, "H"));
            try expect(Bytes.includes(&array, "e"));
            try expect(Bytes.includes(&array, "l"));
            try expect(Bytes.includes(&array, "o"));
            try expect(Bytes.includes(&array, " "));
            try expect(Bytes.includes(&array, "👨‍🏭"));
            try expect(Bytes.includes(&array, "!"));
            try expect(!Bytes.includes(&array, "@"));
        }

        test "Bytes.startsWith" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            try expect(Bytes.startsWith(&array, "H"));
            try expect(!Bytes.startsWith(&array, "👨‍🏭"));
        }

        test "Bytes.endsWith" {
            const array = try Bytes.init(18, "Hello 👨‍🏭!");
            try expect(Bytes.endsWith(&array, "!"));
            try expect(!Bytes.endsWith(&array, "👨‍🏭"));
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        test "toLower" {
            var array = try Bytes.init(18, "HeLLo 👨‍🏭!");
            Bytes.toLower(&array);
            try expectStrings("hello 👨‍🏭!", &array); 
        }

        test "toUpper" {
            var array = try Bytes.init(18, "HeLLo 👨‍🏭!");
            Bytes.toUpper(&array);
            try expectStrings("HELLO 👨‍🏭!", &array); 
        }

        test "toTitle" {
            var array = try Bytes.init(18, "heLLo 👨‍🏭!");
            Bytes.toTitle(&array);
            try expectStrings("Hello 👨‍🏭!", &array); 
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        test "countWritten edge cases" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 4 }, .{ "👨‍🏭", 11 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], Bytes.countWritten(c[0]));
            }

            const myArray = try Bytes.init(64, "Hello 👨‍🏭!");
            try expectEqual(18, Bytes.countWritten(&myArray));
        }

        test "countVisual edge cases" {
            const cases = .{ .{ "", 0 }, .{ "A", 1 }, .{ "🌟", 1 }, .{ "👨‍🏭", 1 }, };

            inline for (cases) |c| {
                try expectEqual(c[1], try Bytes.countVisual(c[0]));
            }

            const myArray = try Bytes.init(64, "Hello 👨‍🏭!");
            try expectEqual(8, try Bytes.countVisual(&myArray));
        }

        test "writtenSlice" {
            const myArray = try Bytes.init(64, "Hello 🌍!");
            try expectStrings("Hello 🌍!", Bytes.writtenSlice(&myArray));
        }

        test "isByte" {
            // True cases.
            try expect(Bytes.isByte(0));
            try expect(Bytes.isByte(255));

            // False cases.
            try expect(!Bytes.isByte(256));
            try expect(!Bytes.isByte(-1));
            try expect(!Bytes.isByte(@as(u7, 0)));
        }

        test "isBytes" {
            // True cases.
            try expect(Bytes.isBytes(""));
            try expect(Bytes.isBytes([_]u8{}));
            try expect(Bytes.isBytes(&[_]u8{}));

            try expect(Bytes.isBytes("#"));
            try expect(Bytes.isBytes([_]u8{0}));
            try expect(Bytes.isBytes(&[_]u8{0}));

            // False cases.
            try expect(!Bytes.isBytes(0));  
            try expect(!Bytes.isBytes(1000));  
            try expect(!Bytes.isBytes('c'));  
            try expect(!Bytes.isBytes(true));  
            try expect(!Bytes.isBytes(42));          
            try expect(!Bytes.isBytes(1.5));        
            try expect(!Bytes.isBytes([_]u7{0}));   
            try expect(!Bytes.isBytes(&[_]u7{0}));
        }

        test "toBytes" {
            // Success Cases.
            try expectStrings("", try Bytes.toBytes(""));                   // Empty
            try expectStrings("", try Bytes.toBytes(&[_]u8{}));             // Empty

            try expectStrings(&[_]u8{0}, try Bytes.toBytes(0));             // Number
            try expectStrings("A", try Bytes.toBytes('A'));                 // Letter
            try expectStrings("#", try Bytes.toBytes([_]u8{'#'}));          // Array of bytes
            try expectStrings("#", try Bytes.toBytes(&[_]u8{'#'}));         // Pointer to array

            // Failure cases.
            try expectError(error.InvalidValue, Bytes.toBytes(300));         // Out of `u8` range
            try expectError(error.InvalidValue, Bytes.toBytes(-1));          // Negative number
            try expectError(error.InvalidValue, Bytes.toBytes(1.5));         // Float
            try expectError(error.InvalidValue, Bytes.toBytes(true));        // Boolean
            try expectError(error.InvalidValue, Bytes.toBytes([_]u7{'#'}));  // Array of non-byte type.
            try expectError(error.InvalidValue, Bytes.toBytes(&[_]u7{'#'})); // Pointer to non-byte array.
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝