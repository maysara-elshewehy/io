// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/Self/
//
// Made with ❤️ by Maysara
//
// A lot of code is borrowed from the ZIG standard library
// Thanks to the ZIG developers ❤️
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const std               = @import("std");
    pub const utils             = @import("./utils/utils.zig");
    pub const Allocator         = std.mem.Allocator;
    pub const RangeError        = error { OutOfRange };
    pub const CapacityError     = error { OutOfMemory };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌─────────────────────── Ensure Capacity ──────────────────────┐

        /// Ensures that the array can hold at least `required_capacity` bytes.
        /// If the current capacity is less than `required_capacity`, this function will
        /// modify the array to hold exactly `required_capacity` bytes.
        /// Invalidates element pointers if additional memory is needed.
        pub inline fn ensureCapacity(self: anytype, allocator: Allocator, required_capacity: usize) Allocator.Error!void {
            if (self.m_src.len >= required_capacity) return;

            // Attempt to resize in place to avoid unnecessary memory copies.
            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, required_capacity)) {
                self.m_src.len = required_capacity;
            } else {
                const new_memory = try allocator.alloc(u8, required_capacity);
                @memcpy(new_memory[0..self.m_src.len], self.m_src);
                allocator.free(old_memory);
                self.m_src.ptr = new_memory.ptr;
                self.m_src.len = new_memory.len;
            }
        }

        /// Ensures that there is enough unused capacity in the array to accommodate `extra_capacity`.
        /// If the current capacity is less than the required capacity, this function will modify the array.
        pub inline fn ensureExtraCapacity(self: anytype, allocator: Allocator, extra_capacity: usize) Allocator.Error!void {
            if(self.m_len+extra_capacity <= self.m_src.len) return;
            const n1 = try addOrOom(self.m_src.len, extra_capacity);
            const n2 = growCapacity(self.m_src.len, n1);
            return ensureCapacity(self, allocator, n2);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────── Initialization ───────────────────────┐

        /// Initializes a new `Self` instance with the specified allocator and initial bytes.
        pub inline fn initWithSlice(Self: type, allocator: Allocator, initial_bytes: []const u8) Allocator.Error!Self {
            if (initial_bytes.len == 0) return Self.initWithAllocator(allocator);

            var self = try Self.initWithCapacity(allocator, initial_bytes.len);
            utils.bytes.appendSliceAssumeCapacity(self.allocatedSlice(), initial_bytes, 0);
            self.m_len = utils.bytes.countWritten(initial_bytes);

            return self;
        }

        /// Initializes a new `Self` instance with the specified allocator and initial byte.
        pub inline fn initWithByte(Self: type, allocator: Allocator, initial_byte: u8) Allocator.Error!Self {
            var self = try Self.initWithCapacity(allocator, 1);
            self.m_src.ptr[0] = initial_byte;
            self.m_len = 1;
            return self;
        }

        /// Initializes a new `Self` instance with the specified allocator and initial `Self`.
        pub inline fn initWithSelf(Self: type, allocator: Allocator, initial_self: Self) Allocator.Error!Self {
            var self = try Self.initWithCapacity(allocator, initial_self.len());
            utils.bytes.appendSliceAssumeCapacity(self.allocatedSlice(), initial_self.src(), 0);
            self.m_len = initial_self.len();
            return self;
        }

        /// Initializes a `Self` instance with the specified allocator and formatted string.
        /// - `Allocator.Error` **if the allocator returned an error.**
        pub inline fn initWithFmt(Self: type, allocator: Allocator, comptime fmt: []const u8, args: anytype) Allocator.Error!Self {
            const TI = @typeInfo(@TypeOf(args));
            const new_fmt = if(fmt.len > 0) fmt else if(TI == .@"struct" or TI == .@"array") "{any}" else "{}";
            const new_args = if(fmt.len > 0) args else .{ args };

            const required_size = std.fmt.count(new_fmt, new_args);
            var s = try Self.initWithCapacity(allocator, required_size);
            std.fmt.format(s.writerWithAllocator(allocator), new_fmt, new_args) catch unreachable;
            return s;
        }

        /// Initializes a `Self` instance with the specified allocator and anytype.
        /// the value will be converted to a string if necessary.
        /// - `Allocator.Error` **if the allocator returned an error.**
        pub inline fn init(Self: type, allocator: Allocator, initial_value: anytype) Allocator.Error!Self {
            if(utils.bytes.isByte(initial_value)) return Self.initWithByte(allocator, initial_value)
            else if(utils.bytes.isBytes(initial_value)) return Self.initWithSlice(allocator, initial_value)
            else if(@TypeOf(initial_value) == Self) return Self.initWithSelf(allocator, initial_value)
            else return Self.initWithFmt(allocator, "", initial_value);
        }

        /// Releases all allocated memory associated with the `Self` instance.
        pub inline fn deinit(self: anytype, allocator: Allocator) void {
            if (self.size() > 0) allocator.free(self.allocatedSlice());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Data ─────────────────────────────┐

        /// Returns a character at the specified visual position.
        pub inline fn atVisual(self: anytype, visual_pos: usize) ?[]const u8 {
            if(visual_pos >= self.len()) return null;
            const index = if(visual_pos == 0) 0 else utils.unicode.getRealPosition(self.src(), visual_pos) catch return null;
            const gc = utils.unicode.getFirstGraphemeClusterSlice(self.m_src[index..self.m_len]) orelse return null;
            return self.m_src[index..index+gc.len];
        }

        /// Returns a sub-slice of the `Self`.
        pub inline fn sub(self: anytype, start: usize, end: usize) RangeError![]const u8 {
            if(start > end or end > self.len()) return RangeError.OutOfRange;
            return self.m_src[start..end];
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        pub const InsertError = Allocator.Error || error { OutOfRange };


        /// Inserts a slice into the `Self` instance at the specified position.
        pub inline fn insertSlice(self: anytype, allocator: Allocator, slice: []const u8, position: usize) InsertError!void {
            if(self.m_len == 0 or position == self.m_src.len) return appendSlice(self, allocator, slice);
            if (slice.len == 0) return;
            if (position > self.m_src.len) return InsertError.OutOfRange;
            try insertSliceAssumeCapacity(self, allocator, slice, position);
        }

        /// Inserts a byte into the `Self` instance at the specified position.
        pub inline fn insertByte(self: anytype, allocator: Allocator, byte: u8, position: usize) InsertError!void {
            if(self.m_len == 0 or position == self.m_src.len) return appendByte(self, allocator, byte);
            if (position > self.m_src.len) return InsertError.OutOfRange;
            try insertByteAssumeCapacity(self, allocator, byte, position);
        }

        /// Inserts a slice into the `Self` instance at the specified visual position.
        pub inline fn visualInsertSlice(self: anytype, allocator: Allocator, slice: []const u8, visual_pos: usize) InsertError!void {
            if(self.m_len == 0) return appendSlice(self, allocator, slice);
            if (slice.len == 0) return;
            if (visual_pos > self.m_src.len) return InsertError.OutOfRange;
            const real_pos = utils.unicode.getRealPosition(self.src(), visual_pos) catch return InsertError.OutOfRange;
            try insertSliceAssumeCapacity(self, allocator, slice, real_pos);
        }

        /// Inserts a byte into the `Self` instance at the specified visual position.
        pub inline fn visualInsertByte(self: anytype, allocator: Allocator, byte: u8, visual_pos: usize) InsertError!void {
            if(self.m_len == 0) return appendByte(self, allocator, byte);
            if (visual_pos > self.m_src.len) return InsertError.OutOfRange;
            const real_pos = utils.unicode.getRealPosition(self.src(), visual_pos) catch return InsertError.OutOfRange;
            try insertByteAssumeCapacity(self, allocator, byte, real_pos);
        }

        /// Appends a slice to the end of the `Self` instance.
        pub inline fn appendSlice(self: anytype, allocator: Allocator, slice: []const u8) Allocator.Error!void {
            if (slice.len == 0) return;
            try ensureExtraCapacity(self, allocator, slice.len);
            appendSliceAssumeCapacity(self, slice);
        }

        /// Appends a byte to the end of the `Self` instance.
        pub inline fn appendByte(self: anytype, allocator: Allocator, byte: u8) Allocator.Error!void {
            try ensureExtraCapacity(self, allocator, 1);
            const new_src_ptr = addByteAssumeCapacity(self);
            new_src_ptr.* = byte;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        pub const removeIndexError = utils.bytes.removeIndexError;
        pub const removeVisualIndexError = utils.bytes.removeVisualIndexError;

        /// Removes a byte from the `Self` instance at the specified position.
        pub inline fn removeIndex(self: anytype, pos: usize) removeIndexError!void {
            try utils.bytes.removeIndex(self.m_src[0..self.size()], self.len(), pos);
            self.m_len -= 1;
        }

        /// Removes a byte from the `Self` instance by the specified visual position.
        pub inline fn removeVisualIndex(self: anytype, pos: usize) removeVisualIndexError![]const u8 {
            const removed_slice = try utils.bytes.removeVisualIndex(self.m_src[0..self.size()], self.len(), pos);
            self.m_len -= removed_slice.len;
            return removed_slice;
        }

        /// Removes a range of bytes from the `Self` instance.
        pub inline fn removeRange(self: anytype, pos: usize, len: usize) removeIndexError!void {
            try utils.bytes.removeRange(self.m_src[0..self.size()], self.len(), pos, len);
            self.m_len -= len;
        }

        /// Removes a range of bytes from the `Self` instance by the specified visual position.
        pub inline fn removeVisualRange(self: anytype, pos: usize, len: usize) removeVisualIndexError![]const u8 {
            const removed_slice = try utils.bytes.removeVisualRange(self.m_src[0..self.size()], self.len(), pos, len);
            self.m_len -= removed_slice.len;
            return removed_slice;
        }

        /// Removes the last grapheme cluster from the `Self` instance, Returns the removed slice.
        pub inline fn pop(self: anytype) ?[]const u8 {
            const len = utils.bytes.pop(self.src());
            if (len == 0) return null;

            self.m_len -= len;
            return self.m_src[self.m_len..self.m_len + len];
        }

        /// Removes the first grapheme cluster from the `Self` instance, Returns the number of removed bytes.
        pub inline fn shift(self: anytype) usize {
            const len = utils.bytes.shift(self.m_src[0..self.m_len]);
            self.m_len -= len;
            return len;
        }

        /// Trims whitespace from both ends of the `Self` instance.
        pub inline fn trim(self: anytype) void {
            trimStart(self);
            trimEnd(self);
        }

        /// Trims whitespace from the start of the `Self` instance.
        pub inline fn trimStart(self: anytype) void {
            var n : usize = 0;
            for(0..self.len()) |i| {
                if(self.m_src[i] != ' ') break;
                n += 1;
            }
            if(n > 0) {
                std.mem.copyForwards(u8, self.m_src[0..], self.m_src[n..self.m_len]);
                self.m_len -= n;
            }
        }

        /// Trims whitespace from the end of the `Self` instance.
        pub inline fn trimEnd(self: anytype) void {
            while (self.m_len > 0 and self.m_src[self.m_len - 1] == ' ') {
                self.m_len -= 1;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Replace ──────────────────────────┐

        /// -
        pub inline fn replaceRange(self: anytype, allocator: Allocator, start: usize, len: usize, replacement: []const u8) InsertError!void {
            const after_range = start + len;
            const range = self.m_src[start..after_range];
            if (range.len < replacement.len) {
                const first = replacement[0..range.len];
                const rest = replacement[range.len..];
                @memcpy(range[0..first.len], first);
                try insertSlice(self, allocator, rest, after_range);
            } else {
                replaceRangeAssumeCapacity(self, start, len, replacement);
            }
        }

        /// -
        pub inline fn replaceRangeForFixed(self: anytype, start: usize, len: usize, replacement: []const u8) !void {
            const after_range = start + len;
            const range = self.m_src[start..after_range];
            if (range.len < replacement.len) {
                const first = replacement[0..range.len];
                const rest = replacement[range.len..];
                @memcpy(range[0..first.len], first);
                try self.insertSlice(rest, after_range);
            } else {
                replaceRangeAssumeCapacity(self, start, len, replacement);
            }
        }

        /// -
        pub inline fn replaceRangeAssumeCapacity(self: anytype, start: usize, len: usize, replacement: []const u8) void {
            const after_range = start + len;
            const range = self.m_src[start..after_range];

            if (range.len == replacement.len)
                @memcpy(range[0..replacement.len], replacement)
            else if (range.len < replacement.len) {
                const first = replacement[0..range.len];
                const rest = replacement[range.len..];
                @memcpy(range[0..first.len], first);
                const dst = addManyAtAssumeCapacity(self, after_range, rest.len);
                @memcpy(dst, rest);
            } else {
                const extra = range.len - replacement.len;
                @memcpy(range[0..replacement.len], replacement);
                std.mem.copyForwards( u8, self.m_src[after_range - extra ..], self.m_src[after_range..], );
                @memset(self.m_src[self.m_len - extra ..], undefined);
                self.m_len -= extra;
            }
        }

        /// -
        pub inline fn replaceVisualRange(self: anytype, allocator: Allocator, start: usize, length: usize, replacement: []const u8) InsertError!void {
            const new_length = getNewLengthForReplaceVisualRange(self, start, length);
            try replaceRange(self, allocator, start, new_length, replacement);
        }

        /// -
        pub inline fn replaceVisualRangeForFixed(self: anytype, start: usize, length: usize, replacement: []const u8) !void {
            const new_length = getNewLengthForReplaceVisualRange(self, start, length);
            try replaceRangeForFixed(self, start, new_length, replacement);
        }

        /// -
        pub inline fn replaceVisualRangeAssumeCapacity(self: anytype, start: usize, length: usize, replacement: []const u8) !void {
            const new_length = getNewLengthForReplaceVisualRange(self, start, length);
            replaceRangeAssumeCapacity(self, start, new_length, replacement);
        }

        /// -
        pub inline fn getNewLengthForReplaceVisualRange(self: anytype, start: usize, length: usize) usize {
            var new_length: usize = 0;
            var iter = utils.unicode.Iterator.initUnchecked(self.m_src[start..self.m_len]);
            var i: usize = 0;

            while (iter.nextGraphemeCluster()) |gc| {
                new_length += gc.len;
                i += 1;
                if (i == length) break;
            }

            return new_length;
        }

        /// -
        pub inline fn replaceFirst(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8) InsertError!void {
            if(self.find(target)) |index| try replaceRange(self, allocator, index, target.len, replacement);
        }


        /// -
        pub inline fn replaceFirstN(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
            for(0..count) |_|
            if(self.find(target)) |index| try replaceRange(self, allocator, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceFirstForFixed(self: anytype, target: []const u8, replacement: []const u8) !void {
            if(self.find(target)) |index| try replaceRangeForFixed(self, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceFirstForFixedN(self: anytype, target: []const u8, replacement: []const u8, count: usize) !void {
            for(0..count) |_|
            if(self.find(target)) |index| try replaceRangeForFixed(self, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceLast(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8) InsertError!void {
            if(self.findLast(target)) |index| try replaceRange(self, allocator, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceLastN(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
            for(0..count) |_|
            if(self.findLast(target)) |index| try replaceRange(self, allocator, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceLastForFixed(self: anytype, target: []const u8, replacement: []const u8) !void {
            if(self.findLast(target)) |index| try replaceRangeForFixed(self, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceLastForFixedN(self: anytype, target: []const u8, replacement: []const u8, count: usize) !void {
            for(0..count) |_|
            if(self.findLast(target)) |index| try replaceRangeForFixed(self, index, target.len, replacement);
        }

        /// -
        pub inline fn replaceNth(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8, nth: usize) InsertError!void {
            const slice = self.src();
            var occurrence: usize = 0;
            var index: ?usize = utils.bytes.find(slice[0..], target);
            while (index) |i| {
                if (occurrence == nth) {
                    try replaceRange(self, allocator, i, target.len, replacement);
                    break;
                }
                occurrence += 1;
                index = utils.bytes.find(slice[i + target.len ..], target) orelse null;
                if (index) |next_i| {
                    index = next_i + i + target.len;
                }
            }
        }

        /// -
        pub inline fn replaceNthForFixed(self: anytype, target: []const u8, replacement: []const u8, nth: usize) !void {
            const slice = self.src();
            var occurrence: usize = 0;
            var index: ?usize = utils.bytes.find(slice[0..], target);
            while (index) |i| {
                if (occurrence == nth) {
                    try replaceRangeForFixed(self, i, target.len, replacement);
                    break;
                }
                occurrence += 1;
                index = utils.bytes.find(slice[i + target.len ..], target) orelse null;
                if (index) |next_i| {
                    index = next_i + i + target.len;
                }
            }
        }

        /// -
        pub inline fn replaceAll(self: anytype, allocator: Allocator, target: []const u8, replacement: []const u8) InsertError!void {
            var index = self.find(target);
            while (index) |i| {
                try replaceRange(self, allocator, i, target.len, replacement);
                index = self.find(target);
            }
        }

        /// -
        pub inline fn replaceAllForFixed(self: anytype, target: []const u8, replacement: []const u8) !void {
            var index = self.find(target);
            while (index) |i| {
                try replaceRangeForFixed(self, i, target.len, replacement);
                index = self.find(target);
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Repeat ───────────────────────────┐

        /// Repeats a byte `count` times and appends it to the `Self` instance.
        pub fn appendNTimes(self: anytype, allocator : Allocator, byte: u8, count: usize) InsertError!void {
            if(count == 0) return;
            const old_len = self.m_len;
            try ensureExtraCapacity(self, allocator, old_len+count);
            @memset(self.m_src[old_len..][0..count], byte);
            self.m_len += count;
        }

        /// Append a value to the list `n` times.
        /// Never invalidates element pointers.
        /// The function is inline so that a comptime-known `value` parameter will
        /// have a more optimal memset codegen in case it has a repeated byte pattern.
        /// Asserts that the list can hold the additional items.
        pub inline fn appendNTimesAssumeCapacity(self: anytype, byte: u8, count: usize) void {
            if(count == 0) return;
            const old_len = self.m_len;
            @memset(self.m_src[old_len..][0..count], byte);
            self.m_len += count;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Utils ────────────────────────────┐

        /// Reverses the order of the characters in the `Self` instance (considering Unicode).
        pub inline fn reverse(self: anytype, allocator: Allocator) Allocator.Error!void {
            if (self.m_src.len == 0) return;
            var original_data = std.ArrayList(u8).init(allocator);
            defer original_data.deinit();
            try original_data.appendSlice(self.src());

            utils.bytes.reverseUnicode(self.allocatedSlice(), self.m_len, original_data.items[0..]);
        }

        /// Invalidates all element pointers and clears the memory.
        pub inline fn clearAndFree(self: anytype, allocator: Allocator) void {
            allocator.free(self.allocatedSlice());
            self.m_src.len = 0;
            self.m_len = 0;
        }

        /// The caller owns the returned memory. Empties this ArrayList.
        /// Its capacity is cleared, making deinit() safe but unnecessary to call.
        pub inline fn toOwnedSlice(self: anytype, allocator: Allocator) Allocator.Error![]u8 {
            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, self.m_src.len)) {
                const result = self.m_src;
                self.* = undefined;
                return result;
            }

            const new_memory = try allocator.alloc(u8, self.m_src.len);
            @memcpy(new_memory, self.m_src);
            @memset(self.m_src, undefined);
            clearAndFree(self, allocator);
            return new_memory;
        }

        /// Reduce allocated capacity to `new_len`.
        pub inline fn shrinkAndFree(self: anytype, allocator: Allocator, new_len: usize) void {
            if(new_len > self.m_len) return;

            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, new_len)) {
                self.m_src.len = new_len;
                self.m_len = new_len;
                return;
            }

            const new_memory = allocator.alloc(u8,new_len) catch |e| switch (e) {
                error.OutOfMemory => {
                    // No problem, capacity is still correct then.
                    self.m_src.len = new_len;
                    self.m_len = new_len;
                    return;
                },
            };

            @memcpy(new_memory, self.m_src[0..new_len]);
            allocator.free(old_memory);
            self.m_src = new_memory;
            self.m_src.len = new_memory.len;
            self.m_len = new_len;
        }

        /// Adjust the list length to `new_len`.
        /// Additional elements contain the value `undefined`.
        /// Invalidates element pointers if additional memory is needed.
        pub inline fn resize(Self: type, self: anytype, allocator: Allocator, new_len: usize) Allocator.Error!void {
            if (new_len > self.size()) {
                try ensureCapacity(self, allocator, new_len);
                @memset(self.m_src[self.m_len..][0..new_len-self.m_len], 0);
                self.m_src.len = new_len;
            } else if (new_len < self.size()) {
                var new_self = try Self.initWithCapacity(allocator, new_len);
                if(self.m_len > 0) {
                    const min_len = @min(self.m_len, new_len);
                    @memcpy(new_self.m_src, self.m_src[0..min_len]);
                    new_self.m_len = min_len;
                }
                self.deinitWithAllocator(allocator);
                self.* = new_self;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Internal ───────────────────────────┐

        /// Integer addition returning `error.OutOfMemory` on overflow.
        pub inline fn addOrOom(a: usize, b: usize) error { OutOfMemory } !usize {
            const result, const overflow = @addWithOverflow(a, b);
            if (overflow != 0) return error.OutOfMemory;
            return result;
        }

        /// Called when memory growth is necessary. Returns a capacity larger than
        /// minimum that grows super-linearly.
        pub inline fn growCapacity(current: usize, minimum: usize) usize {
            var new = current;
            while (true) {
                new +|= new / 2 + 8;
                if (new >= minimum)
                    return new;
            }
        }

        /// Adds `count` new elements at the specified index, which have undefined values.
        /// Returns a slice pointing to the newly allocated elements.
        pub inline fn addManyAt(self: anytype, allocator: Allocator, index: usize, count: usize) Allocator.Error![]u8 {
            const new_len = try addOrOom(self.m_len, count);

            if (self.m_len == 0)
                return self.m_src[index..][0..count];

            if (self.m_src.len > new_len)
                return addManyAtAssumeCapacity(self, index, count);

            // Attempt to resize in place to avoid unnecessary memory copies.
            const new_capacity = growCapacity(self.m_src.len, new_len);
            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, new_capacity)) {
                self.m_src.len = new_capacity;
                return addManyAtAssumeCapacity(self, index, count);
            }

            // Make a new allocation, avoiding `ensureCapacity` to prevent extra memory copies.
            const new_memory = try allocator.alloc(u8, new_capacity);
            const to_move = self.m_src[index..];
            @memcpy(new_memory[0..index], self.m_src[0..index]);
            @memcpy(new_memory[index + count ..][0..to_move.len], to_move);
            allocator.free(old_memory);
            self.m_src = new_memory[0..new_len];
            self.m_src.len = new_memory.len;
            return new_memory[index..][0..count];
        }

        /// Adds `count` new elements at the specified index, which have undefined values.
        /// Returns a slice pointing to the newly allocated elements.
        pub inline fn addManyAtAssumeCapacity(self: anytype, index: usize, count: usize) []u8 {
            const new_len = self.len() + count;
            std.debug.assert(self.size() >= new_len);
            const to_move = self.m_src[index..new_len-1];
            // debug (index, count, new_len, to_move, to_move.len)
            // std.debug.print("self.len(): {d}, self.size(): {d}, index: {d}, count: {d}, new_len: {d}, to_move: {s}, to_move.len: {d}\n", .{self.len(), self.size(), index, count, new_len, to_move, to_move.len});
            std.mem.copyBackwards(u8, self.m_src[index + count ..], to_move);
            const result = self.m_src[index..][0..count];
            @memset(result, undefined);
            return result;
        }

        /// Inserts the specified slice at the specified position in the string.
        pub inline fn insertSliceAssumeCapacity(self: anytype, allocator: Allocator, slice: []const u8, position: usize) InsertError!void {
            const dst = try addManyAt(self, allocator, position, slice.len);
            @memcpy(dst, slice);
            self.m_len += slice.len;
        }

        /// Inserts the specified byte at the specified position in the string.
        pub inline fn insertByteAssumeCapacity(self: anytype, allocator: Allocator, byte: u8, position: usize) InsertError!void {
            const dst = try addManyAt(self, allocator, position, 1);
            dst[0] = byte;
            self.m_len += 1;
        }

        /// Appends a slice to the `Self` instance without checking capacity.
        pub inline fn appendSliceAssumeCapacity(self: anytype, slice: []const u8) void {
            const old_len = self.m_len;
            std.debug.assert(old_len + slice.len <= self.m_src.len);
            self.m_len += slice.len;
            @memcpy(self.m_src[old_len..][0..slice.len], slice);
        }

        /// Increases the length by 1, returning a pointer to the new item.
        pub inline fn addByteAssumeCapacity(self: anytype) *u8 {
            std.debug.assert(self.m_len < self.m_src.len);
            self.m_len += 1;
            return &self.m_src[self.m_len - 1];
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝