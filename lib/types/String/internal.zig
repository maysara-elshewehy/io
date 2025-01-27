// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Bytes = @import("../../utils/bytes/bytes.zig");

    pub const Allocator = std.mem.Allocator;
    pub const AllocatorError = Allocator.Error || error { OutOfMemory };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌──────────────────────────── ----- ───────────────────────────┐

        /// If the current capacity is less than `new_capacity`, this function will
        /// modify the array so that it can hold exactly `new_capacity` bytes.
        /// Invalidates element pointers if additional memory is needed.
        pub inline fn ensureCapacity(self: anytype, allocator: Allocator, required_capacity: usize, mul: bool) AllocatorError!void {
            if (self.m_capacity >= required_capacity) return;

            const new_capacity = if(mul) growCapacity(self.m_capacity, required_capacity) else required_capacity;
            // const new_capacity = if(mul) mulOrOom(required_capacity, 2) catch required_capacity else required_capacity;

            // Here we avoid copying allocated but unused bytes by
            // attempting a resize in place, and falling back to allocating
            // a new buffer and doing our own copy. With a realloc() call,
            // the allocator implementation would pointlessly copy our
            // extra capacity. referance: std.ArrayList.
            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, new_capacity)) {
                self.m_capacity = new_capacity;
            } else {
                const new_memory = try allocator.alloc(u8, new_capacity);
                @memcpy(new_memory[0..self.m_source.len], self.m_source);
                allocator.free(old_memory);
                self.m_source.ptr = new_memory.ptr;
                self.m_capacity = new_memory.len;
            }
        }

        /// If the current capacity is less than `new_capacity`, this function will
        /// modify the array so that it can hold exactly `new_capacity` bytes.
        /// Invalidates element pointers if additional memory is needed.
        pub inline fn ensureUnusedCapacity(self: anytype, allocator: Allocator, extra_capacity: usize) AllocatorError!void {
            return try ensureCapacity(self, allocator, try addOrOom(self.m_source.len, extra_capacity), true);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Insert ───────────────────────────┐

        pub const insertVisualError = AllocatorError || error { InvalidPosition };

        /// Insert slice `items` at index `i` by moving `list[i .. list.len]` to make room.
        /// This operation is O(N).
        /// Invalidates pre-existing pointers to elements at and after `index`.
        /// Invalidates all pre-existing element pointers if capacity must be
        /// increased to accommodate the new elements.
        /// Asserts that the index is in bounds or equal to the length.
        pub inline fn insert(self: anytype, allocator: Allocator, _slice: []const u8, pos: usize) AllocatorError!void {
            const dst = try addManyAt(self, allocator, pos, _slice.len);
            @memcpy(dst, _slice);
        }

        /// Inserts a `byte` into the `String` instance at the specified `position` by **real position**.
        /// - `insertError.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
        ///
        /// Modifies the `String` instance in place.
        pub fn insertOne(self: anytype, allocator: Allocator, byte: u8, pos: usize) AllocatorError!void {
            const dst = try addManyAt(self, allocator ,pos, 1);
            dst[0] = byte;
        }

        /// Inserts a `slice` into the `String` instance at the specified `visual position`.
        /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
        ///
        /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
        pub fn insertVisual(self: anytype, allocator: Allocator, _slice: []const u8, pos: usize) insertVisualError!void {
            const real_pos = utf8.utils.getRealPosition(self.slice(), pos) catch return insertVisualError.InvalidPosition;
            const dst = try addManyAt(self, allocator, real_pos, _slice.len);
            @memcpy(dst, _slice);
        }

        /// Inserts a `byte` into the `String` instance at the specified `visual position`.
        /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
        ///
        /// Modifies the `String` instance in place.
        pub fn insertVisualOne(self: anytype, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void {
            const real_pos = utf8.utils.getRealPosition(self.slice(), pos) catch return insertVisualError.InvalidPosition;
            const dst = try addManyAt(self, allocator, real_pos, 1);
            dst[0] = byte;
        }

        /// Appends a `slice` into the `String` instance.
        ///
        /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
        pub inline fn append(self: anytype, allocator: Allocator, _slice: []const u8) AllocatorError!void {
            if (_slice.len == 0) return;
            try ensureUnusedCapacity(self, allocator, _slice.len);
            unsafeAppend(self, _slice);
        }
        inline fn unsafeAppend(self: anytype, _slice: []const u8) void {
            const old_len = self.m_source.len;
            std.debug.assert(old_len+_slice.len <= self.m_capacity);
            self.m_source.len += _slice.len;
            @memcpy(self.m_source[old_len..][0.._slice.len], _slice);
        }

        /// Appends a `byte` into the `String` instance.
        ///
        /// Modifies the `String` instance in place.
        pub inline fn appendOne(self: anytype, allocator: Allocator, byte: u8) AllocatorError!void {
            const new_src_ptr = try addOne(self, allocator);
            new_src_ptr.* = byte;
        }

        /// Increase length by 1, returning pointer to the new item.
        /// The returned pointer becomes invalid when the list resized.
        inline fn addOne(self: anytype, allocator: Allocator) AllocatorError!*u8 {
            // This can never overflow because `self.m_source` can never occupy the whole address space
            try ensureUnusedCapacity(self, allocator, 1);
            return addOneAssumeCapacity(self);
        }

        /// Increase length by 1, returning pointer to the new item.
        /// The returned pointer becomes invalid when the list is resized.
        /// Never invalidates element pointers.
        /// Asserts that the list can hold one additional item.
        inline fn addOneAssumeCapacity(self: anytype) *u8 {
            std.debug.assert(self.m_source.len < self.m_capacity);
            self.m_source.len += 1;
            return &self.m_source[self.m_source.len - 1];
        }

        /// Add `count` new elements at position `index`, which have
        /// `undefined` values. Returns a slice pointing to the newly allocated
        /// elements, which becomes invalid after various `ArrayList`
        /// operations.
        /// Invalidates pre-existing pointers to elements at and after `index`.
        /// Invalidates all pre-existing element pointers if capacity must be
        /// increased to accommodate the new elements.
        /// Asserts that the index is in bounds or equal to the length.
        inline fn addManyAt(self: anytype, allocator: Allocator, index: usize, count: usize) AllocatorError![]u8 {
            const new_len = try addOrOom(self.m_source.len, count);
            // const new_len = mulOrOom(_new_len, 2) catch _new_len;

            if (self.m_capacity >= new_len)
                return addManyAtAssumeCapacity(self, index, count);

            // Here we avoid copying allocated but unused bytes by
            // attempting a resize in place, and falling back to allocating
            // a new buffer and doing our own copy. With a realloc() call,
            // the allocator implementation would pointlessly copy our
            // extra capacity.
            // const new_capacity = mulOrOom(new_len, 2) catch growCapacity(self.m_capacity, new_len);
            const new_capacity = growCapacity(self.m_capacity, new_len);
            const old_memory = self.allocatedSlice();
            if (allocator.resize(old_memory, new_capacity)) {
                self.m_capacity = new_capacity;
                return addManyAtAssumeCapacity(self, index, count);
            }

            // Make a new allocation, avoiding `ensureTotalCapacity` in order
            // to avoid extra memory copies.
            const new_memory = try allocator.alloc(u8, new_capacity);
            const to_move = self.m_source[index..];
            @memcpy(new_memory[0..index], self.m_source[0..index]);
            @memcpy(new_memory[index + count ..][0..to_move.len], to_move);
            allocator.free(old_memory);
            self.m_source = new_memory[0..new_len];
            self.m_capacity = new_memory.len;
            // The inserted elements at `new_memory[index..][0..count]` have
            // already been set to `undefined` by memory allocation.
            return new_memory[index..][0..count];
        }

        /// Add `count` new elements at position `index`, which have
        /// `undefined` values. Returns a slice pointing to the newly allocated
        /// elements, which becomes invalid after various `ArrayList`
        /// operations.
        /// Asserts that there is enough capacity for the new elements.
        /// Invalidates pre-existing pointers to elements at and after `index`, but
        /// does not invalidate any before that.
        /// Asserts that the index is in bounds or equal to the length.
        inline fn addManyAtAssumeCapacity(self: anytype, index: usize, count: usize) []u8 {
            const new_len = self.m_source.len + count;
            std.debug.assert(self.m_capacity >= new_len);
            const to_move = self.m_source[index..];
            self.m_source.len = new_len;
            std.mem.copyBackwards(u8, self.m_source[index + count ..], to_move);
            const result = self.m_source[index..][0..count];
            @memset(result, undefined);
            return result;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── Remove ───────────────────────────┐

        pub const removeError       = Bytes.removeError;
        pub const removeVisualError = Bytes.removeVisualError;

        /// Removes a byte from the `uString` instance.
        /// - `removeError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
        ///
        /// Modifies the `uString` instance in place.
        pub inline fn remove(self: anytype, pos: usize) removeError!void {
            try Bytes.remove(self.allocatedSlice(), self.length(), pos);
            self.m_source.len -= 1;
        }

        /// Removes a `range` of bytes from the `uString` instance.
        /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
        ///
        /// Modifies the `uString` instance in place.
        pub inline fn removeRange(self: anytype, pos: usize, len: usize) removeError!void {
            try Bytes.removeRange(self.allocatedSlice(), self.length(), pos, len);
            self.m_source.len -= len;
        }

        /// Removes a byte from the `uString` instance by the `visual position`.
        /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisual(self: anytype, pos: usize) removeVisualError![]const u8 {
            const removed_slice = try Bytes.removeVisual(self.allocatedSlice(), self.length(), pos);
            self.m_source.len -= removed_slice.len;
            return removed_slice;
        }

        /// Removes a `range` of bytes from the `uString` instance by the `visual position`.
        /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
        /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
        ///
        /// Returns the removed slice.
        pub inline fn removeVisualRange(self: anytype, pos: usize, len: usize) removeVisualError![]const u8 {
            const removed_slice = try Bytes.removeVisualRange(self.allocatedSlice(), self.length(), pos, len);
            self.m_source.len -= removed_slice.len;
            return removed_slice;
        }

        /// Removes the last grapheme cluster at the `uString` instance,
        /// Returns the removed slice.
        pub inline fn pop(self: anytype) ?[]const u8 {
            const len = Bytes.pop(self.slice());
            if(len == 0) return null;

            self.m_source.len -= len;
            return self.allocatedSlice()[self.m_source.len..self.m_source.len+len];
        }

        /// Removes the first grapheme cluster at the `uString` instance,
        /// Returns the number of removed bytes.
        pub inline fn shift(self: anytype) usize {
            const len = Bytes.shift(self.allocatedSlice()[0..self.m_source.len]);
            self.m_source.len -= len;
            return len;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Find ────────────────────────────┐

        /// Finds the `position` of the **first** occurrence of `target`.
        pub inline fn find(self: anytype, target: []const u8) ?usize {
            return Bytes.find(self.slice(), target);
        }

        /// Finds the `visual position` of the **first** occurrence of `target`.
        pub inline fn findVisual(self: anytype, target: []const u8) !?usize {
            return Bytes.findVisual(self.slice(), target);
        }

        /// Finds the `position` of the **last** occurrence of `target`.
        pub inline fn rfind(self: anytype, target: []const u8) ?usize {
            return Bytes.rfind(self.slice(), target);
        }

        /// Finds the `visual position` of the **last** occurrence of `target`.
        pub inline fn rfindVisual(self: anytype, target: []const u8) ?usize {
            return Bytes.rfindVisual(self.slice(), target);
        }

        /// Returns `true` **if contains `target`**.
        pub inline fn includes(self: anytype, target: []const u8) bool {
            return Bytes.includes(self.slice(), target);
        }

        /// Returns `true` **if starts with `target`**.
        pub inline fn startsWith(self: anytype, target: []const u8) bool {
            return Bytes.startsWith(self.slice(), target);
        }

        /// Returns `true` **if ends with `target`**.
        pub inline fn endsWith(self: anytype, target: []const u8) bool {
            return Bytes.endsWith(self.slice(), target);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── Case ────────────────────────────┐

        /// Converts all (ASCII) letters to lowercase.
        pub inline fn toLower(self: anytype) void {
            if(self.m_source.len > 0)
            Bytes.toLower(self.allocatedSlice()[0..self.m_source.len]);
        }

        /// Converts all (ASCII) letters to uppercase.
        pub inline fn toUpper(self: anytype) void {
            if(self.m_source.len > 0)
            Bytes.toUpper(self.allocatedSlice()[0..self.m_source.len]);
        }

        // Converts all (ASCII) letters to titlecase.
        pub inline fn toTitle(self: anytype) void {
            if(self.m_source.len > 0)
            Bytes.toTitle(self.allocatedSlice()[0..self.m_source.len]);
        }

        /// Reverses the order of the characters **_(considering unicode)_**.
        pub inline fn reverse(self: anytype, allocator: Allocator) AllocatorError!void {
            if (self.m_source.len == 0) return;
            var original_data = std.ArrayList(u8).init(allocator);
            defer original_data.deinit();
            try original_data.appendSlice(self.slice());

            var utf8_iterator = Iterator.unsafeInit(original_data.items[0..]);
            var i: usize = self.m_source.len;

            while (utf8_iterator.nextGraphemeCluster()) |gc| {
                i -= gc.len;
                @memcpy(self.allocatedSlice()[i..i + gc.len], gc);
                if (i == 0) break; // to avoid underflow.
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── DATA ────────────────────────────┐

        /// Returns the number of bytes that can be written to `m_source`.
        pub inline fn capacity(self: anytype) usize {
            return self.m_capacity;
        }

        /// Returns the total number of written bytes, stopping at the first null byte.
        pub inline fn length(self: anytype) usize {
            return self.m_source.len;
        }

        /// Returns the total number of visual characters.
        pub inline fn vlength(self: anytype) usize {
            return Bytes.countVisual(self.slice()) catch unreachable;
        }

        /// Returns a slice representing the entire allocated memory range.
        pub inline fn allocatedSlice(self: anytype) []u8 {
            return self.m_source.ptr[0..self.m_capacity];
        }

        /// Returns a slice containing only the written part.
        pub inline fn slice(self: anytype) []const u8 {
            return if(self.m_source.len > 0) self.m_source.ptr[0..self.m_source.len] else "";
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Iterator ──────────────────────────┐

        pub const Iterator = utf8.Iterator;

        /// Creates an iterator for traversing the UTF-8 bytes.
        /// - `Iterator.Error` **_if the initialization failed._**
        pub inline fn iterator(self: anytype) Iterator.Error!Iterator {
            return try Iterator.init(self.slice());
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ----- ───────────────────────────┐

        /// Integer addition returning `error.OutOfMemory` on overflow.
        inline fn addOrOom(a: usize, b: usize) error{OutOfMemory}!usize {
            const result, const overflow = @addWithOverflow(a, b);
            if (overflow != 0) return error.OutOfMemory;
            return result;
        }

        /// Integer multiplication returning `error.OutOfMemory` on overflow.
        inline fn mulOrOom(a: usize, b: usize) error{OutOfMemory}!usize {
            const result, const overflow = @mulWithOverflow(a, b);
            if (overflow != 0) return error.OutOfMemory;
            return result;
        }

        /// Called when memory growth is necessary. Returns a capacity larger than
        /// minimum that grows super-linearly.
        inline fn growCapacity(current: usize, minimum: usize) usize {
            var new = current;
            while (true) {
                new +|= new / 2 + 8;
                if (new >= minimum)
                    return new;
            }
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝