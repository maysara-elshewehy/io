// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const internal = @import("./internal.zig");

    const Iterator = internal.Iterator;
    const Allocator = internal.Allocator;
    const AllocatorError = internal.AllocatorError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Managed dynamic-size string type that supports Unicode.
    pub const String = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Allocator used for memory management.
            m_allocator: Allocator = undefined,

            /// The mutable unicode encoded Bytes.
            m_source: []u8 = &[_]u8{},

            /// The number of bytes that can be written to `m_source`.
            m_capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            pub const initError = internal.initError;

            /// Initializes a new `String` instance with the given `allocator` and `value`.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `Allocator.Error` **_if the allocator returned an error._**
            pub fn init(allocator: Allocator, value: []const u8) initError!Self {
                return internal.init(Self, allocator, value);
            }

            /// Initializes a new `String` instance with `allocator` and `size`.
            /// - `initError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initError!Self {
                return internal.initCapacity(Self, allocator, size);
            }

            /// Initializes a new `String` instance with the given `allocator`.
            pub fn initAlloc(allocator: Allocator) Self {
                return Self{ .m_allocator = allocator, };
            }

            /// Release all allocated memory.
            pub fn deinit(self: Self) void {
                if (self.m_capacity > 0) {
                    self.m_allocator.free(self.allocatedSlice());
                }
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const insertError       = AllocatorError || error { OutOfRange };
            pub const insertVisualError = insertError || internal.insertVisualError;

            /// Inserts a `slice` into the `String` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insert(self: *Self, _slice: []const u8, pos: usize) insertError!void {
                if (_slice.len == 0) return;
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insert(self, self.m_allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void {
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insertOne(self, self.m_allocator, byte, pos);
            }

            /// Inserts a `slice` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insertVisual(self: *Self, _slice: []const u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisual(self, self.m_allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisualOne(self, self.m_allocator, byte, pos);
            }

            /// Appends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn append(self: *Self, _slice: []const u8) AllocatorError!void {
                try internal.append(self, self.m_allocator, _slice);
            }

            /// Appends a `byte` into the `String` instance.
            pub fn appendOne(self: *Self, byte: u8) AllocatorError!void {
                try internal.appendOne(self, self.m_allocator, byte);
            }

            /// Prepends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn prepend(self: *Self, _slice: []const u8) AllocatorError!void {
                if(_slice.len > 0)
                try internal.insert(self, self.m_allocator, _slice, 0);
            }

            /// Prepends a `byte` into the `String` instance.
            pub fn prependOne(self: *Self, byte: u8) AllocatorError!void {
                try internal.insertOne(self, self.m_allocator, byte, 0);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeError       = internal.removeError;
            pub const removeVisualError = internal.removeVisualError;

            /// Removes a byte from the `uString` instance.
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn remove(self: *Self, pos: usize) removeError!void {
                return internal.remove(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void {
                return internal.removeRange(self, pos, len);
            }

            /// Removes a byte from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8 {
                return internal.removeVisual(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, pos: usize, len: usize) removeVisualError![]const u8 {
                return internal.removeVisualRange(self, pos, len);
            }

            /// Removes the last grapheme cluster at the `uString` instance,
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const u8 {
                return internal.pop(self);
            }

            /// Removes the first grapheme cluster at the `uString` instance,
            /// Returns the number of removed Bytes.
            pub fn shift(self: *Self) usize {
                return internal.shift(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the `position` of the **first** occurrence of `target`.
            pub fn find(self: Self, target: []const u8) ?usize {
                return internal.find(self, target);
            }

            /// Finds the `visual position` of the **first** occurrence of `target`.
            pub fn findVisual(self: Self, target: []const u8) ?usize {
                return internal.findVisual(self, target);
            }

            /// Finds the `position` of the **last** occurrence of `target`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return internal.rfind(self, target);
            }

            /// Finds the `visual position` of the **last** occurrence of `target`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return internal.rfindVisual(self, target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return internal.includes(self, target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return internal.startsWith(self, target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return internal.endsWith(self, target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters to lowercase.
            pub fn toLower(self: *Self) void {
                return internal.toLower(self);
            }

            /// Converts all (ASCII) letters to uppercase.
            pub fn toUpper(self: *Self) void {
                return internal.toUpper(self);
            }

            // Converts all (ASCII) letters to titlecase.
            pub fn toTitle(self: *Self) void {
                return internal.toTitle(self);
            }

            /// Reverses the order of the characters **_(considering unicode)_**.
            pub fn reverse(self: *Self) AllocatorError!void {
                return internal.reverse(self, self.m_allocator);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the number of bytes that can be written to `m_source`.
            pub fn capacity(self: Self) usize {
                return internal.capacity(self);
            }

            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn length(self: Self) usize {
                return internal.length(self);
            }

            /// Returns the total number of visual characters.
            pub fn vlength(self: Self) usize {
                return internal.vlength(self);
            }

            /// Returns a slice representing the entire allocated memory range.
            pub fn allocatedSlice(self: Self) []u8 {
                return internal.allocatedSlice(self);
            }

            /// Returns a slice containing only the written part.
            pub fn slice(self: Self) []const u8 {
                return internal.slice(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the unicode bytes.
            /// - `Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) Iterator.Error!Iterator {
                return internal.iterator(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the string into substrings separated by the delimiter,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8 {
                return internal.split(self, delimiters, index);
            }

            /// Splits the written portion of the string into all substrings separated by the delimiter,
            /// returning an array of slices. Caller must free the returned memory.
            /// `include_empty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, delimiters: []const u8, include_empty: bool) ![]const []const u8 {
                return internal.splitAll(self, self.m_allocator, delimiters, include_empty);
            }

            /// Splits the written portion of the string into substrings separated by the delimiter,
            /// returning the substring at the specified index as a new `String` instance.
            pub fn splitToString(self: Self, delimiters: []const u8, index: usize) Allocator.Error!?Self {
                return internal.splitToString(Self, self, self.m_allocator, delimiters, index);
            }

            /// Splits the written portion of the string into all substrings separated by the delimiter,
            /// returning an array of new `String` instances. Caller must free the returned memory.
            pub fn splitAllToStrings(self: Self, delimiters: []const u8) Allocator.Error![]Self {
                return internal.splitAllToStrings(Self, self, self.m_allocator, delimiters);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces all occurrence of a character with another.
            pub fn replaceAllChars(self: *Self, match: u8, replacement: u8) void {
                return internal.replaceAllChars(self, match, replacement);
            }

            /// Replaces all occurrences of a slice with another.
            pub fn replaceAllSlices(self: *Self, match: []const u8, replacement: []const u8) Allocator.Error!usize {
                return internal.replaceAllSlices(self, self.m_allocator, match, replacement);
            }

            /// Replaces a range of bytes with another.
            pub fn replaceRange(self: anytype, start: usize, len: usize, replacement: []const u8) Allocator.Error!void {
                return internal.replaceRange(self, self.m_allocator, start, len, replacement);
            }

            /// Replaces a visual range of bytes with another.
            pub fn replaceVisualRange(self: anytype, start: usize, len: usize, replacement: []const u8) Allocator.Error!void {
                return internal.replaceVisualRange(self, self.m_allocator, start, len, replacement);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a copy of the `String` instance.
            pub fn clone(self: Self) AllocatorError!Self {
                return internal.clone(Self, self, self.m_allocator);
            }

            /// Returns true if the `String` instance equals the given `target`.
            pub fn equals(self: Self, target: []const u8) bool {
                return internal.equals(self, target);
            }

            /// Returns true if the `String` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return internal.isEmpty(self);
            }

        // └──────────────────────────────────────────────────────────────┘
    };


    /// Unmanaged dynamic-size string type that supports Unicode.
    pub const uString = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Allocator used for memory management.
            m_allocator: Allocator = undefined,

            /// The mutable unicode encoded Bytes.
            m_source: []u8 = &[_]u8{},

            /// The number of bytes that can be written to `source`.
            m_capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            pub const initError = internal.initError;

            /// Initializes a new `uString` instance using `allocator` and `value`.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `Allocator.Error` **_if the allocator returned an error._**
            pub fn init(allocator: Allocator, value: []const u8) initError!Self {
                return internal.init(Self, allocator, value);
            }

            /// Initializes a new `uString` instance using `allocator` and `size`.
            /// - `initError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initError!Self {
                return internal.initCapacity(Self, allocator, size);
            }

            /// Initializes a new empty `uString` instance.
            /// The purpose of this function is to integrate with the internal functions.
            pub fn initAlloc(_: Allocator) Self {
                return Self{ };
            }

            /// Release all allocated memory.
            pub fn deinit(self: Self, allocator: Allocator) void {
                if (self.m_capacity > 0) {
                    allocator.free(self.allocatedSlice());
                    // self.* = undefined;
                }
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const insertError       = AllocatorError || error { OutOfRange };
            pub const insertVisualError = insertError || internal.insertVisualError;

            /// Inserts a `slice` into the `uString` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Modifies the `uString` instance in place **_if `slice` length is greater than 0_.**
            pub fn insert(self: *Self, allocator: Allocator, _slice: []const u8, pos: usize) insertError!void {
                if (_slice.len == 0) return;
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insert(self, allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `uString` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn insertOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertError!void {
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insertOne(self, allocator, byte, pos);
            }

            /// Inserts a `slice` into the `uString` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `uString` instance in place **_if `slice` length is greater than 0_.**
            pub fn insertVisual(self: *Self, allocator: Allocator, _slice: []const u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisual(self, allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `uString` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            pub fn insertVisualOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisualOne(self, allocator, byte, pos);
            }

            /// Appends a `slice` into the `uString` instance.
            ///
            /// Modifies the `uString` instance in place **_if `slice` length is greater than 0_.**
            pub fn append(self: *Self, allocator: Allocator, _slice: []const u8) AllocatorError!void {
                try internal.append(self, allocator, _slice);
            }

            /// Appends a `byte` into the `uString` instance.
            pub fn appendOne(self: *Self, allocator: Allocator, byte: u8) AllocatorError!void {
                try internal.appendOne(self, allocator, byte);
            }

            /// Prepends a `slice` into the `uString` instance.
            ///
            /// Modifies the `uString` instance in place **_if `slice` length is greater than 0_.**
            pub fn prepend(self: *Self, allocator: Allocator, _slice: []const u8) AllocatorError!void {
                if(_slice.len > 0)
                try internal.insert(self, allocator, _slice, 0);
            }

            /// Prepends a `byte` into the `uString` instance.
            pub fn prependOne(self: *Self, allocator: Allocator, byte: u8) AllocatorError!void {
                try internal.insertOne(self, allocator, byte, 0);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeError       = internal.removeError;
            pub const removeVisualError = internal.removeVisualError;

            /// Removes a byte from the `uString` instance.
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn remove(self: *Self, pos: usize) removeError!void {
                return internal.remove(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void {
                return internal.removeRange(self, pos, len);
            }

            /// Removes a byte from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8 {
                return internal.removeVisual(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.m_source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisualRange(self: *Self, pos: usize, len: usize) removeVisualError![]const u8 {
                return internal.removeVisualRange(self, pos, len);
            }

            /// Removes the last grapheme cluster at the `uString` instance,
            /// Returns the removed slice.
            pub fn pop(self: *Self) ?[]const u8 {
                return internal.pop(self);
            }

            /// Removes the first grapheme cluster at the `uString` instance,
            /// Returns the number of removed Bytes.
            pub fn shift(self: *Self) usize {
                return internal.shift(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the `position` of the **first** occurrence of `target`.
            pub fn find(self: Self, target: []const u8) ?usize {
                return internal.find(self, target);
            }

            /// Finds the `visual position` of the **first** occurrence of `target`.
            pub fn findVisual(self: Self, target: []const u8) ?usize {
                return internal.findVisual(self, target);
            }

            /// Finds the `position` of the **last** occurrence of `target`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return internal.rfind(self, target);
            }

            /// Finds the `visual position` of the **last** occurrence of `target`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return internal.rfindVisual(self, target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return internal.includes(self, target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return internal.startsWith(self, target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return internal.endsWith(self, target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters to lowercase.
            pub fn toLower(self: *Self) void {
                return internal.toLower(self);
            }

            /// Converts all (ASCII) letters to uppercase.
            pub fn toUpper(self: *Self) void {
                return internal.toUpper(self);
            }

            // Converts all (ASCII) letters to titlecase.
            pub fn toTitle(self: *Self) void {
                return internal.toTitle(self);
            }

            /// Reverses the order of the characters **_(considering unicode)_**.
            pub fn reverse(self: *Self, allocator: Allocator) AllocatorError!void {
                return internal.reverse(self, allocator);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Data ────────────────────────────┐

            /// Returns the total number of written Bytes.
            pub fn capacity(self: Self) usize {
                return internal.capacity(self);
            }

            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn length(self: Self) usize {
                return internal.length(self);
            }

            /// Returns the total number of visual characters.
            pub fn vlength(self: Self) usize {
                return internal.vlength(self);
            }

            /// Returns a slice containing only the written part.
            pub fn slice(self: Self) []const u8 {
                return internal.slice(self);
            }

            /// Returns a slice representing the entire allocated memory range.
            pub fn allocatedSlice(self: Self) []u8 {
                return internal.allocatedSlice(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the unicode bytes.
            /// - `Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) Iterator.Error!Iterator {
                return internal.iterator(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the string into substrings separated by the delimiter,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8 {
                return internal.split(self, delimiters, index);
            }

            /// Splits the written portion of the string into all substrings separated by the delimiter,
            /// returning an array of slices. Caller must free the returned memory.
            /// `include_empty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, include_empty: bool) ![]const []const u8 {
                return internal.splitAll(self, allocator, delimiters, include_empty);
            }

            /// Splits the written portion of the string into substrings separated by the delimiter,
            /// returning the substring at the specified index as a new `uString` instance.
            pub fn splitToString(self: Self, allocator: Allocator, delimiters: []const u8, index: usize) Allocator.Error!?Self {
                return internal.splitToUString(Self, self, allocator, delimiters, index);
            }

            /// Splits the written portion of the string into all substrings separated by the delimiter,
            /// returning an array of new `uString` instances. Caller must free the returned memory.
            pub fn splitAllToStrings(self: Self, allocator: Allocator, delimiters: []const u8) Allocator.Error![]Self {
                return internal.splitAllToUStrings(Self, self, allocator, delimiters);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Replace ──────────────────────────┐

            /// Replaces all occurrence of a character with another.
            pub fn replaceAllChars(self: *Self, match: u8, replacement: u8) void {
                return internal.replaceAllChars(self, match, replacement);
            }

            /// Replaces all occurrences of a slice with another.
            pub fn replaceAllSlices(self: *Self, allocator: Allocator, match: []const u8, replacement: []const u8) Allocator.Error!usize {
                return internal.replaceAllSlices(self, allocator, match, replacement);
            }

            /// Replaces a range of bytes with another.
            pub fn replaceRange(self: anytype, allocator: Allocator, start: usize, len: usize, replacement: []const u8) Allocator.Error!void {
                return internal.replaceRange(self, allocator, start, len, replacement);
            }

            /// Replaces a visual range of bytes with another.
            pub fn replaceVisualRange(self: anytype, allocator: Allocator, start: usize, len: usize, replacement: []const u8) Allocator.Error!void {
                return internal.replaceVisualRange(self, allocator, start, len, replacement);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a copy of the `uString` instance.
            pub fn clone(self: Self, allocator: Allocator) AllocatorError!Self {
                return internal.clone(Self, self, allocator);
            }

            /// Converts the `uString` to a `uString`, taking ownership of the memory.
            pub fn toManaged(self: *Self, allocator: Allocator) uString {
                return .{ .m_source = self.m_source, .m_capacity = self.m_capacity, .m_allocator = allocator };
            }

            /// Returns true if the `uString` instance equals the given `target`.
            pub fn equals(self: Self, target: []const u8) bool {
                return internal.equals(self, target);
            }

            /// Returns true if the `uString` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return internal.isEmpty(self);
            }

        // └──────────────────────────────────────────────────────────────┘

    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝