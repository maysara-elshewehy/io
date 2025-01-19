// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../utf8/utf8.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌─────────────────────── Initialization ───────────────────────┐

        /// Initializes an array of bytes of a given `size` and `value`,
        /// terminated with a null byte **if the `array_size` is greater than the length of `value`**.
        /// - `initError.ZeroSize` **_if the length of `value` is 0._**
        /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
        pub fn init(comptime size: usize, value: []const u8) initError![size]u8 {
            if(size == 0 or value.len == 0) return initError.ZeroSize;
            if(value.len > size) return initError.OutOfRange;

            var result: [size]u8 = undefined;
            @memcpy(result[0..value.len], value[0..value.len]);

            if(value.len < size) result[value.len] = 0;

            return result;
        }
        pub const initError = initCapacityError || error { OutOfRange };

        /// Initializes an array of bytes of a given `size`, filled with null bytes.
        /// - `initCapacityError.ZeroSize` **_if the `size` is `0`._**
        pub fn initCapacity(comptime array_size: usize) initCapacityError![array_size]u8 {
            return if(array_size == 0) initCapacityError.ZeroSize else .{0} ** array_size;
        }
        pub const initCapacityError = error { ZeroSize };

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        /// Finds the **real position** of the **first** occurrence of `value`. 
        pub fn find(dest: []const u8, target: []const u8) ?usize {
            return std.mem.indexOf(u8, dest, target);
        }

        /// Finds the **visual position** of the **first** occurrence of `value`.
        pub fn findVisual(dest: []const u8, target: []const u8) !?usize {
            if(find(dest, target)) |pos| return utf8.utils.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Finds the **real position** of the **last** occurrence of `value`.
        pub fn rfind(dest: []const u8, target: []const u8) ?usize {
            return std.mem.lastIndexOf(u8, dest, target);
        }

        /// Finds the **visual position** of the **last** occurrence of `value`.
        pub fn rfindVisual(dest: []const u8, target: []const u8) ?usize {
            if(rfind(dest, target)) |pos| return utf8.utils.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Returns `true` **if `dest` contains `target`**.
        pub fn includes(dest: []const u8, target: []const u8) bool {
            if(find(dest, target)) |_| { return true; }
            return false;
        }

        /// Returns `true` **if `dest` starts with `target`**.
        pub fn startsWith(dest: []const u8, target: []const u8) bool {
            const i = std.mem.indexOf(u8, dest[0..dest.len], target);
            return i == 0;
        }

        /// Returns `true` **if `dest` ends with `target`**.
        pub fn endsWith(dest: []const u8, target: []const u8) bool {
            const i = std.mem.lastIndexOf(u8, dest[0..dest.len], target);
            return i == (dest.len-target.len);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        /// Converts all (ASCII) letters to lowercase.
        pub fn toLower(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = std.unicode.utf8ByteSequenceLength(value[i]) catch 1;
                if (first_byte_size == 1) value[i] = std.ascii.toLower(value[i]);
                i += first_byte_size;
            }
        }

        /// Converts all (ASCII) letters to uppercase.
        pub fn toUpper(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = std.unicode.utf8ByteSequenceLength(value[i]) catch 1;
                if (first_byte_size == 1) value[i] = std.ascii.toUpper(value[i]);
                i += first_byte_size;
            }
        }

        // Converts all (ASCII) letters to titlecase.
        pub fn toTitle(value: []u8) void {
            if (value.len == 0) return;

            var i: usize = 0;
            var is_new_word: bool = true;

            while (i < value.len) {
                const char = value[i];

                if (std.ascii.isWhitespace(char)) {
                    is_new_word = true;
                    i += 1;
                    continue;
                }

                if (is_new_word) {
                    value[i] = std.ascii.toUpper(char);
                    is_new_word = false;
                } else value[i] = std.ascii.toLower(char);

                i += 1;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Check ───────────────────────────┐

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

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Count ───────────────────────────┐

        /// Returns the total number of written bytes, stopping at the first null byte.
        pub fn countWritten(value: []const u8) usize {
            for(0..value.len) |i| if(value[i] == 0) return i;
            return value.len;
        }

        /// Returns the total number of visual characters, stopping at the first null byte.
        /// - `countVisualError.InvalidValue` **_if the `value` is not a valid utf-8 format._**
        pub fn countVisual(value: []const u8) countVisualError!usize {
            const len = countWritten(value);
            var count : usize = 0;
            var i : usize = 0;
            while (i < len) {
                i += utf8.utils.lengthOfFirstGrapheme(value[i..len]) catch return countVisualError.InvalidValue;
                count += 1;
            }
            return count;
        }
        pub const countVisualError = error { InvalidValue };

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        /// Returns a slice containing only the written part.
        pub fn writtenSlice(value: []const u8) []const u8 {
            return value[0..countWritten(value)];
        }

        /// Converts the given value to an array of bytes.
        /// - `toBytesError.InvalidValue` **_if the value is invalid._**
        /// 
        /// TODO: remove it.
        pub inline fn toBytes(value: anytype) toBytesError![]const u8 {
            if(isByte(value)) { return &[_]u8 {value}; }
            else if(isBytes(value)) { return value[0..]; }
            else return toBytesError.InvalidValue;
        }
        pub const toBytesError = error { InvalidValue };

    // └──────────────────────────────────────────────────────────────┘
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝