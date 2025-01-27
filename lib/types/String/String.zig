// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const internal = @import("./internal.zig");
    const Bytes = @import("../../utils/bytes/bytes.zig");

    const Iterator = internal.Iterator;
    const Allocator = internal.Allocator;
    const AllocatorError = internal.AllocatorError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Managed dynamic utf8 string type.
    pub const String = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Allocator used for memory management.
            m_allocator: Allocator = undefined,

            /// The mutable UTF-8 encoded bytes.
            m_source: []u8 = &[_]u8{},

            /// The number of bytes that can be written to `m_source`.
            m_capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            pub const initError = internal_initError;

            /// Initializes a new `String` instance with the given `allocator` and `value`.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `std.mem.Allocator` **_if the allocator returned an error._**
            pub fn init(allocator: Allocator, value: []const u8) initError!Self {
                return try internal_init(Self, allocator, value);
            }

            /// Initializes a new `String` instance with `allocator` and `size`.
            /// - `initError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initError!Self {
                return try internal_initCapacity(Self, allocator, size);
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
            /// - `.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insert(self: *Self, _slice: []const u8, pos: usize) insertError!void {
                if (_slice.len == 0) return;
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insert(self, self.m_allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `String` instance in place.
            pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void {
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insertOne(self, self.m_allocator, byte, pos);
            }

            /// Inserts a `slice` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insertVisual(self: *Self, _slice: []const u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisual(self, self.m_allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `String` instance in place.
            pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisualOne(self, self.m_allocator, byte, pos);
            }

            /// Appends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn append(self: *Self, _slice: []const u8) AllocatorError!void {
                return internal.append(self, self.m_allocator, _slice);
            }

            /// Appends a `byte` into the `String` instance.
            ///
            /// Modifies the `String` instance in place.
            pub fn appendOne(self: *Self, byte: u8) AllocatorError!void {
                return internal.appendOne(self, self.m_allocator, byte);
            }

            /// Prepends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn prepend(self: *Self, _slice: []const u8) AllocatorError!void {
                if(_slice.len == 0) return;
                return internal.insert(self, self.m_allocator, _slice, 0);
            }

            /// Prepends a `byte` into the `String` instance.
            ///
            /// Modifies the `String` instance in place.
            pub fn prependOne(self: *Self, byte: u8) AllocatorError!void {
                return internal.insertOne(self, self.m_allocator, byte, 0);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeError       = internal.removeError;
            pub const removeVisualError = internal.removeVisualError;

            /// Removes a byte from the `uString` instance.
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `uString` instance in place.
            pub fn remove(self: *Self, pos: usize) removeError!void {
                return internal.remove(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `uString` instance in place.
            pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void {
                return internal.removeRange(self, pos, len);
            }

            /// Removes a byte from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8 {
                return internal.removeVisual(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
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
            /// Returns the number of removed bytes.
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
            pub fn findVisual(self: Self, target: []const u8) !?usize {
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

            /// Creates an iterator for traversing the UTF-8 bytes.
            /// - `Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) Iterator.Error!Iterator {
                return try internal.iterator(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a copy of the `String` instance.
            pub fn clone(self: Self) AllocatorError!Self {
                return internal_clone(Self, self, self.m_allocator);
            }

        // └──────────────────────────────────────────────────────────────┘
    };


    /// Unmanaged dynamic utf8 string type.
    pub const uString = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Allocator used for memory management.
            m_allocator: Allocator = undefined,

            /// The mutable UTF-8 encoded bytes.
            m_source: []u8 = &[_]u8{},

            /// The number of bytes that can be written to `source`.
            m_capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            pub const initError = internal_initError;

            /// Initializes a new `uString` instance using `allocator` and `value`.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `std.mem.Allocator` **_if the allocator returned an error._**
            pub fn init(allocator: Allocator, value: []const u8) initError!Self {
                return try internal_init(Self, allocator, value);
            }

            /// Initializes a new `uString` instance using `allocator` and `size`.
            /// - `initError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initError!Self {
                return try internal_initCapacity(Self, allocator, size);
            }

            /// Release all allocated memory.
            pub fn deinit(self: *Self, allocator: Allocator) void {
                if (self.m_capacity > 0) {
                    allocator.free(self.allocatedSlice());
                    self.* = undefined;
                }
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const insertError       = AllocatorError || error { OutOfRange };
            pub const insertVisualError = insertError || internal.insertVisualError;

            /// Inserts a `slice` into the `String` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insert(self: *Self, allocator: Allocator, _slice: []const u8, pos: usize) insertError!void {
                if (_slice.len == 0) return;
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insert(self, allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `position` by **real position**.
            /// - `Allocator.Error` **_if the `allocator` returned an error._**
            /// - `.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `String` instance in place.
            pub fn insertOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertError!void {
                if (pos > self.m_source.len) return insertError.OutOfRange;
                try internal.insertOne(self, allocator, byte, pos);
            }

            /// Inserts a `slice` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insertVisual(self: *Self, allocator: Allocator, _slice: []const u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisual(self, allocator, _slice, pos);
            }

            /// Inserts a `byte` into the `String` instance at the specified `visual position`.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            ///
            /// Modifies the `String` instance in place.
            pub fn insertVisualOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void {
                if (pos > self.m_source.len) return insertVisualError.OutOfRange;
                try internal.insertVisualOne(self, allocator, byte, pos);
            }

            /// Appends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn append(self: *Self, allocator: Allocator, _slice: []const u8) AllocatorError!void {
                return internal.append(self, allocator, _slice);
            }

            /// Appends a `byte` into the `String` instance.
            ///
            /// Modifies the `String` instance in place.
            pub fn appendOne(self: *Self, allocator: Allocator, byte: u8) AllocatorError!void {
                return internal.appendOne(self, allocator, byte);
            }

            /// Prepends a `slice` into the `String` instance.
            ///
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn prepend(self: *Self, allocator: Allocator, _slice: []const u8) AllocatorError!void {
                if(_slice.len == 0) return;
                return internal.insert(self, allocator, _slice, 0);
            }

            /// Prepends a `byte` into the `String` instance.
            ///
            /// Modifies the `String` instance in place.
            pub fn prependOne(self: *Self, allocator: Allocator, byte: u8) AllocatorError!void {
                return internal.insertOne(self, allocator, byte, 0);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Remove ───────────────────────────┐

            pub const removeError       = internal.removeError;
            pub const removeVisualError = internal.removeVisualError;

            /// Removes a byte from the `uString` instance.
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `uString` instance in place.
            pub fn remove(self: *Self, pos: usize) removeError!void {
                return internal.remove(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Modifies the `uString` instance in place.
            pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void {
                return internal.removeRange(self, pos, len);
            }

            /// Removes a byte from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
            ///
            /// Returns the removed slice.
            pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8 {
                return internal.removeVisual(self, pos);
            }

            /// Removes a `range` of bytes from the `uString` instance by the `visual position`.
            /// - `InvalidPosition` **_if the `pos` is invalid._**
            /// - `OutOfRange` **_if the `pos` is greater than `self.source.len`._**
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
            /// Returns the number of removed bytes.
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
            pub fn findVisual(self: Self, target: []const u8) !?usize {
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

            /// Returns the total number of written bytes.
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

            /// Creates an iterator for traversing the UTF-8 bytes.
            /// - `Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) Iterator.Error!Iterator {
                return try internal.iterator(self);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a copy of the `uString` instance.
            pub fn clone(self: Self, allocator: Allocator) AllocatorError!Self {
                return internal_clone(Self, self, allocator);
            }

            /// Converts the `uString` to a `String`, taking ownership of the memory.
            pub fn toManaged(self: *Self, allocator: Allocator) String {
                return .{ .m_source = self.m_source, .m_capacity = self.m_capacity, .m_allocator = allocator };
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ Internal ════════════════════════════════════╗

    const internal_initError = AllocatorError || error { ZeroSize };

    /// Initializes a new `String` instance with the given `allocator` and `value`.
    /// - `internal_initError.ZeroSize` **_if the length of `value` is 0._**
    /// - `std.mem.Allocator` **_if the allocator returned an error._**
    inline fn internal_init(Self: type, allocator: Allocator, value: []const u8) internal_initError!Self {
        var self = try internal_initCapacity(Self, allocator, value.len*2);
        Bytes.unsafeAppend(self.allocatedSlice(), value, 0);
        self.m_source.len = Bytes.countWritten(value);

        return self;
    }

    /// Initializes a new `uString` instance using `allocator` and `size`.
    /// - `internal_initError.ZeroSize` _if the `size` is 0._
    inline fn internal_initCapacity(Self: type, allocator: Allocator, size: usize) internal_initError!Self {
        if(size == 0) return internal_initError.ZeroSize;

        var self = if(Self == String) Self{ .m_allocator = allocator } else Self{};
        try internal.ensureCapacity(&self, allocator, size, false);
        return self;
    }

    /// Returns a copy of the `String` instance.
    inline fn internal_clone(Self: type, self: Self, allocator: Allocator) AllocatorError!Self {
        var new_string = if(@typeName(Self) == String) Self{ .m_allocator = allocator } else Self{};
        try internal.ensureUnusedCapacity(&new_string, allocator, self.m_capacity);
        Bytes.unsafeAppend(new_string.allocatedSlice(), self.slice(), 0);
        new_string.m_source.len = self.m_source.len;
        return new_string;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝