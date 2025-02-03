// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const Unicode = @import("../../utils/Unicode/Unicode.zig");
    const Bytes = @import("../../utils/Bytes/Bytes.zig");
    const Allocator = Bytes.Allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Mutable fixed-size string type that supports Unicode.
    pub fn Buffer(comptime array_size: usize) type {
        return struct {

            // ┌──────────────────────────── ---- ────────────────────────────┐

                const Self = @This();

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── Fields ───────────────────────────┐

                /// The mutable unicode encoded Bytes.
                m_source: [array_size]u8 = .{0} ** array_size,

                /// The number of written bytes to `source`.
                m_length: usize = 0,

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── Insert ───────────────────────────┐

                pub const insertError       = Bytes.insertError;
                pub const insertVisualError = Bytes.insertVisualError;

                /// Inserts a `slice` into the `Buffer` instance at the specified `position` by **real position**.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                /// - `insertError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                ///
                /// Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**
                pub fn insert(self: *Self, _slice: []const u8, pos: usize) insertError!void {
                    try Bytes.insert(&self.m_source, _slice, self.m_length, pos);
                    self.m_length += _slice.len;
                }

                /// Inserts a `byte` into the `Buffer` instance at the specified `position` by **real position**.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                /// - `insertError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void {
                    try Bytes.insertOne(&self.m_source, byte, self.m_length, pos);
                    self.m_length += 1;
                }

                /// Inserts a `slice` into the `Buffer` instance at the specified `visual position`.
                /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
                /// - `insertVisualError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                ///
                /// Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**
                pub fn insertVisual(self: *Self, _slice: []const u8, pos: usize) insertVisualError!void {
                    try Bytes.insertVisual(&self.m_source, _slice, self.m_length, pos);
                    self.m_length += _slice.len;
                }

                /// Inserts a `byte` into the `Buffer` instance at the specified `visual position`.
                /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
                /// - `insertVisualError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void {
                    try Bytes.insertVisualOne(&self.m_source, byte, self.m_length, pos);
                    self.m_length += 1;
                }

                /// Appends a `slice` into the `Buffer` instance.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                ///
                /// Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**
                pub fn append(self: *Self, _slice: []const u8) insertError!void {
                    try Bytes.append(&self.m_source, _slice, self.m_length);
                    self.m_length += _slice.len;
                }

                /// Appends a `byte` into the `Buffer` instance.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                pub fn appendOne(self: *Self, byte: u8) insertError!void {
                    try Bytes.appendOne(&self.m_source, byte, self.m_length);
                    self.m_length += 1;
                }

                /// Prepends a `slice` into the `Buffer` instance.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                ///
                /// Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**
                pub fn prepend(self: *Self, _slice: []const u8) insertError!void {
                    try Bytes.prepend(&self.m_source, _slice, self.m_length);
                    self.m_length += _slice.len;
                }

                /// Prepends a `byte` into the `Buffer` instance.
                /// - `insertError.OutOfRange` **_if the insertion exceeds the bounds of the `Buffer` instance._**
                pub fn prependOne(self: *Self, byte: u8) insertError!void {
                    try Bytes.prependOne(&self.m_source, byte, self.m_length);
                    self.m_length += 1;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── Remove ───────────────────────────┐

                pub const removeError       = Bytes.removeError;
                pub const removeVisualError = Bytes.removeVisualError;

                /// Removes a byte from the `Buffer` instance.
                /// - `removeError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                pub fn remove(self: *Self, pos: usize) removeError!void {
                    try Bytes.remove(&self.m_source, self.m_length, pos);
                    self.m_length -= 1;
                }

                /// Removes a `range` of bytes from the `Buffer` instance.
                /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
                /// - `removeError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void {
                    try Bytes.removeRange(&self.m_source, self.m_length, pos, len);
                    self.m_length -= len;
                }

                /// Removes a byte from the `Buffer` instance by the `visual position`.
                /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
                /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                ///
                /// Returns the removed slice.
                pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8 {
                    const removed_slice = try Bytes.removeVisual(&self.m_source, self.m_length, pos);
                    self.m_length -= removed_slice.len;
                    return removed_slice;
                }

                /// Removes a `range` of bytes from the `Buffer` instance by the `visual position`.
                /// - `removeVisualError.InvalidPosition` **_if the `pos` is invalid._**
                /// - `removeVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
                ///
                /// Returns the removed slice.
                pub fn removeVisualRange(self: *Self, pos: usize, len: usize) removeVisualError![]const u8 {
                    const removed_slice = try Bytes.removeVisualRange(&self.m_source, self.m_length, pos, len);
                    self.m_length -= removed_slice.len;
                    return removed_slice;
                }

                /// Removes the last grapheme cluster at the `Buffer` instance,
                /// Returns the removed slice.
                pub inline fn pop(self: *Self) ?[]const u8 {
                    const len = Bytes.pop(self.m_source[0..self.m_length]);
                    if(len == 0) return null;

                    self.m_length -= len;
                    return self.m_source[self.m_length..self.m_length+len];
                }

                /// Removes the first grapheme cluster at the `Buffer` instance,
                /// Returns the number of removed Bytes.
                pub inline fn shift(self: *Self) usize {
                    const len = Bytes.shift(self.m_source[0..self.m_length]);
                    self.m_length -= len;
                    return len;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Find ────────────────────────────┐

                /// Finds the `position` of the **first** occurrence of `target`.
                pub fn find(self: Self, target: []const u8) ?usize {
                    return Bytes.find(self.m_source[0..self.m_length], target);
                }

                /// Finds the `visual position` of the **first** occurrence of `target`.
                pub fn findVisual(self: Self, target: []const u8) ?usize {
                    return Bytes.findVisual(self.m_source[0..self.m_length], target);
                }

                /// Finds the `position` of the **last** occurrence of `target`.
                pub fn rfind(self: Self, target: []const u8) ?usize {
                    return Bytes.rfind(self.m_source[0..self.m_length], target);
                }

                /// Finds the `visual position` of the **last** occurrence of `target`.
                pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                    return Bytes.rfindVisual(self.m_source[0..self.m_length], target);
                }

                /// Returns `true` **if contains `target`**.
                pub fn includes(self: Self, target: []const u8) bool {
                    return Bytes.includes(self.m_source[0..self.m_length], target);
                }

                /// Returns `true` **if starts with `target`**.
                pub fn startsWith(self: Self, target: []const u8) bool {
                    return Bytes.startsWith(self.m_source[0..self.m_length], target);
                }

                /// Returns `true` **if ends with `target`**.
                pub fn endsWith(self: Self, target: []const u8) bool {
                    return Bytes.endsWith(self.m_source[0..self.m_length], target);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Case ────────────────────────────┐

                /// Converts all (ASCII) letters to lowercase.
                pub fn toLower(self: *Self) void {
                    Bytes.toLower(self.m_source[0..self.m_length]);
                }

                /// Converts all (ASCII) letters to uppercase.
                pub fn toUpper(self: *Self) void {
                    Bytes.toUpper(self.m_source[0..self.m_length]);
                }

                // Converts all (ASCII) letters to titlecase.
                pub fn toTitle(self: *Self) void {
                    Bytes.toTitle(self.m_source[0..self.m_length]);
                }

                /// Reverses the order of the characters **_(considering unicode)_**.
                pub fn reverse(self: *Self) void {
                    if (self.m_length == 0) return;
                    const original_data = self.clone();
                    var unicode_iterator = Unicode.Iterator.unsafeInit(original_data.m_source[0..original_data.m_length]);
                    var i: usize = self.m_length;

                    while (unicode_iterator.nextGraphemeCluster()) |gc| {
                        i -= gc.len;
                        @memcpy(self.m_source[i..i + gc.len], gc);
                        if (i == 0) break; // to avoid underflow.
                    }
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Count ───────────────────────────┐

                /// Returns the total number of written bytes, stopping at the first null byte.
                pub fn length(self: Self) usize {
                    return self.m_length;
                }

                /// Returns the total number of visual characters.
                pub fn vlength(self: Self) usize {
                    return Bytes.countVisual(self.m_source[0..self.m_length]) catch unreachable;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── Iterator ──────────────────────────┐

                /// Creates an iterator for traversing the unicode bytes.
                /// - `Unicode.Iterator.Error` **_if the initialization failed._**
                pub fn iterator(self: Self) Unicode.Iterator.Error!Unicode.Iterator {
                    return Unicode.Iterator.init(self.m_source[0..self.m_length]);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Split ───────────────────────────┐

                /// Splits the written portion of the string into substrings separated by the delimiter,
                /// returning the substring at the specified index.
                pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8 {
                    return Bytes.split(&self.m_source, self.m_length, delimiters, index);
                }

                /// Splits the written portion of the string into all substrings separated by the delimiter,
                /// returning an array of slices. Caller must free the returned memory.
                /// `include_empty` controls whether empty strings are included in the result.
                pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, include_empty: bool) ![]const []const u8 {
                    return Bytes.splitAll(allocator, self.m_source[0..], self.m_length, delimiters, include_empty);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── Replace ──────────────────────────┐

                pub const replaceError = Bytes.replaceError;

                /// Replaces all occurrence of a character with another.
                pub fn replaceAllChars(self: *Self, match: u8, replacement: u8) void {
                    Bytes.replaceAllChars(self.m_source[0..], match, replacement);
                }

                /// Replaces all occurrences of a slice with another.
                pub fn replaceAllSlices(self: *Self, match: []const u8, replacement: []const u8) replaceError!usize {
                    const res = try Bytes.replaceAllSlices(self.m_source[0..], match, replacement);
                    if(res > 0) {
                        self.m_length -= match.len*res;
                        self.m_length += replacement.len*res;
                    }
                    return res;
                }

                /// Replaces a range of bytes with another.
                pub fn replaceRange(self: anytype, start: usize, len: usize, replacement: []const u8) replaceError!void {
                    return Bytes.replaceRange(&self.m_source, self.m_length, start, len, replacement);
                }

                /// Replaces a visual range of bytes with another.
                pub fn replaceVisualRange(self: anytype, start: usize, len: usize, replacement: []const u8) replaceError!void {
                    return Bytes.replaceVisualRange(&self.m_source, self.m_length, start, len, replacement);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Utils ───────────────────────────┐

                /// Returns a copy of the `Buffer` instance.
                pub fn clone(self: Self) Self {
                    return .{
                        .m_source = Bytes.unsafeInit(array_size, self.m_source[0..self.m_length]),
                        .m_length = self.m_length
                    };
                }

                /// Returns true if the `Buffer` instance equals the given `target`.
                pub fn equals(self: Self, target: []const u8) bool {
                    return Bytes.equals(self.m_source[0..self.m_length], target);
                }

                /// Returns true if the `Buffer` instance is empty.
                pub fn isEmpty(self: Self) bool {
                    return self.m_length == 0;
                }

            // └──────────────────────────────────────────────────────────────┘

        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAKE ══════════════════════════════════════╗

    pub const initError = Bytes.initError;
    pub const initCapacityError = Bytes.initCapacityError;

    /// Initializes a `Buffer` of a pre-specified `size`.
    /// - `initCapacityError.ZeroSize` _if the `size` is 0._
    pub fn initCapacity(comptime size: usize) initCapacityError!Buffer(size) {
        return .{
            .m_source = try Bytes.initCapacity(size),
            .m_length = 0
        };
    }

    /// Initializes a `Buffer` of a pre-specified `size` and `value`.
    /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
    pub fn init(comptime size: usize, value: []const u8) initError!Buffer(size) {
        if(value.len == 0) return .{ };

        return .{
            .m_source = try Bytes.init(size, value),
            .m_length = Bytes.countWritten(value)
        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝