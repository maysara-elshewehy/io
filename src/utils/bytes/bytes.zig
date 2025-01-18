// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌──────────────────────────── INIT ────────────────────────────┐

        /// Initializes an array of bytes of a given `size`, filled with null bytes.
        /// - `initArrayError.ZeroSize` **_if the `size` is `0`._**
        pub fn initArray(comptime array_size: usize) initArrayError![array_size]u8 {
            return if(array_size == 0) initArrayError.ZeroSize else .{0} ** array_size;
        }
        pub const initArrayError = error { ZeroSize };

        /// Initializes an array of bytes of a given `size` and `value`,
        /// terminated with a null byte **if the `array_size` is greater than the length of `value`**.
        /// - `initArrayWithError.ZeroSize` **_if the length of `value` is 0._**
        /// - `initArrayWithError.OutOfRange` **_if the length of `value` exceeds `size`._**
        pub fn initArrayWith(comptime size: usize, value: []const u8) initArrayWithError![size]u8 {
            if(size == 0 or value.len == 0) return initArrayWithError.ZeroSize;
            if(value.len > size) return initArrayWithError.OutOfRange;

            var result: [size]u8 = undefined;
            @memcpy(result[0..value.len], value[0..value.len]);

            if(value.len < size) result[value.len] = 0;

            return result;
        }
        pub const initArrayWithError = error { ZeroSize, OutOfRange };

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── UTILS ───────────────────────────┐

        /// Returns `true` **if the value is a valid byte**.
        pub inline fn isByte(value: anytype) bool {
            const value_type = @TypeOf(value);
            return value_type == u8
                or (value_type == comptime_int and value >= 0 and value <= 255);
        }

        /// Returns `true` **if the value is a valid array of bytes**.
        pub inline fn isBytes(value: anytype) bool {
            const value_type = @TypeOf(value);

            // Direct match for known byte types
            if (value_type == []u8 or value_type == []const u8) return true;

            const type_info = @typeInfo(value_type);

            // Check if it's a pointer to an array of bytes
            if (type_info == .pointer) {
                const child_type_info = @typeInfo(type_info.pointer.child);
                if (child_type_info == .array) return child_type_info.array.child == u8;
            }

            // Check if it's a direct array of bytes
            if (type_info == .array) return type_info.array.child == u8;

            return false;
        }

        /// Converts the given value to an array of bytes.
        /// - `toBytesError.InvalidValue` **_if the value is invalid._**
        pub inline fn toBytes(value: anytype) toBytesError![]const u8 {
            if(isByte(value)) { return &[_]u8 {value}; }
            else if(isBytes(value)) { return value[0..]; }
            else return toBytesError.InvalidValue;
        }
        pub const toBytesError = error { invalidValue };

    // └──────────────────────────────────────────────────────────────┘
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝