// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../utf8/utf8.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // All the functions here are designed to be used internally across a lot of other modules and its functions,
    // so most of the functions here are `inline` as expected and required,
    // and this module can be considered internal only, so to speak.
    // I have reasons for this that may not be obvious in the current form of the project.


    // ┌─────────────────────── Initialization ───────────────────────┐

        pub const initCapacityError = error { ZeroSize };
        pub const initError = initCapacityError || error { OutOfRange };

        /// Initializes an array of bytes of a given `size` and `value`,
        /// terminated with a null byte **if the `array_size` is greater than the length of `value`**.
        /// - `initError.ZeroSize` **_if the length of `value` is 0._**
        /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
        pub fn init(comptime size: usize, value: []const u8) initError![size]u8 {
            if(size == 0 or value.len == 0) return initError.ZeroSize;
            if(value.len > size) return initError.OutOfRange;

            return unsafeInit(size, value);
        }
        pub inline fn unsafeInit(comptime size: usize, value: []const u8) [size]u8 {
            var result: [size]u8 = undefined;
            @memcpy(result[0..value.len], value[0..value.len]);

            if(value.len < size) result[value.len] = 0;

            return result;
        }

        /// Initializes an array of bytes of a given `size`, filled with null bytes.
        /// - `initCapacityError.ZeroSize` **_if the `size` is `0`._**
        pub fn initCapacity(comptime array_size: usize) initCapacityError![array_size]u8 {
            return if(array_size == 0) initCapacityError.ZeroSize else unsafeInitCapacity(array_size);
        }
        pub inline fn unsafeInitCapacity(comptime array_size: usize) [array_size]u8 {
            return .{0} ** array_size;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        pub const insertError       = error { OutOfRange };
        pub const insertVisualError = error { InvalidPosition } || insertError;

        /// Inserts a `slice` into `dest` at the specified `position` by **real position**.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place **_if `slice` length is greater than 0_.**
        pub inline fn insert(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) insertError!void {

            if (slice.len == 0) return;
            if (pos > dest_wlen) return insertError.OutOfRange;
            if (dest_wlen+slice.len > dest.len) return insertError.OutOfRange;

            unsafeInsert(dest, slice, dest_wlen, pos);
        }
        pub inline fn unsafeInsert(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) void {
            const shiftLen = slice.len;
            std.mem.copyBackwards(u8, dest[pos + shiftLen..], dest[pos..dest_wlen]);
            @memcpy(dest[pos..pos + shiftLen], slice);
        }

        /// Inserts a `byte` into `dest` at the specified `position` by **real position**.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn insertOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) insertError!void {
            if (pos > dest_wlen) return insertError.OutOfRange;
            if (dest_wlen+1 > dest.len) return insertError.OutOfRange;

            unsafeInsertOne(dest, byte, dest_wlen, pos);
        }
        pub inline fn unsafeInsertOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) void {
            std.mem.copyBackwards(u8, dest[pos+1..], dest[pos..dest_wlen]);
            dest[pos] = byte;
        }

        /// Inserts a `slice` into `dest` at the specified `visual position`.
        /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `insertVisualError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place **_if `slice` length is greater than 0_.**
        pub inline fn insertVisual(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) insertVisualError!void {
            const real_pos = utf8.utils.getRealPosition(dest[0..dest_wlen], pos) catch return insertVisualError.InvalidPosition;
            return insert(dest, slice, dest_wlen, real_pos);
        }

        /// Inserts a `byte` into `dest` at the specified `visual position`.
        /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `insertVisualError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn insertVisualOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) insertVisualError!void {
            const real_pos = utf8.utils.getRealPosition(dest[0..dest_wlen], pos) catch return insertVisualError.InvalidPosition;
            return insertOne(dest, byte, dest_wlen, real_pos);
        }

        /// Appends a `slice` into `dest`.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        ///
        /// Modifies `dest` in place **_if `slice` length is greater than 0_.**
        pub inline fn append(dest: []u8, slice: []const u8, dest_wlen: usize) insertError!void {
            if (slice.len == 0) return;
            if (dest_wlen+slice.len > dest.len) return insertError.OutOfRange;

            unsafeAppend(dest, slice, dest_wlen);
        }
        pub inline fn unsafeAppend(dest: []u8, slice: []const u8, dest_wlen: usize) void {
            const old_len = dest_wlen;
            const new_len = old_len + slice.len;
            std.debug.assert(new_len <= dest.len);
            @memcpy(dest[old_len..new_len], slice);
        }

        /// Appends a `byte` into `dest`.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn appendOne(dest: []u8, byte: u8, dest_wlen: usize) insertError!void {
            if (dest_wlen+1 > dest.len) return insertError.OutOfRange;

            unsafeAppendOne(dest, byte, dest_wlen);
        }
        pub inline fn unsafeAppendOne(dest: []u8, byte: u8, dest_wlen: usize) void {
            dest[dest_wlen] = byte;
        }

        /// Prepends a `slice` into `dest`.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        ///
        /// Modifies `dest` in place **_if `slice` length is greater than 0_.**
        pub inline fn prepend(dest: []u8, slice: []const u8, dest_wlen: usize) insertError!void {
            try insert(dest, slice, dest_wlen, 0);
        }
        pub inline fn unsafePrepend(dest: []u8, slice: []const u8, dest_wlen: usize) void {
            unsafeInsert(dest, slice, dest_wlen, 0);
        }

        /// Prepends a `byte` into `dest`.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn prependOne(dest: []u8, byte: u8, dest_wlen: usize) insertError!void {
            try insertOne(dest, byte, dest_wlen, 0);
        }
        pub inline fn unsafePrependOne(dest: []u8, byte: u8, dest_wlen: usize) void {
            unsafeInsertOne(dest, byte, dest_wlen, 0);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        pub const removeError = error { OutOfRange };
        pub const removeVisualError = removeError || error { InvalidPosition };

        /// Removes a byte from the `dest`.
        /// - `removeError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn remove(dest: []u8, dest_wlen: usize, pos: usize) removeError!void {
            if (pos > dest_wlen) return removeError.OutOfRange;
            return unsafeRemove(dest, dest_wlen, pos);
        }
        pub inline fn unsafeRemove(dest: []u8, dest_wlen: usize, pos: usize) void {
            std.mem.copyForwards(u8, dest[pos..], dest[pos+1..dest_wlen]);
        }

        /// Removes a `range` of bytes from the `dest`.
        /// - `removeError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Modifies `dest` in place.
        pub inline fn removeRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeError!void {
            if (pos+len > dest_wlen) return removeError.OutOfRange;
            return unsafeRemoveRange(dest, dest_wlen, pos, len);
        }
        pub inline fn unsafeRemoveRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) void {
            std.mem.copyForwards(u8, dest[pos..], dest[pos+len..dest_wlen]);
        }

        /// Removes a byte from the `dest` by the `visual position`.
        /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisual(dest: []u8, dest_wlen: usize, pos: usize) removeVisualError![]const u8 {
            if (pos > dest_wlen) return removeVisualError.OutOfRange;
            const real_pos = utf8.utils.getRealPosition(dest[0..dest_wlen], pos) catch return removeVisualError.InvalidPosition;
            if(utf8.utils.firstGcSlice(dest[real_pos..dest_wlen])) |gc| {
                unsafeRemoveRange(dest, dest_wlen, real_pos, gc.len);
                return gc;
            }

            return removeVisualError.InvalidPosition;
        }

        /// Removes a `range` of bytes from the `dest` by the `visual position`.
        /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisualRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeVisualError![]const u8 {
            if (pos+len > dest_wlen) return removeVisualError.OutOfRange;
            const real_pos = utf8.utils.getRealPosition(dest[0..dest_wlen], pos) catch return removeVisualError.InvalidPosition;

            var real_len : usize = 0;
            var utf8_iterator = utf8.Iterator.init(dest[real_pos..dest_wlen]) catch return removeVisualError.InvalidPosition;
            for(0..len) |_| {
                if(utf8_iterator.nextGraphemeCluster()) |gc| {
                    real_len += gc.len;
                } else return removeVisualError.InvalidPosition;
            }

            if(utf8.utils.firstGcSlice(dest[real_pos..dest_wlen])) |gc| {
                unsafeRemoveRange(dest, dest_wlen, real_pos, real_len);
                return gc;
            }

            return removeVisualError.InvalidPosition;
        }

        // The behavior of this `pop` function is different
        // from its counterparts in this library.
        // Here we are dealing directly with the array,
        // not with a data type dedicated to containing the array,
        // so it should be left as is or considered an internal function only.
        //
        /// Returns the length of the last grapheme cluster at the `dest`.
        pub inline fn pop(dest: []const u8) usize {
            const len = (utf8.utils.lastGcSlice(dest[0..]) orelse return 0).len;
            return len;
        }

        /// Removes the first grapheme cluster at the `dest`,
        /// Returns the number of removed bytes.
        pub inline fn shift(dest: []u8) usize {
            const len = (utf8.utils.firstGcSlice(dest[0..]) orelse return 0).len;
            std.mem.copyForwards(u8, dest[0..], dest[len..]);
            return len;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        /// Finds the `position` of the **first** occurrence of `target`.
        pub inline fn find(dest: []const u8, target: []const u8) ?usize {
            return std.mem.indexOf(u8, dest, target);
        }

        /// Finds the `visual position` of the **first** occurrence of `target`.
        pub inline fn findVisual(dest: []const u8, target: []const u8) !?usize {
            if(find(dest, target)) |pos| return utf8.utils.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Finds the `position` of the **last** occurrence of `target`.
        pub inline fn rfind(dest: []const u8, target: []const u8) ?usize {
            return std.mem.lastIndexOf(u8, dest, target);
        }

        /// Finds the `visual position` of the **last** occurrence of `target`.
        pub inline fn rfindVisual(dest: []const u8, target: []const u8) ?usize {
            if(rfind(dest, target)) |pos| return utf8.utils.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Returns `true` **if `dest` contains `target`**.
        pub inline fn includes(dest: []const u8, target: []const u8) bool {
            if(find(dest, target)) |_| { return true; }
            return false;
        }

        /// Returns `true` **if `dest` starts with `target`**.
        pub inline fn startsWith(dest: []const u8, target: []const u8) bool {
            const i = std.mem.indexOf(u8, dest[0..dest.len], target);
            return i == 0;
        }

        /// Returns `true` **if `dest` ends with `target`**.
        pub inline fn endsWith(dest: []const u8, target: []const u8) bool {
            const i = std.mem.lastIndexOf(u8, dest[0..dest.len], target);
            return i == (dest.len-target.len);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        /// Converts all (ASCII) letters to lowercase.
        pub inline fn toLower(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = std.unicode.utf8ByteSequenceLength(value[i]) catch 1;
                if (first_byte_size == 1) value[i] = std.ascii.toLower(value[i]);
                i += first_byte_size;
            }
        }

        /// Converts all (ASCII) letters to uppercase.
        pub inline fn toUpper(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = std.unicode.utf8ByteSequenceLength(value[i]) catch 1;
                if (first_byte_size == 1) value[i] = std.ascii.toUpper(value[i]);
                i += first_byte_size;
            }
        }

        // Converts all (ASCII) letters to titlecase.
        pub inline fn toTitle(value: []u8) void {
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
        pub inline fn countWritten(value: []const u8) usize {
            for(0..value.len) |i| if(value[i] == 0) return i;
            return value.len;
        }

        /// Returns the total number of visual characters.
        /// - `countVisualError.InvalidValue` **_if the `value` is not a valid utf-8 format._**
        pub inline fn countVisual(value: []const u8) countVisualError!usize {
            const len = countWritten(value);
            var count : usize = 0;
            var i : usize = 0;
            while (i < len) {
                i += (utf8.utils.firstGcSlice(value[i..len]) orelse return countVisualError.InvalidValue).len;
                count += 1;
            }
            return count;
        }
        pub const countVisualError = error { InvalidValue };

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        /// Returns a slice containing only the written part.
        pub inline fn writtenSlice(value: []const u8) []const u8 {
            return value[0..countWritten(value)];
        }

        /// Reverses the order of the bytes.
        pub inline fn reverse(value: []u8) void {
            std.mem.reverse(u8, value);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝