// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/string/
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const help              = @import("./string.help.zig");
    const std               = help.std;
    const Allocator         = help.Allocator;
    pub const utils         = help.utils;
    pub const Iterator      = help.utils.unicode.Iterator;
    pub const RangeError    = help.RangeError;
    pub const CapacityError = help.CapacityError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Viewer ═════════════════════════════════════╗

    /// Immutable fixed-size string type that supports unicode.
    pub fn Viewer(comptime T: type) type {
        return struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            const Self = @This();

            /// The immutable unicode encoded chars.
            m_src: []const T = &.{},

            /// The number of written chars.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `Viewer` instance.
            pub fn initEmpty() Self {
                return Self{ .m_src = &.{}, .m_len = 0 };
            }

            /// Initializes a new `Viewer` instance with the specified initial `chars`.
            pub fn initWithSlice(initial_slice: []const T) Self {
                return Self{ .m_src = initial_slice, .m_len = utils.chars.countWritten(T, initial_slice) };
            }

            /// Initializes a new `Viewer` instance with the specified initial `Viewer`.
            pub fn initWithSelf(initial_self: Self) Self {
                return Self{ .m_src = initial_self.src(), .m_len = initial_self.len() };
            }

            /// Initializes a `Viewer` instance with anytype.
            /// the value will be converted to a string if necessary.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn init(initial_value: anytype) !Self {
                if(utils.chars.isSlice(T, initial_value)) return Self.initWithSlice(initial_value)
                else if(@TypeOf(initial_value) == Self) return Self.initWithSelf(initial_value)
                else @compileError("Initialization error: Viewer type only supports slice values. Non-slice data cannot be used for initialization.");
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the type used to represent a single character in this container.
            pub inline fn getType() type {
                return T;
            }

            /// Returns the number of chars that can be written.
            pub inline fn size(self: Self) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written chars.
            pub inline fn len(self: Self) usize {
                return self.m_len;
            }

            /// Returns the total number of visual chars in the `Viewer` instance.
            pub inline fn vlen(self: Self) usize {
                return if(self.len() > 0) utils.chars.countVisual(T, self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `Viewer`.
            pub inline fn src(self: Self) []const T {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `Viewer`.
            pub inline fn sub(self: Self, start: usize, end: usize) RangeError![]const T {
                return help.sub(Self, self, start, end);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Self, index: usize) ?T {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Self, visual_pos: usize) ?[]const T {
                return help.atVisual(Self, self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode chars in the `Viewer`.
            pub inline fn iterator(self: Self) Iterator {
                return Iterator.initUnchecked(self.src());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Self, target: []const T) ?usize {
                return utils.chars.find(T, self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findVisual(T, self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Self, target: []const T) ?usize {
                return utils.chars.findLast(T, self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findLastVisual(T, self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance contains the target slice.
            pub fn includes(self: Self, target: []const T) bool {
                return utils.chars.includes(T, self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance starts with the target slice.
            pub fn startsWith(self: Self, target: []const T) bool {
                return utils.chars.startsWith(T, self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance ends with the target slice.
            pub fn endsWith(self: Self, target: []const T) bool {
                return utils.chars.endsWith(T, self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `Viewer` instance equals the given target slice.
            pub fn isEqual(self: Self, target: []const T) bool {
                return utils.chars.equals(T, self.src(), target);
            }

            /// Returns `true` if the `Viewer` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `Viewer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const T, index: usize) ?[]const T {
                return utils.chars.split(T, self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `Viewer` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const T, includeEmpty: bool) ![]const []const T {
                return utils.chars.splitAll(T, allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `Viewer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `Viewer` instance.
            pub fn splitToSelf(self: Self, delimiters: []const T, index: usize) ?Self {
                if (self.split(delimiters, index)) |block| {
                    const s = Self.initWithSlice(block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `Viewer` into all substrings separated by the specified delimiters,
            /// returning an array of new `Viewer` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Self, allocator: Allocator, delimiters: []const T) ![]Self {
                var splitArr = std.ArrayList(Self).init(allocator);
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
            pub fn clone(self: Self) Self {
                return Self.initWithSelf(self);
            }

            /// Clears the contents of the `Viewer`.
            pub fn clear(self: *Self) void {
                self.m_len = 0;
            }

            /// Prints the contents of the `Viewer` instance to the given writer.
            pub fn printTo(self: Self, _writer: anytype) !void {
                return help.printTo(self, _writer);
            }

            /// Prints the contents of the `Viewer` instance to the standard writer.
            pub fn print(self: Self) !void {
                return help.print(self);
            }

            /// Prints the contents of the `Viewer` instance to the standard writer and adds a newline.
            pub fn printWithNewline(self: Self) !void {
                return help.printWithNewline(self);
            }

        // └──────────────────────────────────────────────────────────────┘

        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ Buffer ═════════════════════════════════════╗

    /// Mutable fixed-size string type that supports unicode.
    pub fn Buffer(comptime T: type, comptime initial_size: usize) type {
        return struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            const Self = @This();

            /// Writer for the `Buffer` type.
            pub const Writer = std.io.Writer(*Self, InsertError, write);

            /// The mutable unicode encoded chars.
            m_src: [initial_size]T = undefined,

            /// The number of written chars.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            // If the given value requires more space than the array size,
            // the init functions will use `@min(initial_size, chars.len)`
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

            /// Initializes a new `Buffer` instance with the specified initial `chars`.
            pub fn initWithSlice(initial_slice: []const T) Self {
                return Self{ .m_src = makeArrayAndFillWithSlice(initial_slice), .m_len = utils.chars.countWritten(T, initial_slice) };
            }

            /// Initializes a new `Buffer` instance with the specified initial `char`.
            pub fn initWithChar(initial_char: T) Self {
                return initWithSlice(&[_]T{initial_char});
            }

            /// Initializes a new `Buffer` instance with the specified initial `Buffer`.
            pub fn initWithSelf(initial_self: Self) Self {
                return Self{ .m_src = makeArrayAndFillWithSlice(initial_self.src()), .m_len = initial_self.len() };
            }

            /// Initializes a `Buffer` instance with a formatted string.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn initWithFmt(comptime fmt: []const T, args: anytype) CapacityError!Self {
                return makeBufferAndFillWithFmt(fmt, args);
            }

            /// Initializes a `Buffer` instance with anytype.
            /// the value will be converted to a string if necessary.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn init(initial_value: anytype) CapacityError!Self {
                if(utils.chars.isChar(T, initial_value)) return Self.initWithChar(initial_value)
                else if(utils.chars.isSlice(T, initial_value)) return Self.initWithSlice(initial_value)
                else if(@TypeOf(initial_value) == Self) return Self.initWithSelf(initial_value)
                else return Self.initWithFmt("", initial_value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the type used to represent a single character in this container.
            pub inline fn getType() type {
                return T;
            }

            /// Returns the number of chars that can be written.
            pub inline fn size(_: Self) usize {
                return initial_size;
            }

            /// Returns the total number of written chars.
            pub inline fn len(self: Self) usize {
                return self.m_len;
            }

            /// Returns the total number of visual chars in the `Buffer` instance.
            pub inline fn vlen(self: Self) usize {
                return if(self.len() > 0) utils.chars.countVisual(T, self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `Buffer`.
            pub inline fn src(self: Self) []const T {
                return if(self.m_len > 0) self.m_src[0..self.m_len] else "";
            }

            /// Returns a sub-slice of the `Buffer`.
            pub inline fn sub(self: Self, start: usize, end: usize) RangeError![]const T {
                return help.sub(Self, self, start, end);
            }

            /// Return the written portion of `Self` as a [:0]const u8 slice.
            pub inline fn cString(self: *Self) InsertError![:0]const u8 {
                comptime if (Self.getType() != u8) @compileError("cString is only available for u8");
                try utils.chars.insertChar(T, &self.m_src, 0, self.m_len, self.m_len);
                // Don't increment m_len as the 0 is not part of the string itself.
                return self.m_src[0..self.m_len :0];
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Self, index: usize) ?T {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Self, visual_pos: usize) ?[]const T {
                return help.atVisual(Self, self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode chars in the `Buffer`.
            pub inline fn iterator(self: Self) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *Self) Writer {
                return .{ .context = self };
            }

            /// Writes the given slice to the `Buffer` instance.
            fn write(self: *Self, m: []const T) InsertError!usize {
                try self.appendSlice(m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = utils.chars.InsertError;

            /// Inserts a slice into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *Self, slice: []const T, pos: usize) InsertError!void {
                try utils.chars.insertSlice(T, &self.m_src, slice, self.m_len, pos);
                self.m_len += slice.len;
            }

            /// Inserts a char into the `Buffer` instance at the specified position.
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertChar(self: *Self, char: T, pos: usize) InsertError!void {
                try utils.chars.insertChar(T, &self.m_src, char, self.m_len, pos);
                self.m_len += 1;
            }

            /// Inserts a `Buffer` into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn insertSelf(self: *Self, buffer: Self, pos: usize) InsertError!void {
                try utils.chars.insertSlice(T, &self.m_src, buffer.src(), self.m_len, pos);
                self.m_len += buffer.len();
            }

            /// Inserts a formatted string into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *Self, comptime fmt: []const T, args: anytype, pos: usize) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.insertSelf(temp, pos);
            }

            /// Inserts a value from anytype into the `Buffer` instance at the specified position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *Self, value: anytype, pos: usize) InsertError!void {
                if(utils.chars.isChar(T, value)) try self.insertChar(value, pos)
                else if(utils.chars.isSlice(T, value)) try self.insertSlice(value, pos)
                else if(@TypeOf(value) == Self) try self.insertSelf(value, pos)
                else try self.insertFmt("", value, pos);
            }

            /// Inserts a slice into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *Self, slice: []const T, pos: usize) InsertError!void {
                try utils.chars.visualInsertSlice(T, &self.m_src, slice, self.m_len, pos);
                self.m_len += slice.len;
            }

            /// Inserts a char into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertChar(self: *Self, char: T, pos: usize) InsertError!void {
                try utils.chars.visualInsertChar(T, &self.m_src, char, self.m_len, pos);
                self.m_len += 1;
            }

            /// Inserts a `Buffer` into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSelf(self: *Self, buffer: Self, pos: usize) InsertError!void {
                try utils.chars.visualInsertSlice(T, &self.m_src, buffer.src(), self.m_len, pos);
                self.m_len += buffer.len();
            }

            /// Inserts a formatted string into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *Self, comptime fmt: []const T, args: anytype, pos: usize) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.visualInsertSelf(temp, pos);
            }

            /// Inserts a value from anytype into the `Buffer` instance at the specified visual position.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *Self, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.chars.isChar(T, initial_value)) try self.visualInsertChar(initial_value, visual_pos)
                else if(utils.chars.isSlice(T, initial_value)) try self.visualInsertSlice(initial_value, visual_pos)
                else if(@TypeOf(initial_value) == Self) try self.visualInsertSelf(initial_value, visual_pos)
                else try self.visualInsertFmt("", initial_value, visual_pos);
            }

            /// Appends a slice to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendSlice(self: *Self, slice: []const T) InsertError!void {
                try utils.chars.appendSlice(T, &self.m_src, slice, self.m_len);
                self.m_len += slice.len;
            }

            /// Appends a char to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendChar(self: *Self, char: T) InsertError!void {
                try utils.chars.appendChar(T, &self.m_src, char, self.m_len);
                self.m_len += 1;
            }

            /// Appends a `Buffer` to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendSelf(self: *Self, buffer: Self) InsertError!void {
                try utils.chars.appendSlice(T, &self.m_src, buffer.src(), self.m_len);
                self.m_len += buffer.len();
            }

            /// Appends a formatted string to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn appendFmt(self: *Self, comptime fmt: []const T, args: anytype) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.appendSelf(temp);
            }

            /// Appends a value from anytype to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn append(self: *Self, value: anytype) InsertError!void {
                if(utils.chars.isChar(T, value)) try self.appendChar(value)
                else if(utils.chars.isSlice(T, value)) try self.appendSlice(value)
                else if(@TypeOf(value) == Self) try self.appendSelf(value)
                else try self.appendFmt("", value);
            }

            /// Prepend a slice to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependSlice(self: *Self, slice: []const T) InsertError!void {
                try self.insertSlice(slice, 0);
            }

            /// Prepend a char to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependChar(self: *Self, char: T) InsertError!void {
                try self.insertChar(char, 0);
            }

            /// Prepend a `Buffer` to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependSelf(self: *Self, buffer: Self) InsertError!void {
                try self.insertSelf(buffer, 0);
            }

            /// Prepend a formatted string to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prependFmt(self: *Self, comptime fmt: []const T, args: anytype) InsertError!void {
                const temp = initWithFmt(fmt, args) catch return InsertError.OutOfMemory;
                try self.prependSelf(temp);
            }

            /// Prepend a value from anytype to the `Buffer` instance.
            /// - `error.OutOfMemory` **if the buffer is not big enough.**
            pub fn prepend(self: *Self, value: anytype) InsertError!void {
                if(utils.chars.isChar(T, value)) try self.prependChar(value)
                else if(utils.chars.isSlice(T, value)) try self.prependSlice(value)
                else if(@TypeOf(value) == Self) try self.prependSelf(value)
                else try self.prependFmt("", value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = help.removeIndexError;
            pub const removeVisualIndexError = help.removeVisualIndexError;

            /// Removes a char from the `Buffer` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *Self, pos: usize) removeIndexError!void {
                return help.removeIndex(Self, self, pos);
            }

            /// Removes a char from the `Buffer` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *Self, visual_pos: usize) removeVisualIndexError![]const T {
                return help.removeVisualIndex(Self, self, visual_pos);
            }

            /// Removes a range of chars from the `Buffer` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *Self, pos: usize, length: usize) removeIndexError!void {
                return help.removeRange(Self, self, pos, length);
            }

            /// Removes a range of chars from the `Buffer` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, visual_pos: usize, length: usize) removeVisualIndexError![]const T {
                return help.removeVisualRange(Self, self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `Buffer` instance.
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const T {
                return help.pop(Self, self);
            }

            /// Removes the first grapheme cluster from the `Buffer` instance.
            /// Returns the number of removed chars.
            pub fn shift(self: *Self) usize {
                return help.shift(Self, self);
            }

            /// Trims whitespace from both ends of the `Buffer` instance.
            pub fn trim(self: *Self) void {
                return help.trim(self);
            }

            /// Trims whitespace from the start of the `Buffer` instance.
            pub fn trimStart(self: *Self) void {
                return help.trimStart(self);
            }

            /// Trims whitespace from the end of the `Buffer` instance.
            pub fn trimEnd(self: *Self) void {
                return help.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of chars with another slice in the `Buffer`.
            pub fn replaceRange(self: *Self, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceRangeForFixed(Self, self, start, length, replacement);
            }

            /// Replaces a visual range of chars with another slice in the `Buffer`.
            pub fn replaceVisualRange(self: *Self, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceVisualRangeForFixed(Self, self, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceFirst(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceFirstForFixed(Self, self, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceFirstN(self: *Self, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceFirstForFixedN(Self, self, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceLast(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceLastForFixed(Self, self, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceLastN(self: *Self, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceLastForFixedN(Self, self, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `Buffer`.
            pub fn replaceAll(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceAllForFixed(Self, self, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `Buffer`.
            pub fn replaceNth(self: *Self, target: []const T, replacement: []const T, nth: usize) InsertError!void {
                try help.replaceNthForFixed(Self, self, target, replacement, nth);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a char `count` times and appends it to the `Buffer` instance.
            pub fn repeat(self: *Self, char: T, count: usize) InsertError!void {
                if(self.size() < self.m_len+count) return InsertError.OutOfMemory;
                return help.appendNTimesAssumeCapacity(Self, self, char, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Self, target: []const T) ?usize {
                return utils.chars.find(T, self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findVisual(T, self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Self, target: []const T) ?usize {
                return utils.chars.findLast(T, self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findLastVisual(T, self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance contains the target slice.
            pub fn includes(self: Self, target: []const T) bool {
                return utils.chars.includes(T, self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance starts with the target slice.
            pub fn startsWith(self: Self, target: []const T) bool {
                return utils.chars.startsWith(T, self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance ends with the target slice.
            pub fn endsWith(self: Self, target: []const T) bool {
                return utils.chars.endsWith(T, self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `Buffer` instance to lowercase.
            pub fn toLower(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toLower(T, self.m_src[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `Buffer` instance to uppercase.
            pub fn toUpper(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toUpper(T, self.m_src[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `Buffer` instance to title case.
            pub fn toTitle(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toTitle(T, self.m_src[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `Buffer` instance equals the given target slice.
            pub fn isEqual(self: Self, target: []const T) bool {
                return utils.chars.equals(T, self.src(), target);
            }

            /// Returns `true` if the `Buffer` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `Buffer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const T, index: usize) ?[]const T {
                return utils.chars.split(T, self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `Buffer` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const T, includeEmpty: bool) ![]const []const T {
                return utils.chars.splitAll(T, allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `Buffer` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `Buffer` instance.
            pub fn splitToSelf(self: Self, delimiters: []const T, index: usize) CapacityError!?Self {
                if (self.split(delimiters, index)) |block| {
                    if(block.len > initial_size) return error.OutOfMemory;
                    const s = Self.initWithSlice(block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `Buffer` into all substrings separated by the specified delimiters,
            /// returning an array of new `Buffer` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Self, allocator: Allocator, delimiters: []const T) ![]Self {
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

            /// Reverses the order of the chars in the `Buffer` instance (considering Unicode).
            pub fn reverse(self: *Self) void {
                if (self.m_len == 0) return;
                const cloned = self.clone();
                var unicode_iterator = utils.unicode.Iterator.initUnchecked(cloned.src());
                var i: usize = self.m_len;

                while (unicode_iterator.nextGraphemeClusterSlice()) |gc| {
                    i -= gc.len;
                    @memcpy(self.m_src[i..i + gc.len], gc);
                    if (i == 0) break; // to avoid underflow.
                }
            }

            /// Prints the contents of the `Buffer` instance to the given writer.
            pub fn printTo(self: Self, _writer: anytype) !void {
                return help.printTo(self, _writer);
            }

            /// Prints the contents of the `Buffer` instance to the standard writer.
            pub fn print(self: Self) !void {
                return help.print(self);
            }

            /// Prints the contents of the `Buffer` instance to the standard writer and adds a newline.
            pub fn printWithNewline(self: Self) !void {
                return help.printWithNewline(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Internal ─────────────────────────┐

            inline fn makeArrayAndFillWithSlice(chars: []const T) [initial_size]T {
                var buffer : [initial_size]T = undefined;
                if(initial_size > 0 and chars.len > 0) {
                    const buff_len = @min(initial_size, chars.len);
                    @memcpy(buffer[0..buff_len], chars[0..buff_len]);
                    if(buff_len < initial_size) buffer[buff_len] = 0;
                }
                return buffer;
            }

            inline fn makeBufferAndFillWithFmt(comptime fmt: []const T, args: anytype) CapacityError!Self {
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

        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ uString ═════════════════════════════════════╗

    /// Unmanaged dynamic-size string type that supports unicode.
    pub fn uString(comptime T: type) type {
        return struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            const Self = @This();

            /// -
            const WriterContext = struct { self: *Self, allocator: Allocator, };

            /// Writer for the `uString` type.
            pub const Writer = std.io.Writer(WriterContext, Allocator.Error, write);

            /// The mutable unicode encoded chars.
            m_src: []T = &[_]T{},

            /// The number of written chars.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `uString` instance.
            /// The purpose of this function is to integrate the API.
            pub fn initEmpty() Self {
                return .{ };
            }

            /// Initializes a new empty `uString` instance with the specified allocator.
            /// The purpose of this function is to integrate the API.
            pub fn initWithAllocator(allocator: Allocator) Allocator.Error!Self {
                return Self.initWithCapacity(allocator, 0);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `capacity`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithCapacity(allocator: Allocator, initial_capacity: usize) Allocator.Error!Self {
                var self : Self = .{ };
                try help.ensureCapacity(Self, &self, allocator, initial_capacity);
                return self;
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `chars`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSlice(allocator: Allocator, initial_slice: []const T) Allocator.Error!Self {
                return help.initWithSlice(Self, allocator, initial_slice);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `char`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithChar(allocator: Allocator, initial_char: T) Allocator.Error!Self {
                return help.initWithChar(Self, allocator, initial_char);
            }

            /// Initializes a new `uString` instance with the specified allocator and initial `uString`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSelf(allocator: Allocator, initial_self: Self) Allocator.Error!Self {
                return help.initWithSelf(Self, allocator, initial_self);
            }

            /// Initializes a `uString` instance with the specified allocator and formatted string.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithFmt(allocator: Allocator, comptime fmt: []const T, args: anytype) Allocator.Error!Self {
                return help.initWithFmt(Self, allocator, fmt, args);
            }

            /// Initializes a `uString` instance with the specified allocator and anytype.
            /// the value will be converted to a string if necessary.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn init(allocator: Allocator, initial_value: anytype) Allocator.Error!Self {
                return help.init(Self, allocator, initial_value);
            }

            /// Releases all allocated memory associated with the `uString` instance.
            pub fn deinit(self: Self, allocator: Allocator) void {
                return help.deinit(Self, self, allocator);
            }

            /// Releases all allocated memory associated with the `String` instance.
            /// The purpose of this method is to integrate with the internal API.
            pub fn deinitWithAllocator(self: Self, allocator: Allocator) void {
                return self.deinit(allocator);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the type used to represent a single character in this container.
            pub inline fn getType() type {
                return T;
            }

            /// Returns the number of chars that can be written.
            pub inline fn size(self: Self) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written chars.
            pub inline fn len(self: Self) usize {
                return self.m_len;
            }

            /// Returns the total number of visual chars in the `uString` instance.
            pub inline fn vlen(self: Self) usize {
                return if(self.len() > 0) utils.chars.countVisual(T, self.src()) else 0;
            }

            /// Returns a slice representing the entire allocated memory range.
            pub inline fn allocatedSlice(self: Self) []T {
                return self.m_src[0..self.size()];
            }

            /// Returns a slice containing only the written part of the `uString`.
            pub inline fn src(self: Self) []const T {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `uString`.
            pub inline fn sub(self: Self, start: usize, end: usize) RangeError![]const T {
                return help.sub(Self, self, start, end);
            }

            /// Returns a [:0]const u8 slice containing only the written part of the `String`.
            pub inline fn cString(self: *Self, alloc: Allocator) Allocator.Error![:0]const u8 {
                return help.cString(Self, self, alloc);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Self, index: usize) ?T {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Self, visual_pos: usize) ?[]const T {
                return help.atVisual(Self, self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode chars in the `uString`.
            pub inline fn iterator(self: Self) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *Self, allocator: Allocator) Writer {
                return .{ .context = .{ .self = self, .allocator = allocator } };
            }

            /// Initializes a Writer which will append to the list.
            /// The purpose of this method is to integrate with the internal/common methods.
            pub inline fn writerWithAllocator(self: *Self, allocator: Allocator) Writer {
                return writer(self, allocator);
            }

            /// Writes the given slice to the `uString` instance.
            fn write(self: WriterContext, m: []const T) Allocator.Error!usize {
                try self.self.appendSlice(self.allocator, m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = help.InsertError;

            /// Inserts a slice into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *Self, allocator: Allocator, slice: []const T, pos: usize) InsertError!void {
                try help.insertSlice(Self, self, allocator, slice, pos);
            }

            /// Inserts a char into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertChar(self: *Self, allocator: Allocator, char: T, pos: usize) InsertError!void {
                try help.insertChar(Self, self, allocator, char, pos);
            }

            /// Inserts a `uString` into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn insertSelf(self: *Self, allocator: Allocator, string: Self, pos: usize) InsertError!void {
                try self.insertSlice(allocator, string.src(), pos);
            }

            /// Inserts a formatted string into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *Self, allocator: Allocator, comptime fmt: []const T, args: anytype, pos: usize) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.insertSelf(allocator, temp, pos);
            }

            /// Inserts a value from anytype into the `uString` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *Self, allocator: Allocator, initial_value: anytype, pos: usize) InsertError!void {
                if(utils.chars.isChar(T, initial_value)) try self.insertChar(allocator, initial_value, pos)
                else if(utils.chars.isSlice(T, initial_value)) try self.insertSlice(allocator, initial_value, pos)
                else if(@TypeOf(initial_value) == Self) try self.insertSelf(allocator, initial_value, pos)
                else try self.insertFmt(allocator, "", initial_value, pos);
            }

            /// Inserts a slice into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *Self, allocator: Allocator, slice: []const T, visual_pos: usize) InsertError!void {
                try help.visualInsertSlice(Self, self, allocator, slice, visual_pos);
            }

            /// Inserts a char into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertChar(self: *Self, allocator: Allocator, char: T, visual_pos: usize) InsertError!void {
                try help.visualInsertChar(Self, self, allocator, char, visual_pos);
            }

            /// Inserts a `uString` into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn visualInsertSelf(self: *Self, allocator: Allocator, string: Self, visual_pos: usize) InsertError!void {
                try self.visualInsertSlice(allocator, string.src(), visual_pos);
            }

            /// Inserts a formatted string into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *Self, allocator: Allocator, comptime fmt: []const T, args: anytype, visual_pos: usize) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.visualInsertSelf(allocator, temp, visual_pos);
            }

            /// Inserts a value from anytype into the `uString` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *Self, allocator: Allocator, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.chars.isChar(T, initial_value)) try self.visualInsertChar(allocator, initial_value, visual_pos)
                else if(utils.chars.isSlice(T, initial_value)) try self.visualInsertSlice(allocator, initial_value, visual_pos)
                else if(@TypeOf(initial_value) == Self) try self.visualInsertSelf(allocator, initial_value, visual_pos)
                else try self.visualInsertFmt(allocator, "", initial_value, visual_pos);
            }

            /// Appends a slice to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSlice(self: *Self, allocator: Allocator, slice: []const T) Allocator.Error!void {
                try help.appendSlice(Self, self, allocator, slice);
            }

            /// Appends a char to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendChar(self: *Self, allocator: Allocator, char: T) Allocator.Error!void {
                try help.appendChar(Self, self, allocator, char);
            }

            /// Appends a `uString` to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSelf(self: *Self, allocator: Allocator, string: Self) Allocator.Error!void {
                try self.appendSlice(allocator, string.src());
            }

            /// Appends a formatted string to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendFmt(self: *Self, allocator: Allocator, comptime fmt: []const T, args: anytype) Allocator.Error!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.appendSlice(allocator, temp.src());
            }

            /// Appends a value from anytype to the end of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn append(self: *Self, allocator: Allocator, initial_value: anytype) Allocator.Error!void {
                if(utils.chars.isChar(T, initial_value)) try self.appendChar(allocator, initial_value)
                else if(utils.chars.isSlice(T, initial_value)) try self.appendSlice(allocator, initial_value)
                else if(@TypeOf(initial_value) == Self) try self.appendSelf(allocator, initial_value)
                else try self.appendFmt(allocator, "", initial_value);
            }

            /// Prepends a slice to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSlice(self: *Self, allocator: Allocator, slice: []const T) InsertError!void {
                try help.insertSlice(Self, self, allocator, slice, 0);
            }

            /// Prepends a char to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependChar(self: *Self, allocator: Allocator, char: T) InsertError!void {
                try help.insertChar(Self, self, allocator, char, 0);
            }

            /// Prepends a `uString` to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSelf(self: *Self, allocator: Allocator, string: Self) InsertError!void {
                try self.prependSlice(allocator, string.src());
            }

            /// Prepends a formatted string to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependFmt(self: *Self, allocator: Allocator, comptime fmt: []const T, args: anytype) InsertError!void {
                const temp = try initWithFmt(allocator, fmt, args);
                defer temp.deinit(allocator);
                try self.prependSlice(allocator, temp.src());
            }

            /// Prepends a value from anytype to the beginning of the `uString` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prepend(self: *Self, allocator: Allocator, initial_value: anytype) InsertError!void {
                if(utils.chars.isChar(T, initial_value)) try self.prependChar(allocator, initial_value)
                else if(utils.chars.isSlice(T, initial_value)) try self.prependSlice(allocator, initial_value)
                else if(@TypeOf(initial_value) == Self) try self.prependSelf(allocator, initial_value)
                else try self.prependFmt(allocator, "", initial_value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = help.removeIndexError;
            pub const removeVisualIndexError = help.removeVisualIndexError;

            /// Removes a char from the `uString` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *Self, pos: usize) removeIndexError!void {
                return help.removeIndex(Self, self, pos);
            }

            /// Removes a char from the `uString` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *Self, visual_pos: usize) removeVisualIndexError![]const T {
                return help.removeVisualIndex(Self, self, visual_pos);
            }

            /// Removes a range of chars from the `uString` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *Self, pos: usize, length: usize) removeIndexError!void {
                return help.removeRange(Self, self, pos, length);
            }

            /// Removes a range of chars from the `uString` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, visual_pos: usize, length: usize) removeVisualIndexError![]const T {
                return help.removeVisualRange(Self, self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `uString` instance.
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const T {
                return help.pop(Self, self);
            }

            /// Removes the first grapheme cluster from the `uString` instance.
            /// Returns the number of removed chars.
            pub fn shift(self: *Self) usize {
                return help.shift(Self, self);
            }

            /// Trims whitespace from both ends of the `uString` instance.
            pub fn trim(self: *Self) void {
                return help.trim(self);
            }

            /// Trims whitespace from the start of the `uString` instance.
            pub fn trimStart(self: *Self) void {
                return help.trimStart(self);
            }

            /// Trims whitespace from the end of the `uString` instance.
            pub fn trimEnd(self: *Self) void {
                return help.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of chars with another slice in the `uString`.
            pub fn replaceRange(self: *Self, allocator: Allocator, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceRange(Self, self, allocator, start, length, replacement);
            }

            /// Replaces a visual range of chars with another slice in the `uString`.
            pub fn replaceVisualRange(self: *Self, allocator : Allocator, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceVisualRange(Self, self, allocator, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `uString`.
            pub fn replaceFirst(self: *Self, allocator : Allocator, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceFirst(Self, self, allocator, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `uString`.
            pub fn replaceFirstN(self: *Self, allocator : Allocator, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceFirstN(Self, self, allocator, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `uString`.
            pub fn replaceLast(self: *Self, allocator : Allocator, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceLast(Self, self, allocator, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `uString`.
            pub fn replaceLastN(self: *Self, allocator : Allocator, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceLastN(Self, self, allocator, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `uString`.
            pub fn replaceAll(self: *Self, allocator : Allocator, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceAll(Self, self, allocator, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `uString`.
            pub fn replaceNth(self: *Self, allocator : Allocator, target: []const T, replacement: []const T, nth: usize) InsertError!void {
                try help.replaceNth(Self, self, allocator, target, replacement, nth);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a char `count` times and appends it to the `uString` instance.
            pub fn repeat(self: *Self, allocator : Allocator, char: T, count: usize) InsertError!void {
                try help.appendNTimes(Self, self, allocator, char, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Self, target: []const T) ?usize {
                return utils.chars.find(T, self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findVisual(T, self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Self, target: []const T) ?usize {
                return utils.chars.findLast(T, self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findLastVisual(T, self.src(), target);
            }

            /// Returns `true` if the `uString` instance contains the target slice.
            pub fn includes(self: Self, target: []const T) bool {
                return utils.chars.includes(T, self.src(), target);
            }

            /// Returns `true` if the `uString` instance starts with the target slice.
            pub fn startsWith(self: Self, target: []const T) bool {
                return utils.chars.startsWith(T, self.src(), target);
            }

            /// Returns `true` if the `uString` instance ends with the target slice.
            pub fn endsWith(self: Self, target: []const T) bool {
                return utils.chars.endsWith(T, self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `uString` instance to lowercase.
            pub fn toLower(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toLower(T, self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `uString` instance to uppercase.
            pub fn toUpper(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toUpper(T, self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `uString` instance to title case.
            pub fn toTitle(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toTitle(T, self.allocatedSlice()[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `uString` instance equals the given target slice.
            pub fn isEqual(self: Self, target: []const T) bool {
                return utils.chars.equals(T, self.src(), target);
            }

            /// Returns `true` if the `uString` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `uString` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const T, index: usize) ?[]const T {
                return utils.chars.split(T, self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `uString` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const T, includeEmpty: bool) ![]const []const T {
                return utils.chars.splitAll(T, allocator, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `uString` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `uString` instance.
            pub fn splitToSelf(self: Self, allocator: Allocator, delimiters: []const T, index: usize) Allocator.Error!?Self {
                if (self.split(delimiters, index)) |block| {
                    const s = try Self.initWithSlice(allocator, block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `uString` into all substrings separated by the specified delimiters,
            /// returning an array of new `uString` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Self, allocator: Allocator, delimiters: []const T) Allocator.Error![]Self {
                var splitArr = std.ArrayList(Self).init(allocator);
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
            pub fn clone(self: Self, allocator: Allocator) Allocator.Error!Self {
                return Self.initWithSelf(allocator, self);
            }

            /// Reverses the order of the chars in the `uString` instance (considering Unicode).
            pub fn reverse(self: *Self, allocator: Allocator) Allocator.Error!void {
                return help.reverse(Self, self, allocator);
            }

            /// Reduce allocated capacity to `new_len`.
            pub fn shrinkAndFree(self: *Self, allocator: Allocator, new_len: usize) void {
                help.shrinkAndFree(Self, self, allocator, new_len);
            }

            /// Reduce length to `new_len`.
            pub fn shrink(self: *Self, new_len: usize) void {
                if(new_len < self.m_len) self.m_len = new_len;
            }

            /// Adjust the `uString` instance length to `new_len`.
            pub fn resize(self: *Self, allocator: Allocator, new_len: usize) Allocator.Error!void {
                return help.resize(Self, self, allocator, new_len);
            }

            /// Clears the contents of the `uString`.
            pub fn clear(self: *Self) void {
                self.m_len = 0;
            }

            /// Clears the contents of the `uString` and frees its memory, invalidating all pointers.
            pub fn clearAndFree(self: *Self, allocator: Allocator) void {
                help.clearAndFree(Self, self, allocator);
            }

            /// Initializes a new `uString` instance from an owned slice of chars.
            pub fn fromOwnedSlice(slice: []T) Self {
                return Self{
                    .m_src = slice,
                    .m_len = slice.len,
                };
            }

            /// Transfers ownership of the `uString`'s memory to the caller, emptying the `uString` and resetting its capacity.
            pub fn toOwnedSlice(self: *Self, allocator: Allocator) Allocator.Error![]T {
                return help.toOwnedSlice(Self, self, allocator);
            }

            /// Converts the `uString` into a managed `String`, transferring ownership of its memory.
            pub fn toManaged(self: *Self, allocator: Allocator) String(T) {
                return .{ .m_src = self.m_src, .m_len = self.m_len, .m_alloc = allocator };
            }

            /// Converts the `uString` instance to a `Viewer`.
            pub fn toViewer(self: Self) Viewer(T) {
                return Viewer(T).initWithSlice(self.src());
            }

            /// Prints the contents of the `uString` instance to the given writer.
            pub fn printTo(self: Self, _writer: anytype) !void {
                return help.printTo(self, _writer);
            }

            /// Prints the contents of the `uString` instance to the standard writer.
            pub fn print(self: Self) !void {
                return help.print(self);
            }

            /// Prints the contents of the `uString` instance to the standard writer and adds a newline.
            pub fn printWithNewline(self: Self) !void {
                return help.printWithNewLine(self);
            }

        // └──────────────────────────────────────────────────────────────┘

        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ String ═════════════════════════════════════╗

    /// Managed dynamic-size string type that supports unicode.
    pub fn String(comptime T: type) type {
        return struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            const Self = @This();

            /// Writer for the `String` type.
            pub const Writer = std.io.Writer(*Self, Allocator.Error, write);

            /// Allocator used for memory management.
            m_alloc: Allocator = undefined,

            /// The mutable unicode encoded chars.
            m_src: []T = &[_]T{},

            /// The number of written chars.
            m_len: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new empty `String` instance with the specified allocator.
            /// The purpose of this function is to integrate the API.
            pub fn initEmpty(allocator: Allocator) Allocator.Error!Self {
                return .{ .m_alloc = allocator };
            }

            /// Initializes a new empty `String` instance with the specified allocator.
            pub fn initWithAllocator(allocator: Allocator) Allocator.Error!Self {
                return Self.initWithCapacity(allocator, 0);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `capacity`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithCapacity(allocator: Allocator, initial_capacity: usize) Allocator.Error!Self {
                var self : Self = .{ .m_alloc = allocator };
                try help.ensureCapacity(Self, &self, allocator, initial_capacity);
                return self;
            }

            /// Initializes a new `String` instance with the specified allocator and initial `chars`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSlice(allocator: Allocator, initial_slice: []const T) Allocator.Error!Self {
                return help.initWithSlice(Self, allocator, initial_slice);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `char`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithChar(allocator: Allocator, initial_char: T) Allocator.Error!Self {
                return help.initWithChar(Self, allocator, initial_char);
            }

            /// Initializes a new `String` instance with the specified allocator and initial `Self`.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithSelf(allocator: Allocator, initial_self: Self) Allocator.Error!Self {
                return help.initWithSelf(Self, allocator, initial_self);
            }

            /// Initializes a `String` instance with the specified allocator and formatted string.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn initWithFmt(allocator: Allocator, comptime fmt: []const T, args: anytype) Allocator.Error!Self {
                return help.initWithFmt(Self, allocator, fmt, args);
            }

            /// Initializes a `String` instance with the specified allocator and anytype.
            /// the value will be converted to a string if necessary.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn init(allocator: Allocator, initial_value: anytype) Allocator.Error!Self {
                return help.init(Self, allocator, initial_value);
            }

            /// Releases all allocated memory associated with the `String` instance.
            pub fn deinit(self: Self) void {
                return help.deinit(Self, self, self.m_alloc);
            }

            /// Releases all allocated memory associated with the `String` instance.
            /// The purpose of this method is to integrate with the internal API.
            pub fn deinitWithAllocator(self: Self, _: Allocator) void {
                return self.deinit();
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the type used to represent a single character in this container.
            pub inline fn getType() type {
                return T;
            }

            /// Returns the number of chars that can be written.
            pub inline fn size(self: Self) usize {
                return self.m_src.len;
            }

            /// Returns the total number of written chars.
            pub inline fn len(self: Self) usize {
                return self.m_len;
            }

            /// Returns the total number of visual chars in the `String` instance.
            pub inline fn vlen(self: Self) usize {
                return if(self.len() > 0) utils.chars.countVisual(T, self.src()) else 0;
            }

            /// Returns a slice containing only the written part of the `String`.
            pub inline fn src(self: Self) []const T {
                return if(self.len() > 0) self.m_src[0..self.len()] else "";
            }

            /// Returns a sub-slice of the `String`.
            pub inline fn sub(self: Self, start: usize, end: usize) RangeError![]const T {
                return help.sub(Self, self, start, end);
            }

            /// Returns a slice representing the entire allocated memory range.
            pub inline fn allocatedSlice(self: Self) []T {
                return self.m_src[0..self.size()];
            }

            /// Returns a [:0]const u8 slice containing only the written part of the `String`.
            pub inline fn cString(self: *Self) Allocator.Error![:0]const u8 {
                comptime if (Self.getType() != u8) @compileError("cString is only available for u8");
                return help.cString(Self, self, self.m_alloc);
            }

            /// Returns a character at the specified index.
            pub inline fn charAt(self: Self, index: usize) ?T {
                return if(index >= self.len()) null else self.m_src[index];
            }

            /// Returns a character at the specified visual position.
            pub inline fn atVisual(self: Self, visual_pos: usize) ?[]const T {
                return help.atVisual(Self, self, visual_pos);
            }

            /// Creates an iterator for traversing the Unicode chars in the `String`.
            pub inline fn iterator(self: Self) Iterator {
                return Iterator.initUnchecked(self.src());
            }

            /// Initializes a Writer which will append to the list.
            pub inline fn writer(self: *Self) Writer {
                return .{ .context = self };
            }

            /// Initializes a Writer which will append to the list.
            /// The purpose of this method is to integrate with the internal/common methods.
            pub inline fn writerWithAllocator(self: *Self, _: Allocator) Writer {
                return .{ .context = self };
            }

            /// Writes the given slice to the `String` instance.
            fn write(self: *Self, m: []const T) Allocator.Error!usize {
                try self.appendSlice(m);
                return m.len;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const InsertError = help.InsertError;

            /// Inserts a slice into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertSlice(self: *Self, slice: []const T, pos: usize) InsertError!void {
                try help.insertSlice(Self, self, self.m_alloc, slice, pos);
            }

            /// Inserts a char into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertChar(self: *Self, char: T, pos: usize) InsertError!void {
                try help.insertChar(Self, self, self.m_alloc, char, pos);
            }

            /// Inserts a `String` into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn insertSelf(self: *Self, string: Self, pos: usize) InsertError!void {
                try self.insertSlice(string.src(), pos);
            }

            /// Inserts a formatted string into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insertFmt(self: *Self, comptime fmt: []const T, args: anytype, pos: usize) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.insertSelf(temp, pos);
            }

            /// Inserts a value from anytype into the `String` instance at the specified position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn insert(self: *Self, value: anytype, pos: usize) InsertError!void {
                if(utils.chars.isChar(T, value)) return self.insertChar(value, pos)
                else if(utils.chars.isSlice(T, value)) return self.insertSlice(value, pos)
                else if(@TypeOf(value) == self) return self.insertSelf(value, pos)
                else return self.insertFmt("", value, pos);
            }

            /// Inserts a slice into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertSlice(self: *Self, slice: []const T, visual_pos: usize) InsertError!void {
                try help.visualInsertSlice(Self, self, self.m_alloc, slice, visual_pos);
            }

            /// Inserts a char into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertChar(self: *Self, char: T, visual_pos: usize) InsertError!void {
                try help.visualInsertChar(Self, self, self.m_alloc, char, visual_pos);
            }

            /// Inserts a `String` into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn visualInsertSelf(self: *Self, string: Self, visual_pos: usize) InsertError!void {
                try self.visualInsertSlice(string.src(), visual_pos);
            }

            /// Inserts a formatted string into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `InsertError.OutOfRange` **if the `position` is invalid or greater than `self.size()``.**
            pub fn visualInsertFmt(self: *Self, comptime fmt: []const T, args: anytype, visual_pos: usize) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.visualInsertSelf(temp, visual_pos);
            }

            /// Inserts a value from anytype into the `String` instance at the specified visual position.
            /// - `Allocator.Error` **if the allocator returned an error.**
            /// - `error.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn visualInsert(self: *Self, initial_value: anytype, visual_pos: usize) InsertError!void {
                if(utils.chars.isChar(T, initial_value)) try self.visualInsertChar(initial_value, visual_pos)
                else if(utils.chars.isSlice(T, initial_value)) try self.visualInsertSlice(initial_value, visual_pos)
                else if(@TypeOf(initial_value) == Self) try self.visualInsertSelf(initial_value, visual_pos)
                else try self.visualInsertFmt("", initial_value, visual_pos);
            }

            /// Appends a slice to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendSlice(self: *Self, slice: []const T) Allocator.Error!void {
                try help.appendSlice(Self, self, self.m_alloc, slice);
            }

            /// Appends a char to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendChar(self: *Self, char: T) Allocator.Error!void {
                try help.appendChar(Self, self, self.m_alloc, char);
            }

            /// Appends a `String` to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn appendSelf(self: *Self, string: Self) Allocator.Error!void {
                try self.appendSlice(string.src());
            }

            /// Appends a formatted string to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn appendFmt(self: *Self, comptime fmt: []const T, args: anytype) Allocator.Error!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.appendSelf(temp);
            }

            /// Appends a value from anytype to the end of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn append(self: *Self, value: anytype) Allocator.Error!void {
                if(utils.chars.isChar(T, value)) return self.appendChar(value)
                else if(utils.chars.isSlice(T, value)) return self.appendSlice(value)
                else if(@TypeOf(value) == self) return self.appendSelf(value)
                else return self.appendFmt("", value);
            }

            /// Prepends a slice to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependSlice(self: *Self, slice: []const T) InsertError!void {
                try help.insertSlice(Self, self, self.m_alloc, slice, 0);
            }

            /// Prepends a char to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependChar(self: *Self, char: T) InsertError!void {
                try help.insertChar(Self, self, self.m_alloc, char, 0);
            }

            /// Prepends a `Srting` to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            ///
            /// Modifies `self` instance in place **if the `string` length is greater than 0.**
            pub fn prependSelf(self: *Self, string: Self) InsertError!void {
                try self.prependSlice(string.src());
            }

            /// Prepends a formatted string to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prependFmt(self: *Self, comptime fmt: []const T, args: anytype) InsertError!void {
                const temp = try initWithFmt(self.m_alloc, fmt, args);
                defer temp.deinit();
                try self.prependSelf(temp);
            }

            /// Prepends a value from anytype to the beginning of the `String` instance.
            /// - `Allocator.Error` **if the allocator returned an error.**
            pub fn prepend(self: *Self, value: anytype) InsertError!void {
                if(utils.chars.isChar(T, value)) return self.prependChar(value)
                else if(utils.chars.isSlice(T, value)) return self.prependSlice(value)
                else if(@TypeOf(value) == self) return self.prependSelf(value)
                else return self.prependFmt("", value);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeIndexError = help.removeIndexError;
            pub const removeVisualIndexError = help.removeVisualIndexError;

            /// Removes a char from the `String` instance at the specified position.
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeIndex(self: *Self, pos: usize) removeIndexError!void {
                return help.removeIndex(Self, self, pos);
            }

            /// Removes a char from the `String` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualIndex(self: *Self, visual_pos: usize) removeVisualIndexError![]const T {
                return help.removeVisualIndex(Self, self, visual_pos);
            }

            /// Removes a range of chars from the `String` instance.
            /// - `removeIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            pub fn removeRange(self: *Self, pos: usize, length: usize) removeIndexError!void {
                return help.removeRange(Self, self, pos, length);
            }

            /// Removes a range of chars from the `String` instance by the specified visual position.
            /// - `removeVisualIndexError.InvalidPosition` **if the `position` is invalid.**
            /// - `removeVisualIndexError.OutOfRange` **if the `position` is greater than `self.size()``.**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, visual_pos: usize, length: usize) removeVisualIndexError![]const T {
                return help.removeVisualRange(Self, self, visual_pos, length);
            }

            /// Removes the last grapheme cluster from the `String` instance.
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const T {
                return help.pop(Self, self);
            }

            /// Removes the first grapheme cluster from the `String` instance.
            /// Returns the number of removed chars.
            pub fn shift(self: *Self) usize {
                return help.shift(Self, self);
            }

            /// Trims whitespace from both ends of the `String` instance.
            pub fn trim(self: *Self) void {
                return help.trim(self);
            }

            /// Trims whitespace from the start of the `String` instance.
            pub fn trimStart(self: *Self) void {
                return help.trimStart(self);
            }

            /// Trims whitespace from the end of the `String` instance.
            pub fn trimEnd(self: *Self) void {
                return help.trimEnd(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces a range of chars with another slice in the `String`.
            pub fn replaceRange(self: *Self, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceRange(Self, self, self.m_alloc, start, length, replacement);
            }

            /// Replaces a visual range of chars with another slice in the `String`.
            pub fn replaceVisualRange(self: *Self, start: usize, length: usize, replacement: []const T) InsertError!void {
                try help.replaceVisualRange(Self, self, self.m_alloc, start, length, replacement);
            }

            /// Replaces the first occurrence of a slice with another slice in the `String`.
            pub fn replaceFirst(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceFirst(Self, self, self.m_alloc, target, replacement);
            }

            /// Replaces the first N(count) occurrence of a slice with another slice in the `String`.
            pub fn replaceFirstN(self: *Self, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceFirstN(Self, self, self.m_alloc, target, replacement, count);
            }

            /// Replaces the last occurrence of a slice with another slice in the `String`.
            pub fn replaceLast(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceLast(Self, self, self.m_alloc, target, replacement);
            }

            /// Replaces the last N(count) occurrence of a slice with another slice in the `String`.
            pub fn replaceLastN(self: *Self, target: []const T, replacement: []const T, count: usize) InsertError!void {
                try help.replaceLastN(Self, self, self.m_alloc, target, replacement, count);
            }

            /// Replaces all occurrences of a slice with another slice in the `String`.
            pub fn replaceAll(self: *Self, target: []const T, replacement: []const T) InsertError!void {
                try help.replaceAll(Self, self, self.m_alloc, target, replacement);
            }

            /// Replaces the `nth` occurrence of a slice with another slice in the `String`.
            pub fn replaceNth(self: *Self, target: []const T, replacement: []const T, nth: usize) InsertError!void {
                try help.replaceNth(Self, self, self.m_alloc, target, replacement, nth);
            }


        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Repeat ───────────────────────────┐

            /// Repeats a char `count` times and appends it to the `String` instance.
            pub fn repeat(self: *Self, char: T, count: usize) InsertError!void {
                try help.appendNTimes(Self, self, self.m_alloc, char, count);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐


            /// Finds the position of the **first** occurrence of the target slice.
            pub fn find(self: Self, target: []const T) ?usize {
                return utils.chars.find(T, self.src(), target);
            }

            /// Finds the visual position of the **first** occurrence of the target slice.
            pub fn findVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findVisual(T, self.src(), target);
            }

            /// Finds the position of the **last** occurrence of the target slice.
            pub fn findLast(self: Self, target: []const T) ?usize {
                return utils.chars.findLast(T, self.src(), target);
            }

            /// Finds the visual position of the **last** occurrence of the target slice.
            pub fn findLastVisual(self: Self, target: []const T) ?usize {
                return utils.chars.findLastVisual(T, self.src(), target);
            }

            /// Returns `true` if the `String` instance contains the target slice.
            pub fn includes(self: Self, target: []const T) bool {
                return utils.chars.includes(T, self.src(), target);
            }

            /// Returns `true` if the `String` instance starts with the target slice.
            pub fn startsWith(self: Self, target: []const T) bool {
                return utils.chars.startsWith(T, self.src(), target);
            }

            /// Returns `true` if the `String` instance ends with the target slice.
            pub fn endsWith(self: Self, target: []const T) bool {
                return utils.chars.endsWith(T, self.src(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters in the `String` instance to lowercase.
            pub fn toLower(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toLower(T, self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `String` instance to uppercase.
            pub fn toUpper(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toUpper(T, self.allocatedSlice()[0..self.m_src.len]);
            }

            /// Converts all (ASCII) letters in the `String` instance to title case.
            pub fn toTitle(self: *Self) void {
                if (self.m_src.len > 0)
                utils.chars.toTitle(T, self.allocatedSlice()[0..self.m_src.len]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Check ───────────────────────────┐

            /// Returns `true` if the `String` instance equals the given target slice.
            pub fn isEqual(self: Self, target: []const T) bool {
                return utils.chars.equals(T, self.src(), target);
            }

            /// Returns `true` if the `String` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return self.m_len == 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the `String` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const T, index: usize) ?[]const T {
                return utils.chars.split(T, self.src(), self.len(), delimiters, index);
            }

            /// Splits the written portion of the `String` into all substrings separated by the specified delimiters,
            /// returning an array of slices. Caller must free the returned memory.
            /// `includeEmpty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, delimiters: []const T, includeEmpty: bool) ![]const []const T {
                return utils.chars.splitAll(T, self.m_alloc, self.src(), self.len(), delimiters, includeEmpty);
            }

            /// Splits the written portion of the `String` into substrings separated by the specified delimiters,
            /// returning the substring at the specified index as a new `String` instance.
            pub fn splitToSelf(self: Self, delimiters: []const T, index: usize) Allocator.Error!?Self {
                if (self.split(delimiters, index)) |block| {
                    const s = try Self.initWithSlice(self.m_alloc, block);
                    return s;
                }

                return null;
            }

            /// Splits the written portion of the `String` into all substrings separated by the specified delimiters,
            /// returning an array of new `String` instances. Caller must free the returned memory.
            pub fn splitAllToSelf(self: Self, delimiters: []const T) Allocator.Error![]Self {
                var splitArr = std.ArrayList(Self).init(self.m_alloc);
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
            pub fn clone(self: Self) Allocator.Error!Self {
                return Self.initWithSelf(self.m_alloc, self);
            }

            /// Reverses the order of the chars in the `String` instance (considering Unicode).
            pub fn reverse(self: *Self) Allocator.Error!void {
                return help.reverse(Self, self, self.m_alloc);
            }

            /// Reduce allocated capacity to `new_len`.
            pub fn shrinkAndFree(self: *Self, new_len: usize) void {
                help.shrinkAndFree(Self, self, self.m_alloc, new_len);
            }

            /// Reduce length to `new_len`.
            pub fn shrink(self: *Self, new_len: usize) void {
                if(new_len < self.m_len) self.m_len = new_len;
            }

            /// Adjust the `String` instance length to `new_len`.
            pub fn resize(self: *Self, new_len: usize) Allocator.Error!void {
                return help.resize(Self, self, self.m_alloc, new_len);
            }

            /// Clears the contents of the `String`.
            pub fn clear(self: *Self) void {
                self.m_len = 0;
            }

            /// Clears the contents of the `String` and frees its memory, invalidating all pointers.
            pub fn clearAndFree(self: *Self) void {
                help.clearAndFree(Self, self, self.m_alloc);
            }

            /// Initializes a new `String` from the given owned slice.
            pub fn fromOwnedSlice(allocator: Allocator, slice: []T) Self {
                return Self{
                    .m_src = slice,
                    .m_len = slice.len,
                    .m_alloc = allocator,
                };
            }

            /// Transfers ownership of the `String`'s memory to the caller, emptying the `String` and resetting its capacity.
            pub fn toOwnedSlice(self: *Self) Allocator.Error![]T {
                return help.toOwnedSlice(Self, self, self.m_alloc);
            }

            /// Converts the `String` into an unmanaged `uString`, transferring ownership of its memory.
            pub fn toUnmanaged(self: *Self) uString(T) {
                const allocator = self.m_alloc;
                const result: uString(T) = .{ .m_src = self.m_src, .m_len = self.m_len };
                self.* = initWithAllocator(allocator) catch unreachable;
                return result;
            }

            /// Converts the `String` instance to a `Viewer`.
            pub fn toViewer(self: Self) Viewer(T) {
                return Viewer(T).initWithSlice(self.src());
            }

            /// Prints the contents of the `String` instance to the given writer.
            pub fn printTo(self: Self, _writer: anytype) !void {
                return help.printTo(self, _writer);
            }

            /// Prints the contents of the `String` instance to the standard writer.
            pub fn print(self: Self) !void {
                return help.print(self);
            }

            /// Prints the contents of the `String` instance to the standard writer and adds a newline.
            pub fn printWithNewline(self: Self) !void {
                return help.printWithNewLine(self);
            }

        // └──────────────────────────────────────────────────────────────┘

        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝