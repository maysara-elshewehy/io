// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std                   = @import("std");
    const unicode               = @import("../unicode/unicode.zig");
    pub const Allocator         = std.mem.Allocator;
    pub const CapacityError     = error { OutOfMemory };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // All the functions here are designed to be used internally across a lot of other modules and its functions,
    // so most of the functions here are `inline` as expected and required,
    // and this module can be considered internal only, so to speak.
    // I have reasons for this that may not be obvious in the current form of the project.


    // ┌─────────────────────── Initialization ───────────────────────┐

        pub const initError = error { OutOfRange };

        /// Initializes an array of bytes of a given `size`, filled with null bytes.
        pub inline fn initWithCapacity(comptime initial_size: usize) [initial_size]u8 {
            return .{0} ** initial_size;
        }

        /// Initializes an array of bytes of a given `size` and `value`,
        /// terminated with a null byte **if the `array_size` is greater than the length of `value`**.
        /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
        pub inline fn initWithSlice(comptime initial_size: usize, initial_value: []const u8) initError![initial_size]u8 {
            if(initial_value.len > initial_size) return initError.OutOfRange;
            if(initial_size == 0 or initial_value.len == 0) return initWithCapacity(initial_size);

            return initWithSliceAssumeCapacity(initial_size, initial_value);
        }

        /// Initializes an array of bytes of a given `size` and `value`,
        pub inline fn initWithSliceAssumeCapacity(comptime initial_size: usize, initial_value: []const u8) [initial_size]u8 {
            var result: [initial_size]u8 = undefined;
            @memcpy(result[0..initial_value.len], initial_value[0..initial_value.len]);
            if(initial_value.len < initial_size) result[initial_value.len] = 0;
            return result;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        pub const InsertError = error { OutOfRange, OutOfMemory };

        /// Inserts a `slice` into `dest` at the specified `position` by **real position**.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        pub inline fn insertSlice(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) InsertError!void {

            if (slice.len == 0) return;
            if (pos > dest_wlen) return InsertError.OutOfRange;
            if (dest_wlen+slice.len > dest.len) return InsertError.OutOfMemory;

            insertSliceAssumeCapacity(dest, slice, dest_wlen, pos);
        }
        pub inline fn insertSliceAssumeCapacity(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) void {
            const shiftLen = slice.len;
            std.mem.copyBackwards(u8, dest[pos + shiftLen..], dest[pos..dest_wlen]);
            @memcpy(dest[pos..pos + shiftLen], slice);
        }

        /// Inserts a `byte` into `dest` at the specified `position` by **real position**.
        /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of `dest`._**
        /// - `insertError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        pub inline fn insertByte(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) InsertError!void {
            if (pos > dest_wlen) return InsertError.OutOfRange;
            if (dest_wlen+1 > dest.len) return InsertError.OutOfMemory;

            insertByteAssumeCapacity(dest, byte, dest_wlen, pos);
        }
        pub inline fn insertByteAssumeCapacity(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) void {
            std.mem.copyBackwards(u8, dest[pos+1..], dest[pos..dest_wlen]);
            dest[pos] = byte;
        }

        /// Inserts a `slice` into `dest` at the specified `visual position`.
        /// - `visualInsertSliceError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        /// - `visualInsertSliceError.OutOfRange` **_if the `pos` is invalid or greater than `dest_wlen`._**
        pub inline fn visualInsertSlice(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) InsertError!void {
            const real_pos = unicode.getRealPosition(dest[0..dest_wlen], pos) catch return InsertError.OutOfRange;
            return insertSlice(dest, slice, dest_wlen, real_pos);
        }

        /// Inserts a `byte` into `dest` at the specified `visual position`.
        /// - `visualInsertSliceError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        /// - `visualInsertSliceError.OutOfRange` **_if the `pos` is invalid or greater than `dest_wlen`._**
        pub inline fn visualInsertByte(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) InsertError!void {
            const real_pos = unicode.getRealPosition(dest[0..dest_wlen], pos) catch return InsertError.OutOfRange;
            return insertByte(dest, byte, dest_wlen, real_pos);
        }

        /// Appends a `slice` into `dest`.
        /// - `insertError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        pub inline fn appendSlice(dest: []u8, slice: []const u8, dest_wlen: usize) InsertError!void {
            if (slice.len == 0) return;
            if (dest_wlen+slice.len > dest.len) return InsertError.OutOfMemory;

            appendSliceAssumeCapacity(dest, slice, dest_wlen);
        }
        pub inline fn appendSliceAssumeCapacity(dest: []u8, slice: []const u8, dest_wlen: usize) void {
            const old_len = dest_wlen;
            const new_len = old_len + slice.len;
            std.debug.assert(new_len <= dest.len);
            @memcpy(dest[old_len..new_len], slice);
        }

        /// Appends a `byte` into `dest`.
        /// - `insertError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        pub inline fn appendByte(dest: []u8, byte: u8, dest_wlen: usize) InsertError!void {
            if (dest_wlen+1 > dest.len) return InsertError.OutOfMemory;

            appendByteAssumeCapacity(dest, byte, dest_wlen);
        }
        pub inline fn appendByteAssumeCapacity(dest: []u8, byte: u8, dest_wlen: usize) void {
            dest[dest_wlen] = byte;
        }

        /// Prepends a `slice` into `dest`.
        /// - `insertError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        pub inline fn prepend(dest: []u8, slice: []const u8, dest_wlen: usize) InsertError!void {
            try insertSlice(dest, slice, dest_wlen, 0);
        }
        pub inline fn prependAssumeCapacity(dest: []u8, slice: []const u8, dest_wlen: usize) void {
            insertSliceAssumeCapacity(dest, slice, dest_wlen, 0);
        }

        /// Prepends a `byte` into `dest`.
        /// - `insertError.OutOfMemory` **_if the insertion exceeds the bounds of `dest`._**
        pub inline fn prependByte(dest: []u8, byte: u8, dest_wlen: usize) InsertError!void {
            try insertByte(dest, byte, dest_wlen, 0);
        }
        pub inline fn prependByteAssumeCapacity(dest: []u8, byte: u8, dest_wlen: usize) void {
            insertByteAssumeCapacity(dest, byte, dest_wlen, 0);
        }

        pub inline fn addManyAtAssumeCapacity(dest: []u8, dest_wlen: usize, index: usize, count: usize) []u8 {
            const new_len = dest_wlen + count;
            std.debug.assert(dest.len >= new_len);
            const to_move = dest[index..];
            std.mem.copyBackwards(u8, dest[index + count ..], to_move);
            const result = dest[index..][0..count];
            @memset(result, undefined);
            return result;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        pub const removeIndexError = error { OutOfRange };
        pub const removeVisualIndexError = removeIndexError || error { InvalidPosition };

        /// Removes a byte from the `dest`.
        /// - `removeIndexError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        pub inline fn removeIndex(dest: []u8, dest_wlen: usize, pos: usize) removeIndexError!void {
            if (pos > dest_wlen) return removeIndexError.OutOfRange;
            return removeUnchecked(dest, dest_wlen, pos);
        }
        pub inline fn removeUnchecked(dest: []u8, dest_wlen: usize, pos: usize) void {
            std.mem.copyForwards(u8, dest[pos..], dest[pos+1..dest_wlen]);
        }

        /// Removes a byte from the `dest` by the `visual position`.
        /// - `removeVisualIndexError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualIndexError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisualIndex(dest: []u8, dest_wlen: usize, pos: usize) removeVisualIndexError![]const u8 {
            if (pos > dest_wlen) return removeVisualIndexError.OutOfRange;
            const real_pos = unicode.getRealPosition(dest[0..dest_wlen], pos) catch return removeVisualIndexError.InvalidPosition;
            if(unicode.getFirstGraphemeClusterSlice(dest[real_pos..dest_wlen])) |gc| {
                removeRangeUnchecked(dest, dest_wlen, real_pos, gc.len);
                return gc;
            }

            return removeVisualIndexError.InvalidPosition;
        }

        /// Removes a `range` of bytes from the `dest`.
        /// - `removeIndexError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeIndexError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        pub inline fn removeRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeIndexError!void {
            if (pos+len > dest_wlen) return removeIndexError.OutOfRange;
            return removeRangeUnchecked(dest, dest_wlen, pos, len);
        }
        pub inline fn removeRangeUnchecked(dest: []u8, dest_wlen: usize, pos: usize, len: usize) void {
            std.mem.copyForwards(u8, dest[pos..], dest[pos+len..dest_wlen]);
        }

        /// Removes a `range` of bytes from the `dest` by the `visual position`.
        /// - `removeVisualIndexError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualIndexError.OutOfRange` **_if the `pos` is greater than `dest_wlen`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisualRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeVisualIndexError![]const u8 {
            if (pos+len > dest_wlen) return removeVisualIndexError.OutOfRange;
            const real_pos = unicode.getRealPosition(dest[0..dest_wlen], pos) catch return removeVisualIndexError.InvalidPosition;

            var real_len : usize = 0;
            var unicode_iterator = unicode.Iterator.init(dest[real_pos..dest_wlen]) catch return removeVisualIndexError.InvalidPosition;
            for(0..len) |_| {
                if(unicode_iterator.nextGraphemeCluster()) |gc| real_len += gc.len
                else return removeVisualIndexError.InvalidPosition;
            }

            if(unicode.getFirstGraphemeClusterSlice(dest[real_pos..dest_wlen])) |gc| {
                removeRangeUnchecked(dest, dest_wlen, real_pos, real_len);
                return gc;
            }

            return removeVisualIndexError.InvalidPosition;
        }

        // The behavior of this `pop` function is different
        // from its counterparts in this library.
        // Here we are dealing directly with the array,
        // not with a data type dedicated to containing the array,
        // so it should be left as is or considered an internal function only.
        //
        /// Returns the length of the last grapheme cluster at the `dest`.
        pub inline fn pop(dest: []const u8) usize {
            const len = (unicode.getLastGraphemeClusterSlice(dest[0..]) orelse return 0).len;
            return len;
        }

        /// Removes the first grapheme cluster at the `dest`,
        /// Returns the number of removed bytes.
        pub inline fn shift(dest: []u8) usize {
            const len = (unicode.getFirstGraphemeClusterSlice(dest[0..]) orelse return 0).len;
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
        pub inline fn findVisual(dest: []const u8, target: []const u8) ?usize {
            if(find(dest, target)) |pos| return unicode.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Finds the `position` of the **last** occurrence of `target`.
        pub inline fn findLast(dest: []const u8, target: []const u8) ?usize {
            return std.mem.lastIndexOf(u8, dest, target);
        }

        /// Finds the `visual position` of the **last** occurrence of `target`.
        pub inline fn findLastVisual(dest: []const u8, target: []const u8) ?usize {
            if(findLast(dest, target)) |pos| return unicode.getVisualPosition(dest, pos) catch null;
            return null;
        }

        /// Returns `true` **if `dest` contains `target`**.
        pub inline fn includes(dest: []const u8, target: []const u8) bool {
            if(find(dest, target)) |_| return true;
            return false;
        }

        /// Returns `true` **if `dest` starts with `target`**.
        pub inline fn startsWith(dest: []const u8, target: []const u8) bool {
            return std.mem.startsWith(u8, dest, target);
        }

        /// Returns `true` **if `dest` ends with `target`**.
        pub inline fn endsWith(dest: []const u8, target: []const u8) bool {
            return std.mem.endsWith(u8, dest, target);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        /// Converts all (ASCII) letters to lowercase.
        pub inline fn toLower(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = unicode.getLengthOfStartByte(value[i]) catch 1;
                if (first_byte_size == 1) value[i] = std.ascii.toLower(value[i]);
                i += first_byte_size;
            }
        }

        /// Converts all (ASCII) letters to uppercase.
        pub inline fn toUpper(value: []u8) void {
            var i: usize = 0;
            while (i < value.len) {
                const first_byte_size = unicode.getLengthOfStartByte(value[i]) catch 1;
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

        /// Reverses the order of the bytes.
        pub inline fn reverse(value: []u8) void {
            std.mem.reverse(u8, value);
        }

        /// Reverses the order of the characters in the `Self` instance (considering Unicode).
        pub inline fn reverseUnicode(dist: []u8, dist_wlen: usize, temp: []const u8) void {
            var unicode_iterator = unicode.Iterator.initUnchecked(temp[0..]);
            var i: usize = dist_wlen;

            while (unicode_iterator.nextGraphemeCluster()) |gc| {
                i -= gc.len;
                @memcpy(dist[i..i + gc.len], gc);
                if (i == 0) break; // to avoid underflow.
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

        pub const countVisualError = error { InvalidValue };


        /// Returns the total number of written bytes, stopping at the first null byte.
        pub inline fn countWritten(value: []const u8) usize {
            for(0..value.len) |i| if(value[i] == 0) return i;
            return value.len;
        }

        /// Returns the total number of visual characters.
        /// - `countVisualError.InvalidValue` **_if the `value` is not a valid unicode format._**
        pub inline fn countVisual(value: []const u8) countVisualError!usize {
            const len = countWritten(value);
            var count : usize = 0;
            var i : usize = 0;
            while (i < len) {
                i += (unicode.getFirstGraphemeClusterSlice(value[i..len]) orelse return countVisualError.InvalidValue).len;
                count += 1;
            }
            return count;
        }

        /// Returns a slice containing only the written part.
        pub inline fn writtenSlice(value: []const u8) []const u8 {
            return value[0..countWritten(value)];
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Split ───────────────────────────┐

        /// Splits the written portion of the string into substrings separated by the delimiter,
        /// returning the substring at the specified index.
        pub inline fn split(dest: []const u8, dest_wlen: usize, delimiters: []const u8, index: usize) ?[]const u8 {
            var current_index: usize = 0;
            var start: usize = 0;
            var i: usize = 0;

            while (i < dest_wlen) {
                const slice = dest[i..dest_wlen];
                if (unicode.getFirstGraphemeClusterSlice(slice)) |gc| {
                    const gc_len = gc.len;
                    const gc_bytes = dest[i..@min(i + gc_len, dest_wlen)];

                    // Check for delimiter match
                    if (gc_len == delimiters.len and i + gc_len <= dest_wlen and std.mem.eql(u8, delimiters, gc_bytes)) {
                        if (current_index == index) return dest[start..i];
                        current_index += 1;
                        start = i + gc_len;
                        i = start;
                    } else i += gc_len;
                } else {
                    // Handle invalid unicode
                    if (delimiters.len == 1 and i < dest_wlen and dest[i] == delimiters[0]) {
                        if (current_index == index) return dest[start..i];
                        current_index += 1;
                        start = i + 1;
                        i = start;
                    } else i += 1;
                }
            }

            // Handle final segment
            if (current_index == index and start <= dest_wlen) return dest[start..dest_wlen];

            return null;
        }

        /// Splits the written portion of the string into all substrings separated by the delimiter,
        /// returning an array of slices. Caller must free the returned memory.
        /// `include_empty` controls whether empty strings are included in the result.
        pub inline fn splitAll(allocator: Allocator, dest: []const u8, dest_wlen: usize, delimiters: []const u8, include_empty: bool) Allocator.Error![]const []const u8 {
            var parts = std.ArrayList([]const u8).init(allocator);
            errdefer parts.deinit();

            var i: usize = 0;
            while (split(dest, dest_wlen, delimiters, i)) |slice| : (i += 1) {
                // Include empty strings based on the flag
                if (include_empty or slice.len > 0) try parts.append(slice);
            }

            // Handle case where no splits occurred but content exists
            if (parts.items.len == 0 and dest_wlen > 0) try parts.append(dest[0..dest_wlen]);

            return parts.toOwnedSlice();
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        pub const replaceError = error{ OutOfRange };

        /// Replaces all occurrence of a character with another.
        pub inline fn replaceAllChars(dest: []u8, match: u8, replacement: u8) void {
            std.mem.replaceScalar(u8, dest, match, replacement);
        }

        /// Replaces all occurrences of a slice with another.
        pub inline fn replaceAllSlices(dest: [] u8, dest_wlen: usize, match: []const u8, replacement: []const u8) replaceError!usize {
            var res : usize = 0;
            while(find(dest[0..dest_wlen], match)) |find_res| {
                try replaceRange(dest, dest_wlen, find_res, match.len, replacement);
                res += 1;
            }

            return res;
        }

        /// Replaces a range of bytes with another.
        pub inline fn replaceRange(dest: []u8, dest_wlen: usize, start: usize, len: usize, replacement: []const u8) replaceError!void {
            const after_range = start + len;
            const range = dest[start..after_range];
            if (range.len < replacement.len) {
                const first = replacement[0..range.len];
                const rest = replacement[range.len..];
                @memcpy(range[0..first.len], first);
                insertSlice(dest, rest, dest_wlen, after_range) catch return replaceError.OutOfRange;
            } else {
                replaceRangeAssumeCapacity(dest, dest_wlen, start, len, replacement);
            }
        }

        pub inline fn replaceRangeAssumeCapacity(dest: []u8, dest_wlen: usize, start: usize, len: usize, replacement: []const u8) void {
            const after_range = start + len;
            const range = dest[start..after_range];

            if (range.len == replacement.len)
                @memcpy(range[0..replacement.len], replacement)
            else if (range.len < replacement.len) {
                const first = replacement[0..range.len];
                const rest = replacement[range.len..];
                @memcpy(range[0..first.len], first);
                const dst = addManyAtAssumeCapacity(dest, dest_wlen, after_range, rest.len);
                @memcpy(dst, rest);
            } else {
                const extra = range.len - replacement.len;
                @memcpy(range[0..replacement.len], replacement);
                std.mem.copyForwards( u8, dest[after_range - extra ..], dest[after_range..], );
                @memset(dest[dest_wlen - extra ..], undefined);
            }
        }

        /// Replaces a visual range of bytes with another.
        pub inline fn replaceVisualRange(dest: []u8, dest_wlen: usize, start: usize, len: usize, replacement: []const u8) replaceError!void {
            var new_len : usize = 0;
            var iter = unicode.Iterator.init(dest[start..dest_wlen]) catch unreachable;
            var i : usize = 0;

            while(iter.nextGraphemeCluster()) |gc| {
                new_len += gc.len;
                i += 1;
                if(i == len) break;
            }

            try replaceRange(dest, dest_wlen, start, new_len, replacement);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ───────────────────────────┐

        /// Returns true if the `a` is equal to `b`.
        pub inline fn equals(a: []const u8, b: []const u8) bool {
            if(a.len != b.len) return false;
            if(a.len == 0) return true;

            return std.mem.eql(u8, a, b);
        }

        /// Returns true if the `value` is empty.
        pub inline fn isEmpty(value: []const u8) bool {
            return countWritten(value) == 0;
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝