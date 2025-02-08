// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/string/
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const common                = @import("./common.zig");
    const std                   = common.std;
    const Allocator             = common.Allocator;
    pub const utils             = common.utils;
    pub const Iterator          = utils.unicode.Iterator;
    pub const RangeError        = common.RangeError;
    pub const CapacityError     = common.CapacityError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Viewer ═════════════════════════════════════╗

    /// Immutable fixed-size string type that supports unicode.
    pub const Viewer = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The immutable unicode encoded bytes.
            m_src: []const u8 = &.{},

            /// The number of written bytes.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `Viewer` instance.
            pub fn initEmpty() Viewer {
                return Viewer{ .m_src = &.{}, .m_len = 0 };
            }

            /// Initializes a new `Viewer` instance with the specified initial `bytes`.
            pub fn initWithSlice(initial_bytes: []const u8) Viewer {
                return Viewer{ .m_src = initial_bytes, .m_len = utils.bytes.countWritten(initial_bytes) };
            }

            /// Initializes a new `Viewer` instance with the specified initial `Viewer`.
            pub fn initWithSelf(initial_self: Viewer) Viewer {
                return Viewer{ .m_src = initial_self.src(), .m_len = initial_self.len() };
            }

            /// Initializes a `Viewer` instance with anytype.
            /// the value will be converted to a string if necessary.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn init(initial_value: anytype) !Viewer {
                if(utils.bytes.isBytes(initial_value)) return Viewer.initWithSlice(initial_value)
                else if(@TypeOf(initial_value) == Viewer) return Viewer.initWithSelf(initial_value)
                else @panic("Initialization error: Viewer type only supports slice values. Non-slice data cannot be used for initialization.");
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the number of bytes that can be written.
            pub inline fn size(self: Viewer) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written bytes.
            pub inline fn len(self: Viewer) usize {
                return self.m_len;
            }

            /// Returns the total number of visual characters in the `Viewer` instance.
            pub inline fn vlen(self: Viewer) usize {
                return if(self.len() > 0) utils.bytes.countVisual(self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `Viewer`.
            pub inline fn src(self: Viewer) []const u8 {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `Viewer`.
            pub inline fn sub(self: Viewer, start: usize, end: usize) RangeError![]const u8 {
                return common.sub(self, start, end);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Viewer, index: usize) ?u8 {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Viewer, visual_pos: usize) ?[]const u8 {
                return common.atVisual(self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode bytes in the `Viewer`.
            pub inline fn iterator(self: Viewer) Iterator {
                return Iterator.initUnchecked(self.src());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Viewer, target: []const u8) ?usize {
                return utils.bytes.find(self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Viewer, target: []const u8) ?usize {
                return utils.bytes.findVisual(self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Viewer, target: []const u8) ?usize {
                return utils.bytes.findLast(self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Viewer, target: []const u8) ?usize {
                return utils.bytes.findLastVisual(self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance contains the target slice.
            pub fn includes(self: Viewer, target: []const u8) bool {
                return utils.bytes.includes(self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance starts with the target slice.
            pub fn startsWith(self: Viewer, target: []const u8) bool {
                return utils.bytes.startsWith(self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance ends with the target slice.
            pub fn endsWith(self: Viewer, target: []const u8) bool {
                return utils.bytes.endsWith(self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `Viewer` instance equals the given target slice.
            pub fn isEqual(self: Viewer, target: []const u8) bool {
                return utils.bytes.equals(self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance is empty.
            pub fn isEmpty(self: Viewer) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `Viewer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Viewer, delimiters: []const u8, index: usize) ?[]const u8 {
                return utils.bytes.split(self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `Viewer` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Viewer, allocator: Allocator, delimiters: []const u8, includeEmpty: bool) ![]const []const u8 {
                return utils.bytes.splitAll(allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `Viewer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `Viewer` instance.
            pub fn splitToSelf(self: Viewer, delimiters: []const u8, index: usize) ?Viewer {
                if (self.split(delimiters, index)) |block| {
                    const s = Viewer.initWithSlice(block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `Viewer` into all substrings separated by the specified delimiters,
            /// returning an array of new `Viewer` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Viewer, allocator: Allocator, delimiters: []const u8) ![]Viewer {
                var splitArr = std.ArrayList(Viewer).init(allocator);
                defer splitArr.deinit();

                var i: usize = 0;
                while (self.splitToSelf(delimiters, i)) |splitStr| : (i += 1) {
                    try splitArr.append(splitStr);
                }

                return splitArr.toOwnedSlice();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a deep copy of the `Viewer` instance.
            pub fn clone(self: Viewer) Viewer {
                return Viewer.initWithSelf(self);
            }

            /// Clears the contents of the `Viewer`.
            pub fn clear(self: *Viewer) void {
                self.m_len = 0;
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Buffer ═════════════════════════════════════╗

    /// Mutable fixed-size string type that supports unicode.
    pub fn Buffer(comptime initial_size: usize) type {
    return struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            const Self = @This();

            /// Writer for the `Buffer` type.
            pub const Writer = std.io.Writer(*Self, InsertError, write);

            /// The mutable unicode encoded bytes.
            m_src: [initial_size]u8 = undefined,

            /// The number of written bytes.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            // If the given value requires more space than the array size,
            // the init functions will use `@min(initial_size, bytes.len)`
            // to get the minimum acceptable size.
            // Why? Because the buffer is fixed-size,
            // and we must be careful about the acceptable size of this buffer
            // before using it.
            // So, you must be careful when using this type.
            //
            // initWithFmt() and init() are exceptions to this rule.


            /// Initializes a new empty `Buffer` instance.
            pub fn initEmpty() Self {
                return Self{ .m_src = undefined, .m_len = 0 };
            }

            /// Initializes a new `Buffer` instance with the specified initial `bytes`.
            pub fn initWithSlice(initial_bytes: []const u8) Self {
                return Self{ .m_src = makeArrayAndFillWithSlice(initial_bytes), .m_len = utils.bytes.countWritten(initial_bytes) };
            }

            /// Initializes a new `Buffer` instance with the specified initial `byte`.
            pub fn initWithByte(initial_byte: u8) Self {
                return initWithSlice(&[_]u8{initial_byte});
            }

            /// Initializes a new `Buffer` instance with the specified initial `Buffer`.
            pub fn initWithSelf(initial_self: Self) Self {
                return Self{ .m_src = makeArrayAndFillWithSlice(initial_self.src()), .m_len = initial_self.len() };
            }

            /// Initializes a `Buffer` instance with a formatted string.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn initWithFmt(comptime fmt: []const u8, args: anytype) CapacityError!Self {
                return makeBufferAndFillWithFmt(fmt, args);
            }

            /// Initializes a `Buffer` instance with anytype.
            /// the value will be converted to a string if necessary.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn init(initial_value: anytype) CapacityError!Self {
                if(utils.bytes.isByte(initial_value)) return Self.initWithByte(initial_value)
                else if(utils.bytes.isBytes(initial_value)) return Self.initWithSlice(initial_value)
                else if(@TypeOf(initial_value) == Self) return Self.initWithSelf(initial_value)
                else return Self.initWithFmt("", initial_value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the number of bytes that can be written.
            pub inline fn size(_: Self) usize {
                return initial_size;
            }

            /// Returns the total number of written bytes.
            pub inline fn len(self: Self) usize {
                return self.m_len;
            }

            /// Returns the total number of visual characters in the `Buffer` instance.
            pub inline fn vlen(self: Self) usize {
                return if(self.len() > 0) utils.bytes.countVisual(self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `Buffer`.
            pub inline fn src(self: Self) []const u8 {
                return if(self.m_len > 0) self.m_src[0..self.m_len] else "";
            }

            /// Returns a sub-slice of the `Buffer`.
            pub inline fn sub(self: Self, start: usize, end: usize) RangeError![]const u8 {
                return common.sub(self, start, end);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Self, index: usize) ?u8 {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Self, visual_pos: usize) ?[]const u8 {
                return common.atVisual(self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode bytes in the `Buffer`.
            pub inline fn iterator(self: Self) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *Self) Writer {
                return .{ .context = self };
            }

            /// Writes the given slice to the `Buffer` instance.
            fn write(self: *Self, m: []const u8) InsertError!usize {
                try self.appendSlice(m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = utils.bytes.InsertError;

            /// Inserts a slice into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *Self, slice: []const u8, position: usize) InsertError!void {
                try utils.bytes.insertSlice(&self.m_src, slice, self.m_len, position);
                self.m_len += slice.len;
            }

            /// Inserts a byte into the `Buffer` instance at the specified position.
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertByte(self: *Self, byte: u8, position: usize) InsertError!void {
                try utils.bytes.insertByte(&self.m_src, byte, self.m_len, position);
                self.m_len += 1;
            }

            /// Inserts a `Buffer` into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn insertSelf(self: *Self, buffer: Self, position: usize) InsertError!void {
                try utils.bytes.insertSlice(&self.m_src, buffer.src(), self.m_len, position);
                self.m_len += buffer.len();
            }

            /// Inserts a formatted string into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *Self, comptime fmt: []const u8, args: anytype, position: usize) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.insertSelf(temp, position);
            }

            /// Inserts a value from anytype into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *Self, value: anytype, position: usize) InsertError!void {
                if(utils.bytes.isByte(value)) try self.insertByte(value, position)
                else if(utils.bytes.isBytes(value)) try self.insertSlice(value, position)
                else if(@TypeOf(value) == Self) try self.insertSelf(value, position)
                else try self.insertFmt("", value, position);
            }

            /// Inserts a slice into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *Self, slice: []const u8, position: usize) InsertError!void {
                try utils.bytes.visualInsertSlice(&self.m_src, slice, self.m_len, position);
                self.m_len += slice.len;
            }

            /// Inserts a byte into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertByte(self: *Self, byte: u8, position: usize) InsertError!void {
                try utils.bytes.visualInsertByte(&self.m_src, byte, self.m_len, position);
                self.m_len += 1;
            }

            /// Inserts a `Buffer` into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSelf(self: *Self, buffer: Self, position: usize) InsertError!void {
                try utils.bytes.visualInsertSlice(&self.m_src, buffer.src(), self.m_len, position);
                self.m_len += buffer.len();
            }

            /// Inserts a formatted string into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *Self, comptime fmt: []const u8, args: anytype, position: usize) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.visualInsertSelf(temp, position);
            }

            /// Inserts a value from anytype into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *Self, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.bytes.isByte(initial_value)) try self.visualInsertByte(initial_value, visual_pos)
                else if(utils.bytes.isBytes(initial_value)) try self.visualInsertSlice(initial_value, visual_pos)
                else if(@TypeOf(initial_value) == Self) try self.visualInsertSelf(initial_value, visual_pos)
                else try self.visualInsertFmt("", initial_value, visual_pos);
            }

            /// Appends a slice to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendSlice(self: *Self, slice: []const u8) InsertError!void {
                try utils.bytes.appendSlice(&self.m_src, slice, self.m_len);
                self.m_len += slice.len;
            }

            /// Appends a byte to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendByte(self: *Self, byte: u8) InsertError!void {
                try utils.bytes.appendByte(&self.m_src, byte, self.m_len);
                self.m_len += 1;
            }

            /// Appends a `Buffer` to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendSelf(self: *Self, buffer: Self) InsertError!void {
                try utils.bytes.appendSlice(&self.m_src, buffer.src(), self.m_len);
                self.m_len += buffer.len();
            }

            /// Appends a formatted string to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendFmt(self: *Self, comptime fmt: []const u8, args: anytype) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.appendSelf(temp);
            }

            /// Appends a value from anytype to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn append(self: *Self, value: anytype) InsertError!void {
                if(utils.bytes.isByte(value)) try self.appendByte(value)
                else if(utils.bytes.isBytes(value)) try self.appendSlice(value)
                else if(@TypeOf(value) == Self) try self.appendSelf(value)
                else try self.appendFmt("", value);
            }

            /// Prepend a slice to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependSlice(self: *Self, slice: []const u8) InsertError!void {
                try self.insertSlice(slice, 0);
            }

            /// Prepend a byte to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependByte(self: *Self, byte: u8) InsertError!void {
                try self.insertByte(byte, 0);
            }

            /// Prepend a `Buffer` to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependSelf(self: *Self, buffer: Self) InsertError!void {
                try self.insertSelf(buffer, 0);
            }

            /// Prepend a formatted string to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependFmt(self: *Self, comptime fmt: []const u8, args: anytype) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.prependSelf(temp);
            }

            /// Prepend a value from anytype to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prepend(self: *Self, value: anytype) InsertError!void {
                if(utils.bytes.isByte(value)) try self.prependByte(value)
                else if(utils.bytes.isBytes(value)) try self.prependSlice(value)
                else if(@TypeOf(value) == Self) try self.prependSelf(value)
                else try self.prependFmt("", value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = common.removeIndexError;
            pub const removeVisualIndexError = common.removeVisualIndexError;

            /// Removes a byte from the `Buffer` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *Self, position: usize) removeIndexError!void {
                return common.removeIndex(self, position);
            }

            /// Removes a byte from the `Buffer` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *Self, visual_pos: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualIndex(self, visual_pos);
            }

            /// Removes a range of bytes from the `Buffer` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *Self, position: usize, length: usize) removeIndexError!void {
                return common.removeRange(self, position, length);
            }

            /// Removes a range of bytes from the `Buffer` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, visual_pos: usize, length: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualRange(self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `Buffer` instance.
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const u8 {
                return common.pop(self);
            }

            /// Removes the first grapheme cluster from the `Buffer` instance.
            /// Returns the number of removed bytes.
            pub fn shift(self: *Self) usize {
                return common.shift(self);
            }

            /// Trims whitespace from both ends of the `Buffer` instance.
            pub fn trim(self: *Self) void {
                return common.trim(self);
            }

            /// Trims whitespace from the start of the `Buffer` instance.
            pub fn trimStart(self: *Self) void {
                return common.trimStart(self);
            }

            /// Trims whitespace from the end of the `Buffer` instance.
            pub fn trimEnd(self: *Self) void {
                return common.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of bytes with another slice in the `Buffer`.
            pub fn replaceRange(self: *Self, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceRangeForFixed(self, start, length, replacement);
            }

            /// Replaces a visual range of bytes with another slice in the `Buffer`.
            pub fn replaceVisualRange(self: *Self, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceVisualRangeForFixed(self, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceFirst(self: *Self, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceFirstForFixed(self, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceFirstN(self: *Self, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceFirstForFixedN(self, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceLast(self: *Self, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceLastForFixed(self, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceLastN(self: *Self, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceLastForFixedN(self, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `Buffer`.
            pub fn replaceAll(self: *Self, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceAllForFixed(self, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceNth(self: *Self, target: []const u8, replacement: []const u8, nth: usize) InsertError!void {
                try common.replaceNthForFixed(self, target, replacement, nth);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a byte `count` times and appends it to the `Buffer` instance.
            pub fn repeat(self: *Self, byte: u8, count: usize) InsertError!void {
                if(self.size() < self.m_len+count) return InsertError.OutOfMemory;
                return common.appendNTimesAssumeCapacity(self, byte, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Self, target: []const u8) ?usize {
                return utils.bytes.find(self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Self, target: []const u8) ?usize {
                return utils.bytes.findVisual(self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Self, target: []const u8) ?usize {
                return utils.bytes.findLast(self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Self, target: []const u8) ?usize {
                return utils.bytes.findLastVisual(self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance contains the target slice.
            pub fn includes(self: Self, target: []const u8) bool {
                return utils.bytes.includes(self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance starts with the target slice.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return utils.bytes.startsWith(self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance ends with the target slice.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return utils.bytes.endsWith(self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `Buffer` instance to lowercase.
            pub fn toLower(self: *Self) void {
                if (self.m_src.len > 0)
                utils.bytes.toLower(self.m_src[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `Buffer` instance to uppercase.
            pub fn toUpper(self: *Self) void {
                if (self.m_src.len > 0)
                utils.bytes.toUpper(self.m_src[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `Buffer` instance to title case.
            pub fn toTitle(self: *Self) void {
                if (self.m_src.len > 0)
                utils.bytes.toTitle(self.m_src[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `Buffer` instance equals the given target slice.
            pub fn isEqual(self: Self, target: []const u8) bool {
                return utils.bytes.equals(self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `Buffer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8 {
                return utils.bytes.split(self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `Buffer` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, includeEmpty: bool) ![]const []const u8 {
                return utils.bytes.splitAll(allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `Buffer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `Buffer` instance.
            pub fn splitToSelf(self: Self, delimiters: []const u8, index: usize) CapacityError!?Self {
                if (self.split(delimiters, index)) |block| {
                    if(block.len > initial_size) return error.OutOfMemory;
                    const s = Self.initWithSlice(block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `Buffer` into all substrings separated by the specified delimiters,
            /// returning an array of new `Buffer` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Self, allocator: Allocator, delimiters: []const u8) ![]Self {
                var splitArr = std.ArrayList(Self).init(allocator);
                defer splitArr.deinit();

                var i: usize = 0;
                while (try self.splitToSelf(delimiters, i)) |splitStr| : (i += 1) {
                    try splitArr.append(splitStr);
                }

                return splitArr.toOwnedSlice();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a deep copy of the `Buffer` instance.
            pub fn clone(self: Self) Self {
                return Self.initWithSelf(self);
            }

            /// Clears the contents of the `Buffer`.
            pub fn clear(self: *Self) void {
                self.m_len = 0;
            }

            /// Reverses the order of the characters in the `Buffer` instance (considering Unicode).
            pub fn reverse(self: *Self) void {
                if (self.m_len == 0) return;
                const cloned = self.clone();
                var unicode_iterator = utils.unicode.Iterator.initUnchecked(cloned.src());
                var i: usize = self.m_len;

                while (unicode_iterator.nextGraphemeCluster()) |gc| {
                    i -= gc.len;
                    @memcpy(self.m_src[i..i + gc.len], gc);
                    if (i == 0) break; // to avoid underflow.
                }
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Internal ─────────────────────────┐

            inline fn makeArrayAndFillWithSlice(bytes: []const u8) [initial_size]u8 {
                var buffer : [initial_size]u8 = undefined;
                if(initial_size > 0 and bytes.len > 0) {
                    const buff_len = @min(initial_size, bytes.len);
                    @memcpy(buffer[0..buff_len], bytes[0..buff_len]);
                    if(buff_len < initial_size) buffer[buff_len] = 0;
                }
                return buffer;
            }

            inline fn makeBufferAndFillWithFmt(comptime fmt: []const u8, args: anytype) CapacityError!Self {
                const TI = @typeInfo(@TypeOf(args));
                const new_fmt = if(fmt.len > 0) fmt else if(TI == .@"struct" or TI == .@"array") "{any}" else "{}";
                const new_args = if(fmt.len > 0) args else .{ args };

                const required_size = std.fmt.count(new_fmt, new_args);
                if(required_size > initial_size) return error.OutOfMemory;
                var buffer = Self.initEmpty();
                std.fmt.format(buffer.writer(), new_fmt, new_args) catch unreachable;
                return buffer;
            }

        // └──────────────────────────────────────────────────────────────┘

    }; }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ uString ═════════════════════════════════════╗

    /// Unmanaged dynamic-size string type that supports unicode.
    pub const uString = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// -
            const WriterContext = struct { self: *uString, allocator: Allocator, };

            /// Writer for the `uString` type.
            pub const Writer = std.io.Writer(WriterContext, Allocator.Error, write);

            /// The mutable unicode encoded bytes.
            m_src: []u8 = &[_]u8{},

            /// The number of written bytes.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `uString` instance.
            /// The purpose of this function is to integrate the API.
            pub fn initEmpty() uString {
                return .{ };
            }

            /// Initializes a new empty `uString` instance with the specified allocator.
            /// The purpose of this function is to integrate the API.
            pub fn initWithAllocator(allocator: Allocator) Allocator.Error!uString {
                return uString.initWithCapacity(allocator, 0);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `capacity`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithCapacity(allocator: Allocator, initial_capacity: usize) Allocator.Error!uString {
                var self : uString = .{ };
                try common.ensureCapacity(&self, allocator, initial_capacity);
                return self;
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `bytes`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSlice(allocator: Allocator, initial_bytes: []const u8) Allocator.Error!uString {
                return common.initWithSlice(uString, allocator, initial_bytes);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `byte`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithByte(allocator: Allocator, initial_byte: u8) Allocator.Error!uString {
                return common.initWithByte(uString, allocator, initial_byte);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `uString`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSelf(allocator: Allocator, initial_self: uString) Allocator.Error!uString {
                return common.initWithSelf(uString, allocator, initial_self);
            }

            /// Initializes a `uString` instance with the specified allocator and formatted string.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithFmt(allocator: Allocator, comptime fmt: []const u8, args: anytype) Allocator.Error!uString {
                return common.initWithFmt(uString, allocator, fmt, args);
            }

            /// Initializes a `uString` instance with the specified allocator and anytype.
            /// the value will be converted to a string if necessary.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn init(allocator: Allocator, initial_value: anytype) Allocator.Error!uString {
                return common.init(uString, allocator, initial_value);
            }

            /// Releases all allocated memory associated with the `uString` instance.
            pub fn deinit(self: uString, allocator: Allocator) void {
                return common.deinit(self, allocator);
            }

            /// Releases all allocated memory associated with the `String` instance.
            /// The purpose of this method is to integrate with the internal API.
            pub fn deinitWithAllocator(self: uString, allocator: Allocator) void {
                return self.deinit(allocator);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the number of bytes that can be written.
            pub inline fn size(self: uString) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written bytes.
            pub inline fn len(self: uString) usize {
                return self.m_len;
            }

            /// Returns the total number of visual characters in the `uString` instance.
            pub inline fn vlen(self: uString) usize {
                return if(self.len() > 0) utils.bytes.countVisual(self.src()) else 0;
            }

            /// Returns a slice representing the entire allocated memory range.
            pub inline fn allocatedSlice(self: uString) []u8 {
                return self.m_src[0..self.size()];
            }

            /// Returns a slice containing only the written part of the `uString`.
            pub inline fn src(self: uString) []const u8 {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `uString`.
            pub inline fn sub(self: uString, start: usize, end: usize) RangeError![]const u8 {
                return common.sub(self, start, end);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: uString, index: usize) ?u8 {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: uString, visual_pos: usize) ?[]const u8 {
                return common.atVisual(self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode bytes in the `uString`.
            pub inline fn iterator(self: uString) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *uString, allocator: Allocator) Writer {
                return .{ .context = .{ .self = self, .allocator = allocator } };
            }

            /// Initializes a Writer which will append to the list.
            /// The purpose of this method is to integrate with the internal/common methods.
            pub inline fn writerWithAllocator(self: *uString, allocator: Allocator) Writer {
                return writer(self, allocator);
            }

            /// Writes the given slice to the `uString` instance.
            fn write(self: WriterContext, m: []const u8) Allocator.Error!usize {
                try self.self.appendSlice(self.allocator, m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = common.InsertError;

            /// Inserts a slice into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *uString, allocator: Allocator, slice: []const u8, position: usize) InsertError!void {
                try common.insertSlice(self, allocator, slice, position);
            }

            /// Inserts a byte into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertByte(self: *uString, allocator: Allocator, byte: u8, position: usize) InsertError!void {
                try common.insertByte(self, allocator, byte, position);
            }

            /// Inserts a `uString` into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn insertSelf(self: *uString, allocator: Allocator, string: uString, position: usize) InsertError!void {
                try self.insertSlice(allocator, string.src(), position);
            }

            /// Inserts a formatted string into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *uString, allocator: Allocator, comptime fmt: []const u8, args: anytype, position: usize) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.insertSelf(allocator, temp, position);
            }

            /// Inserts a value from anytype into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *uString, allocator: Allocator, initial_value: anytype, position: usize) InsertError!void {
                if(utils.bytes.isByte(initial_value)) try self.insertByte(allocator, initial_value, position)
                else if(utils.bytes.isBytes(initial_value)) try self.insertSlice(allocator, initial_value, position)
                else if(@TypeOf(initial_value) == uString) try self.insertSelf(allocator, initial_value, position)
                else try self.insertFmt(allocator, "", initial_value, position);
            }

            /// Inserts a slice into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *uString, allocator: Allocator, slice: []const u8, visual_pos: usize) InsertError!void {
                try common.visualInsertSlice(self, allocator, slice, visual_pos);
            }

            /// Inserts a byte into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertByte(self: *uString, allocator: Allocator, byte: u8, visual_pos: usize) InsertError!void {
                try common.visualInsertByte(self, allocator, byte, visual_pos);
            }

            /// Inserts a `uString` into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn visualInsertSelf(self: *uString, allocator: Allocator, string: uString, visual_pos: usize) InsertError!void {
                try self.visualInsertSlice(allocator, string.src(), visual_pos);
            }

            /// Inserts a formatted string into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *uString, allocator: Allocator, comptime fmt: []const u8, args: anytype, visual_pos: usize) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.visualInsertSelf(allocator, temp, visual_pos);
            }

            /// Inserts a value from anytype into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *uString, allocator: Allocator, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.bytes.isByte(initial_value)) try self.visualInsertByte(allocator, initial_value, visual_pos)
                else if(utils.bytes.isBytes(initial_value)) try self.visualInsertSlice(allocator, initial_value, visual_pos)
                else if(@TypeOf(initial_value) == uString) try self.visualInsertSelf(allocator, initial_value, visual_pos)
                else try self.visualInsertFmt(allocator, "", initial_value, visual_pos);
            }

            /// Appends a slice to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSlice(self: *uString, allocator: Allocator, slice: []const u8) Allocator.Error!void {
                try common.appendSlice(self, allocator, slice);
            }

            /// Appends a byte to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendByte(self: *uString, allocator: Allocator, byte: u8) Allocator.Error!void {
                try common.appendByte(self, allocator, byte);
            }

            /// Appends a `uString` to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSelf(self: *uString, allocator: Allocator, string: uString) Allocator.Error!void {
                try self.appendSlice(allocator, string.src());
            }

            /// Appends a formatted string to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendFmt(self: *uString, allocator: Allocator, comptime fmt: []const u8, args: anytype) Allocator.Error!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.appendSlice(allocator, temp.src());
            }

            /// Appends a value from anytype to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn append(self: *uString, allocator: Allocator, initial_value: anytype) Allocator.Error!void {
                if(utils.bytes.isByte(initial_value)) try self.appendByte(allocator, initial_value)
                else if(utils.bytes.isBytes(initial_value)) try self.appendSlice(allocator, initial_value)
                else if(@TypeOf(initial_value) == uString) try self.appendSelf(allocator, initial_value)
                else try self.appendFmt(allocator, "", initial_value);
            }

            /// Prepends a slice to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSlice(self: *uString, allocator: Allocator, slice: []const u8) InsertError!void {
                try common.insertSlice(self, allocator, slice, 0);
            }

            /// Prepends a byte to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependByte(self: *uString, allocator: Allocator, byte: u8) InsertError!void {
                try common.insertByte(self, allocator, byte, 0);
            }

            /// Prepends a `uString` to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSelf(self: *uString, allocator: Allocator, string: uString) InsertError!void {
                try self.prependSlice(allocator, string.src());
            }

            /// Prepends a formatted string to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependFmt(self: *uString, allocator: Allocator, comptime fmt: []const u8, args: anytype) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.prependSlice(allocator, temp.src());
            }

            /// Prepends a value from anytype to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prepend(self: *uString, allocator: Allocator, initial_value: anytype) InsertError!void {
                if(utils.bytes.isByte(initial_value)) try self.prependByte(allocator, initial_value)
                else if(utils.bytes.isBytes(initial_value)) try self.prependSlice(allocator, initial_value)
                else if(@TypeOf(initial_value) == uString) try self.prependSelf(allocator, initial_value)
                else try self.prependFmt(allocator, "", initial_value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = common.removeIndexError;
            pub const removeVisualIndexError = common.removeVisualIndexError;

            /// Removes a byte from the `uString` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *uString, position: usize) removeIndexError!void {
                return common.removeIndex(self, position);
            }

            /// Removes a byte from the `uString` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *uString, visual_pos: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualIndex(self, visual_pos);
            }

            /// Removes a range of bytes from the `uString` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *uString, position: usize, length: usize) removeIndexError!void {
                return common.removeRange(self, position, length);
            }

            /// Removes a range of bytes from the `uString` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *uString, visual_pos: usize, length: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualRange(self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `uString` instance.
            /// Returns the removed slice.
            pub fn pop(self: *uString) ?[]const u8 {
                return common.pop(self);
            }

            /// Removes the first grapheme cluster from the `uString` instance.
            /// Returns the number of removed bytes.
            pub fn shift(self: *uString) usize {
                return common.shift(self);
            }

            /// Trims whitespace from both ends of the `uString` instance.
            pub fn trim(self: *uString) void {
                return common.trim(self);
            }

            /// Trims whitespace from the start of the `uString` instance.
            pub fn trimStart(self: *uString) void {
                return common.trimStart(self);
            }

            /// Trims whitespace from the end of the `uString` instance.
            pub fn trimEnd(self: *uString) void {
                return common.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of bytes with another slice in the `uString`.
            pub fn replaceRange(self: *uString, allocator: Allocator, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceRange(self, allocator, start, length, replacement);
            }

            /// Replaces a visual range of bytes with another slice in the `uString`.
            pub fn replaceVisualRange(self: *uString, allocator : Allocator, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceVisualRange(self, allocator, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `uString`.
            pub fn replaceFirst(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceFirst(self, allocator, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `uString`.
            pub fn replaceFirstN(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceFirstN(self, allocator, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `uString`.
            pub fn replaceLast(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceLast(self, allocator, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `uString`.
            pub fn replaceLastN(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceLastN(self, allocator, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `uString`.
            pub fn replaceAll(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceAll(self, allocator, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `uString`.
            pub fn replaceNth(self: *uString, allocator : Allocator, target: []const u8, replacement: []const u8, nth: usize) InsertError!void {
                try common.replaceNth(self, allocator, target, replacement, nth);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a byte `count` times and appends it to the `uString` instance.
            pub fn repeat(self: *uString, allocator : Allocator, byte: u8, count: usize) InsertError!void {
                try common.appendNTimes(self, allocator, byte, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: uString, target: []const u8) ?usize {
                return utils.bytes.find(self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: uString, target: []const u8) ?usize {
                return utils.bytes.findVisual(self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: uString, target: []const u8) ?usize {
                return utils.bytes.findLast(self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: uString, target: []const u8) ?usize {
                return utils.bytes.findLastVisual(self.src(), target);
            }

            /// Returns `true` if the `uString` instance contains the target slice.
            pub fn includes(self: uString, target: []const u8) bool {
                return utils.bytes.includes(self.src(), target);
            }

            /// Returns `true` if the `uString` instance starts with the target slice.
            pub fn startsWith(self: uString, target: []const u8) bool {
                return utils.bytes.startsWith(self.src(), target);
            }

            /// Returns `true` if the `uString` instance ends with the target slice.
            pub fn endsWith(self: uString, target: []const u8) bool {
                return utils.bytes.endsWith(self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `uString` instance to lowercase.
            pub fn toLower(self: *uString) void {
                if (self.m_src.len > 0)
                utils.bytes.toLower(self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `uString` instance to uppercase.
            pub fn toUpper(self: *uString) void {
                if (self.m_src.len > 0)
                utils.bytes.toUpper(self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `uString` instance to title case.
            pub fn toTitle(self: *uString) void {
                if (self.m_src.len > 0)
                utils.bytes.toTitle(self.allocatedSlice()[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `uString` instance equals the given target slice.
            pub fn isEqual(self: uString, target: []const u8) bool {
                return utils.bytes.equals(self.src(), target);
            }

            /// Returns `true` if the `uString` instance is empty.
            pub fn isEmpty(self: uString) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `uString` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: uString, delimiters: []const u8, index: usize) ?[]const u8 {
                return utils.bytes.split(self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `uString` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: uString, allocator: Allocator, delimiters: []const u8, includeEmpty: bool) ![]const []const u8 {
                return utils.bytes.splitAll(allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `uString` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `uString` instance.
            pub fn splitToSelf(self: uString, allocator: Allocator, delimiters: []const u8, index: usize) Allocator.Error!?uString {
                if (self.split(delimiters, index)) |block| {
                    const s = try uString.initWithSlice(allocator, block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `uString` into all substrings separated by the specified delimiters,
            /// returning an array of new `uString` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: uString, allocator: Allocator, delimiters: []const u8) Allocator.Error![]uString {
                var splitArr = std.ArrayList(uString).init(allocator);
                defer splitArr.deinit();

                var i: usize = 0;
                while (try self.splitToSelf(allocator, delimiters, i)) |splitStr| : (i += 1) {
                    try splitArr.append(splitStr);
                }

                return splitArr.toOwnedSlice();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a deep copy of the `uString` instance.
            pub fn clone(self: uString, allocator: Allocator) Allocator.Error!uString {
                return uString.initWithSelf(allocator, self);
            }

            /// Reverses the order of the characters in the `uString` instance (considering Unicode).
            pub fn reverse(self: *uString, allocator: Allocator) Allocator.Error!void {
                return common.reverse(self, allocator);
            }

            /// Reduce allocated capacity to `new_len`.
            pub fn shrinkAndFree(self: *uString, allocator: Allocator, new_len: usize) void {
                common.shrinkAndFree(self, allocator, new_len);
            }

            /// Reduce length to `new_len`.
            pub fn shrink(self: *uString, new_len: usize) void {
                if(new_len < self.m_len) self.m_len = new_len;
            }

            /// Adjust the `uString` instance length to `new_len`.
            pub fn resize(self: *uString, allocator: Allocator, new_len: usize) Allocator.Error!void {
                return common.resize(uString, self, allocator, new_len);
            }

            /// Clears the contents of the `uString`.
            pub fn clear(self: *uString) void {
                self.m_len = 0;
            }

            /// Clears the contents of the `uString` and frees its memory, invalidating all pointers.
            pub fn clearAndFree(self: *uString, allocator: Allocator) void {
                common.clearAndFree(self, allocator);
            }

            /// Initializes a new `uString` instance from an owned slice of bytes.
            pub fn fromOwnedSlice(slice: []u8) uString {
                return uString{
                    .m_src = slice,
                    .m_len = slice.len,
                };
            }

            /// Transfers ownership of the `uString`'s memory to the caller, emptying the `uString` and resetting its capacity.
            pub fn toOwnedSlice(self: *uString, allocator: Allocator) Allocator.Error![]u8 {
                return common.toOwnedSlice(self, allocator);
            }

            /// Converts the `uString` into a managed `String`, transferring ownership of its memory.
            pub fn toManaged(self: *uString, allocator: Allocator) String {
                return .{ .m_src = self.m_src, .m_len = self.m_len, .m_alloc = allocator };
            }

            /// Converts the `uString` instance to a `Viewer`.
            pub fn toViewer(self: uString) Viewer {
                return Viewer.initWithSlice(self.src());
            }

        // └──────────────────────────────────────────────────────────────┘

    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ String ═════════════════════════════════════╗

    /// Managed dynamic-size string type that supports unicode.
    pub const String = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Writer for the `String` type.
            pub const Writer = std.io.Writer(*String, Allocator.Error, write);

            /// Allocator used for memory management.
            m_alloc: Allocator = undefined,

            /// The mutable unicode encoded bytes.
            m_src: []u8 = &[_]u8{},

            /// The number of written bytes.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `String` instance with the specified allocator.
            /// The purpose of this function is to integrate the API.
            pub fn initEmpty(allocator: Allocator) Allocator.Error!String {
                return .{ .m_alloc = allocator };
            }

            /// Initializes a new empty `String` instance with the specified allocator.
            pub fn initWithAllocator(allocator: Allocator) Allocator.Error!String {
                return String.initWithCapacity(allocator, 0);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `capacity`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithCapacity(allocator: Allocator, initial_capacity: usize) Allocator.Error!String {
                var self : String = .{ .m_alloc = allocator };
                try common.ensureCapacity(&self, allocator, initial_capacity);
                return self;
            }

            /// Initializes a new `String` instance with the specified allocator and initial `bytes`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSlice(allocator: Allocator, initial_bytes: []const u8) Allocator.Error!String {
                return common.initWithSlice(String, allocator, initial_bytes);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `byte`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithByte(allocator: Allocator, initial_byte: u8) Allocator.Error!String {
                return common.initWithByte(String, allocator, initial_byte);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `String`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSelf(allocator: Allocator, initial_self: String) Allocator.Error!String {
                return common.initWithSelf(String, allocator, initial_self);
            }

            /// Initializes a `String` instance with the specified allocator and formatted string.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithFmt(allocator: Allocator, comptime fmt: []const u8, args: anytype) Allocator.Error!String {
                return common.initWithFmt(String, allocator, fmt, args);
            }

            /// Initializes a `String` instance with the specified allocator and anytype.
            /// the value will be converted to a string if necessary.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn init(allocator: Allocator, initial_value: anytype) Allocator.Error!String {
                return common.init(String, allocator, initial_value);
            }

            /// Releases all allocated memory associated with the `String` instance.
            pub fn deinit(self: String) void {
                return common.deinit(self, self.m_alloc);
            }

            /// Releases all allocated memory associated with the `String` instance.
            /// The purpose of this method is to integrate with the internal API.
            pub fn deinitWithAllocator(self: String, _: Allocator) void {
                return self.deinit();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the number of bytes that can be written.
            pub inline fn size(self: String) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written bytes.
            pub inline fn len(self: String) usize {
                return self.m_len;
            }

            /// Returns the total number of visual characters in the `String` instance.
            pub inline fn vlen(self: String) usize {
                return if(self.len() > 0) utils.bytes.countVisual(self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `String`.
            pub inline fn src(self: String) []const u8 {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `String`.
            pub inline fn sub(self: String, start: usize, end: usize) RangeError![]const u8 {
                return common.sub(self, start, end);
            }

            /// Returns a slice representing the entire allocated memory range.
            pub inline fn allocatedSlice(self: String) []u8 {
                return self.m_src[0..self.size()];
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: String, index: usize) ?u8 {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: String, visual_pos: usize) ?[]const u8 {
                return common.atVisual(self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode bytes in the `String`.
            pub inline fn iterator(self: String) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *String) Writer {
                return .{ .context = self };
            }

            /// Initializes a Writer which will append to the list.
            /// The purpose of this method is to integrate with the internal/common methods.
            pub inline fn writerWithAllocator(self: *String, _: Allocator) Writer {
                return .{ .context = self };
            }

            /// Writes the given slice to the `String` instance.
            fn write(self: *String, m: []const u8) Allocator.Error!usize {
                try self.appendSlice(m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = common.InsertError;

            /// Inserts a slice into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *String, slice: []const u8, position: usize) InsertError!void {
                try common.insertSlice(self, self.m_alloc, slice, position);
            }

            /// Inserts a byte into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertByte(self: *String, byte: u8, position: usize) InsertError!void {
                try common.insertByte(self, self.m_alloc, byte, position);
            }

            /// Inserts a `String` into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn insertSelf(self: *String, string: String, position: usize) InsertError!void {
                try self.insertSlice(string.src(), position);
            }

            /// Inserts a formatted string into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *String, comptime fmt: []const u8, args: anytype, position: usize) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.insertSelf(temp, position);
            }

            /// Inserts a value from anytype into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *String, value: anytype, position: usize) InsertError!void {
                if(utils.bytes.isByte(value)) return self.insertByte(value, position)
                else if(utils.bytes.isBytes(value)) return self.insertSlice(value, position)
                else if(@TypeOf(value) == self) return self.insertSelf(value, position)
                else return self.insertFmt("", value, position);
            }

            /// Inserts a slice into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *String, slice: []const u8, visual_pos: usize) InsertError!void {
                try common.visualInsertSlice(self, self.m_alloc, slice, visual_pos);
            }

            /// Inserts a byte into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertByte(self: *String, byte: u8, visual_pos: usize) InsertError!void {
                try common.visualInsertByte(self, self.m_alloc, byte, visual_pos);
            }

            /// Inserts a `String` into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn visualInsertSelf(self: *String, string: String, visual_pos: usize) InsertError!void {
                try self.visualInsertSlice(string.src(), visual_pos);
            }

            /// Inserts a formatted string into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *String, comptime fmt: []const u8, args: anytype, visual_pos: usize) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.visualInsertSelf(temp, visual_pos);
            }

            /// Inserts a value from anytype into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *String, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.bytes.isByte(initial_value)) try self.visualInsertByte(initial_value, visual_pos)
                else if(utils.bytes.isBytes(initial_value)) try self.visualInsertSlice(initial_value, visual_pos)
                else if(@TypeOf(initial_value) == String) try self.visualInsertSelf(initial_value, visual_pos)
                else try self.visualInsertFmt("", initial_value, visual_pos);
            }

            /// Appends a slice to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSlice(self: *String, slice: []const u8) Allocator.Error!void {
                try common.appendSlice(self, self.m_alloc, slice);
            }

            /// Appends a byte to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendByte(self: *String, byte: u8) Allocator.Error!void {
                try common.appendByte(self, self.m_alloc, byte);
            }

            /// Appends a `String` to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn appendSelf(self: *String, string: String) Allocator.Error!void {
                try self.appendSlice(string.src());
            }

            /// Appends a formatted string to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendFmt(self: *String, comptime fmt: []const u8, args: anytype) Allocator.Error!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.appendSelf(temp);
            }

            /// Appends a value from anytype to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn append(self: *String, value: anytype) Allocator.Error!void {
                if(utils.bytes.isByte(value)) return self.appendByte(value)
                else if(utils.bytes.isBytes(value)) return self.appendSlice(value)
                else if(@TypeOf(value) == self) return self.appendSelf(value)
                else return self.appendFmt("", value);
            }

            /// Prepends a slice to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSlice(self: *String, slice: []const u8) InsertError!void {
                try common.insertSlice(self, self.m_alloc, slice, 0);
            }

            /// Prepends a byte to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependByte(self: *String, byte: u8) InsertError!void {
                try common.insertByte(self, self.m_alloc, byte, 0);
            }

            /// Prepends a `Srting` to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn prependSelf(self: *String, string: String) InsertError!void {
                try self.prependSlice(string.src());
            }

            /// Prepends a formatted string to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependFmt(self: *String, comptime fmt: []const u8, args: anytype) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.prependSelf(temp);
            }

            /// Prepends a value from anytype to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prepend(self: *String, value: anytype) InsertError!void {
                if(utils.bytes.isByte(value)) return self.prependByte(value)
                else if(utils.bytes.isBytes(value)) return self.prependSlice(value)
                else if(@TypeOf(value) == self) return self.prependSelf(value)
                else return self.prependFmt("", value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = common.removeIndexError;
            pub const removeVisualIndexError = common.removeVisualIndexError;

            /// Removes a byte from the `String` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *String, position: usize) removeIndexError!void {
                return common.removeIndex(self, position);
            }

            /// Removes a byte from the `String` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *String, visual_pos: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualIndex(self, visual_pos);
            }

            /// Removes a range of bytes from the `String` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *String, position: usize, length: usize) removeIndexError!void {
                return common.removeRange(self, position, length);
            }

            /// Removes a range of bytes from the `String` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *String, visual_pos: usize, length: usize) removeVisualIndexError![]const u8 {
                return common.removeVisualRange(self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `String` instance.
            /// Returns the removed slice.
            pub fn pop(self: *String) ?[]const u8 {
                return common.pop(self);
            }

            /// Removes the first grapheme cluster from the `String` instance.
            /// Returns the number of removed bytes.
            pub fn shift(self: *String) usize {
                return common.shift(self);
            }

            /// Trims whitespace from both ends of the `String` instance.
            pub fn trim(self: *String) void {
                return common.trim(self);
            }

            /// Trims whitespace from the start of the `String` instance.
            pub fn trimStart(self: *String) void {
                return common.trimStart(self);
            }

            /// Trims whitespace from the end of the `String` instance.
            pub fn trimEnd(self: *String) void {
                return common.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of bytes with another slice in the `String`.
            pub fn replaceRange(self: *String, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceRange(self, self.m_alloc, start, length, replacement);
            }

            /// Replaces a visual range of bytes with another slice in the `String`.
            pub fn replaceVisualRange(self: *String, start: usize, length: usize, replacement: []const u8) InsertError!void {
                try common.replaceVisualRange(self, self.m_alloc, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `String`.
            pub fn replaceFirst(self: *String, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceFirst(self, self.m_alloc, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `String`.
            pub fn replaceFirstN(self: *String, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceFirstN(self, self.m_alloc, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `String`.
            pub fn replaceLast(self: *String, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceLast(self, self.m_alloc, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `String`.
            pub fn replaceLastN(self: *String, target: []const u8, replacement: []const u8, count: usize) InsertError!void {
                try common.replaceLastN(self, self.m_alloc, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `String`.
            pub fn replaceAll(self: *String, target: []const u8, replacement: []const u8) InsertError!void {
                try common.replaceAll(self, self.m_alloc, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `String`.
            pub fn replaceNth(self: *String, target: []const u8, replacement: []const u8, nth: usize) InsertError!void {
                try common.replaceNth(self, self.m_alloc, target, replacement, nth);
            }


        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a byte `count` times and appends it to the `String` instance.
            pub fn repeat(self: *String, byte: u8, count: usize) InsertError!void {
                try common.appendNTimes(self, self.m_alloc, byte, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐


            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: String, target: []const u8) ?usize {
                return utils.bytes.find(self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: String, target: []const u8) ?usize {
                return utils.bytes.findVisual(self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: String, target: []const u8) ?usize {
                return utils.bytes.findLast(self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: String, target: []const u8) ?usize {
                return utils.bytes.findLastVisual(self.src(), target);
            }

            /// Returns `true` if the `String` instance contains the target slice.
            pub fn includes(self: String, target: []const u8) bool {
                return utils.bytes.includes(self.src(), target);
            }

            /// Returns `true` if the `String` instance starts with the target slice.
            pub fn startsWith(self: String, target: []const u8) bool {
                return utils.bytes.startsWith(self.src(), target);
            }

            /// Returns `true` if the `String` instance ends with the target slice.
            pub fn endsWith(self: String, target: []const u8) bool {
                return utils.bytes.endsWith(self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `String` instance to lowercase.
            pub fn toLower(self: *String) void {
                if (self.m_src.len > 0)
                utils.bytes.toLower(self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `String` instance to uppercase.
            pub fn toUpper(self: *String) void {
                if (self.m_src.len > 0)
                utils.bytes.toUpper(self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `String` instance to title case.
            pub fn toTitle(self: *String) void {
                if (self.m_src.len > 0)
                utils.bytes.toTitle(self.allocatedSlice()[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `String` instance equals the given target slice.
            pub fn isEqual(self: String, target: []const u8) bool {
                return utils.bytes.equals(self.src(), target);
            }

            /// Returns `true` if the `String` instance is empty.
            pub fn isEmpty(self: String) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `String` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: String, delimiters: []const u8, index: usize) ?[]const u8 {
                return utils.bytes.split(self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `String` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: String, delimiters: []const u8, includeEmpty: bool) ![]const []const u8 {
                return utils.bytes.splitAll(self.m_alloc, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `String` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `String` instance.
            pub fn splitToSelf(self: String, delimiters: []const u8, index: usize) Allocator.Error!?String {
                if (self.split(delimiters, index)) |block| {
                    const s = try String.initWithSlice(self.m_alloc, block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `String` into all substrings separated by the specified delimiters,
            /// returning an array of new `String` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: String, delimiters: []const u8) Allocator.Error![]String {
                var splitArr = std.ArrayList(String).init(self.m_alloc);
                defer splitArr.deinit();

                var i: usize = 0;
                while (try self.splitToSelf(delimiters, i)) |splitStr| : (i += 1) {
                    try splitArr.append(splitStr);
                }

                return splitArr.toOwnedSlice();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a deep copy of the `String` instance.
            pub fn clone(self: String) Allocator.Error!String {
                return String.initWithSelf(self.m_alloc, self);
            }

            /// Reverses the order of the characters in the `String` instance (considering Unicode).
            pub fn reverse(self: *String) Allocator.Error!void {
                return common.reverse(self, self.m_alloc);
            }

            /// Reduce allocated capacity to `new_len`.
            pub fn shrinkAndFree(self: *String, new_len: usize) void {
                common.shrinkAndFree(self, self.m_alloc, new_len);
            }

            /// Reduce length to `new_len`.
            pub fn shrink(self: *String, new_len: usize) void {
                if(new_len < self.m_len) self.m_len = new_len;
            }

            /// Adjust the `String` instance length to `new_len`.
            pub fn resize(self: *String, new_len: usize) Allocator.Error!void {
                return common.resize(String, self, self.m_alloc, new_len);
            }

            /// Clears the contents of the `String`.
            pub fn clear(self: *String) void {
                self.m_len = 0;
            }

            /// Clears the contents of the `String` and frees its memory, invalidating all pointers.
            pub fn clearAndFree(self: *String) void {
                common.clearAndFree(self, self.m_alloc);
            }

            /// Initializes a new `String` from the given owned slice.
            pub fn fromOwnedSlice(allocator: Allocator, slice: []u8) String {
                return String{
                    .m_src = slice,
                    .m_len = slice.len,
                    .m_alloc = allocator,
                };
            }

            /// Transfers ownership of the `String`'s memory to the caller, emptying the `String` and resetting its capacity.
            pub fn toOwnedSlice(self: *String) Allocator.Error![]u8 {
                return common.toOwnedSlice(self, self.m_alloc);
            }

            /// Converts the `String` into an unmanaged `uString`, transferring ownership of its memory.
            pub fn toUnmanaged(self: *String) uString {
                const allocator = self.m_alloc;
                const result: uString = .{ .m_src = self.m_src, .m_len = self.m_len };
                self.* = initWithAllocator(allocator) catch unreachable;
                return result;
            }

            /// Converts the `String` instance to a `Viewer`.
            pub fn toViewer(self: String) Viewer {
                return Viewer.initWithSlice(self.src());
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝