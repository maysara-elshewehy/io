// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const bytes = @import("./bytes.zig");

    const assert = std.debug.assert;
    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌──────────────────────────── INIT ────────────────────────────┐

        test"initArray" {
            // Success Cases.
            {
                const array = try bytes.initArray(1);
                try expect(array.len == 1);
                try expect(array[0] == 0);

                const array2 = try bytes.initArray(2);
                try expect(array2.len == 2);
                try expect(array2[0] == 0);
                try expect(array2[1] == 0);
            }

            // Failure cases.
            try expectError(error.ZeroSize, bytes.initArray(0)); // Invalid size.
        }

        test"initArrayWith" {
            // Success Cases.
            {
                // Array of bytes.
                const multi_elem_arr = try bytes.initArrayWith(3, "012");
                try expect(multi_elem_arr.len == 3);
                for(0..3) |i| try expect(multi_elem_arr[i] == "012"[i]);

                // Array of bytes (with unfilled elements, automatically terminated with null byte).
                const multi_elem_arr2 = try bytes.initArrayWith(4, "012");
                try expect(multi_elem_arr2.len == 4);
                for(0..4) |i| try expect(multi_elem_arr2[i] == (if(i == 3) 0 else "012"[i]));
            }

            // Failure cases.
            try expectError(error.ZeroSize, bytes.initArrayWith(0, ""));       // Invalid size
            try expectError(error.InvalidValue, bytes.initArrayWith(1, true)); // Invalid value (Boolean)
            try expectError(error.InvalidValue, bytes.initArrayWith(1, 256));  // Invalid value (Integer, Exceeds the maximum value)
            try expectError(error.InvalidValue, bytes.initArrayWith(1, -1));   // Invalid value (Integer, Negative number)
            try expectError(error.InvalidValue, bytes.initArrayWith(1, 1.5));  // Invalid value (Float)

        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── UTILS ───────────────────────────┐

        test "isByte" {
            // True cases.
            try expect(bytes.isByte(0));
            try expect(bytes.isByte(255));

            // False cases.
            try expect(!bytes.isByte(256));
            try expect(!bytes.isByte(-1));
            try expect(!bytes.isByte(@as(u7, 0)));
        }

        test "isBytes" {
            // True cases.
            try expect(bytes.isBytes(""));
            try expect(bytes.isBytes([_]u8{}));
            try expect(bytes.isBytes(&[_]u8{}));

            try expect(bytes.isBytes("#"));
            try expect(bytes.isBytes([_]u8{0}));
            try expect(bytes.isBytes(&[_]u8{0}));

            // False cases.
            try expect(!bytes.isBytes(0));  
            try expect(!bytes.isBytes(1000));  
            try expect(!bytes.isBytes('c'));  
            try expect(!bytes.isBytes(true));  
            try expect(!bytes.isBytes(42));          
            try expect(!bytes.isBytes(1.5));        
            try expect(!bytes.isBytes([_]u7{0}));   
            try expect(!bytes.isBytes(&[_]u7{0}));
        }

        test "toBytes" {
            // Success Cases.
            try expectStrings("", try bytes.toBytes(""));                   // Empty
            try expectStrings("", try bytes.toBytes(&[_]u8{}));             // Empty

            try expectStrings(&[_]u8{0}, try bytes.toBytes(0));             // Number
            try expectStrings("A", try bytes.toBytes('A'));                 // Letter
            try expectStrings("#", try bytes.toBytes([_]u8{'#'}));          // Array of bytes
            try expectStrings("#", try bytes.toBytes(&[_]u8{'#'}));         // Pointer to array

            // Failure cases.
            try expectError(error.InvalidValue, bytes.toBytes(300));         // Out of `u8` range
            try expectError(error.InvalidValue, bytes.toBytes(-1));          // Negative number
            try expectError(error.InvalidValue, bytes.toBytes(1.5));         // Float
            try expectError(error.InvalidValue, bytes.toBytes(true));        // Boolean
            try expectError(error.InvalidValue, bytes.toBytes([_]u7{'#'}));  // Array of non-byte type.
            try expectError(error.InvalidValue, bytes.toBytes(&[_]u7{'#'})); // Pointer to non-byte array.
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝