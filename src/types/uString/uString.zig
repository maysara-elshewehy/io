// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Bytes = @import("../../utils/bytes/bytes.zig");
    const String = @import("../String/String.zig").String;

    const Allocator = std.mem.Allocator;
    const AllocatorError = Allocator.Error;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Manage dynamic utf8 string type.
    pub const uString = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The mutable UTF-8 encoded bytes.
            source: []u8 = &[_]u8{},

            /// The number of written bytes to `source`.
            length: usize = 0,

            /// The number of bytes that can be written to `source`.
            capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new `uString` instance using `allocator` and `value`.
            /// - `initError.InvalidValue` **_if the `value` is not valid utf8._**
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `std.mem.Allocator` **_if the allocator returned an error._**
            pub fn init(alloator: Allocator, value: []const u8) initError!Self {
                if(!utf8.utils.isValid(value)) return initError.InvalidValue;

                var self = try Self.initCapacity(alloator, value.len*2);
                Bytes.unsafeAppend(self.allocatedSlice(), value, 0);
                self.length = Bytes.countWritten(value);

                return self;
            }
            pub const initError = initCapacityError || error { InvalidValue };

            /// Initializes a new `uString` instance using `allocator` and `size`.
            /// - `initCapacityError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initCapacityError!Self {
                if(size == 0) return initCapacityError.ZeroSize;

                var self = Self{};
                try self.ensureCapacity(allocator, size);
                return self;
            }
            pub const initCapacityError = AllocatorError || error { ZeroSize };

            /// Release all allocated memory.
            pub fn deinit(self: *Self, allocator: Allocator) void {
                allocator.free(self.allocatedSlice());
                self.* = undefined;
            }

        // └──────────────────────────────────────────────────────────────┘
        

        // ┌─────────────────────────── Insert ───────────────────────────┐

            pub const insertError       = AllocatorError || Bytes.insertError       || error { InvalidValue };
            pub const insertVisualError = AllocatorError || Bytes.insertVisualError || error { InvalidValue };
            pub const appendError       = insertError;
            pub const prependError      = appendError;

            /// Inserts a `slice` into the `String` instance at the specified `position` by **real position**.
            /// - `insertError.InvalidValue` **_if the `slice` is invalid utf8._**
            /// - `insertError.OutOfRange` **_if the `pos` is greater than `self.length`._**
            /// 
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insert(self: *Self, allocator: Allocator, slice: []const u8, pos: usize) insertError!void {
                if (slice.len == 0) return;
                if (pos > self.length) return insertError.OutOfRange;
                if(!utf8.utils.isValid(slice)) return appendError.InvalidValue;
                try self.ensureCapacity(allocator, self.length + slice.len);
                Bytes.unsafeInsert(self.allocatedSlice(), slice, self.length, pos);
                self.length += slice.len;
            }

            /// Inserts a `byte` into the `String` instance at the specified `position` by **real position**.
            /// - `insertError.InvalidValue` **_if the `byte` is invalid utf8._**
            /// - `insertError.OutOfRange` **_if the `pos` is greater than `self.length`._**
            /// 
            /// Modifies the `String` instance in place.
            pub fn insertOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertError!void {
                _ = utf8.utils.lengthOfStartByte(byte) catch return insertError.InvalidValue;
                if (pos > self.length) return insertError.OutOfRange;
                try self.ensureCapacity(allocator, self.length + 1);
                Bytes.unsafeInsertOne(self.allocatedSlice(), byte, self.length, pos);
                self.length += 1;
            }

            /// Inserts a `slice` into the `String` instance at the specified `position` by **visual position**.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
            /// - `insertVisualError.InvalidValue` **_if the `slice` is invalid utf8._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            /// 
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn insertVisual(self: *Self, allocator: Allocator, slice: []const u8, pos: usize) insertVisualError!void {
                if(!utf8.utils.isValid(slice)) return insertError.InvalidValue;
                if (pos > self.length) return insertVisualError.OutOfRange;
                const real_pos = utf8.utils.getRealPosition(self.writtenSlice(), pos) catch return insertVisualError.InvalidPosition;
                try self.ensureCapacity(allocator, self.length + slice.len);
                Bytes.unsafeInsert(self.allocatedSlice(), slice, self.length, real_pos);
                self.length += slice.len;
            }

            /// Inserts a `byte` into the `String` instance at the specified `position` by **visual position**.
            /// - `insertVisualError.OutOfRange` **_if the `pos` is greater than `self.length`._**
            /// - `insertVisualError.InvalidValue` **_if the `byte` is invalid utf8._**
            /// - `insertVisualError.InvalidPosition` **_if the `pos` is invalid._**
            /// 
            /// Modifies the `String` instance in place.
            pub fn insertVisualOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void {
                _ = utf8.utils.lengthOfStartByte(byte) catch return insertVisualError.InvalidValue;
                if (pos > self.length) return insertVisualError.OutOfRange;
                const real_pos = utf8.utils.getRealPosition(self.writtenSlice(), pos) catch return insertVisualError.InvalidPosition;
                try self.ensureCapacity(allocator, self.length + 1);
                Bytes.unsafeInsertOne(self.allocatedSlice(), byte, self.length, real_pos);
                self.length += 1;
            }

            /// Appends a `slice` into the `String` instance.
            /// - `insertError.InvalidValue` **_if the `slice` is invalid utf8._**
            /// 
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn append(self: *Self, allocator: Allocator, slice: []const u8) appendError!void {
                if (slice.len == 0) return;
                if(!utf8.utils.isValid(slice)) return appendError.InvalidValue;
                try self.ensureCapacity(allocator, self.length + slice.len);
                Bytes.unsafeAppend(self.allocatedSlice(), slice, self.length);
                self.length += slice.len;
            }

            /// Appends a `byte` into the `String` instance.
            /// - `insertError.InvalidValue` **_if the `byte` is invalid utf8._**
            /// 
            /// Modifies the `String` instance in place.
            pub fn appendOne(self: *Self, allocator: Allocator, byte: u8) appendError!void {
                _ = utf8.utils.lengthOfStartByte(byte) catch return appendError.InvalidValue;
                try self.ensureCapacity(allocator, self.length + 1);
                Bytes.unsafeAppendOne(self.allocatedSlice(), byte, self.length);
                self.length += 1;
            }

            /// Prepends a `slice` into the `String` instance.
            /// - `insertError.InvalidValue` **_if the `slice` is invalid utf8._**
            /// 
            /// Modifies the `String` instance in place **_if `slice` length is greater than 0_.**
            pub fn prepend(self: *Self, allocator: Allocator, slice: []const u8) prependError!void {
                if (slice.len == 0) return;
                if(!utf8.utils.isValid(slice)) return appendError.InvalidValue;
                try self.ensureCapacity(allocator, self.length + slice.len);
                Bytes.unsafePrepend(self.allocatedSlice(), slice, self.length);
                self.length += slice.len;
            }

            /// Prepends a `byte` into the `String` instance.
            /// - `insertError.InvalidValue` **_if the `byte` is invalid utf8._**
            /// 
            /// Modifies the `String` instance in place.
            pub fn prependOne(self: *Self, allocator: Allocator, byte: u8) appendError!void {
                _ = utf8.utils.lengthOfStartByte(byte) catch return appendError.InvalidValue;
                try self.ensureCapacity(allocator, self.length + 1);
                Bytes.unsafePrependOne(self.allocatedSlice(), byte, self.length);
                self.length += 1;
            }

        // └──────────────────────────────────────────────────────────────┘
        

        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the **real position** of the **first** occurrence of `value`. 
            pub fn find(self: Self, target: []const u8) ?usize {
                return Bytes.find(self.writtenSlice(), target);
            }

            /// Finds the **visual position** of the **first** occurrence of `value`.
            pub fn findVisual(self: Self, target: []const u8) !?usize {
                return Bytes.findVisual(self.writtenSlice(), target);
            }

            /// Finds the **real position** of the **last** occurrence of `value`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return Bytes.rfind(self.writtenSlice(), target);
            }

            /// Finds the **visual position** of the **last** occurrence of `value`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return Bytes.rfindVisual(self.writtenSlice(), target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return Bytes.includes(self.writtenSlice(), target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return Bytes.startsWith(self.writtenSlice(), target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return Bytes.endsWith(self.writtenSlice(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters to lowercase.
            pub fn toLower(self: *Self) void {
                if(self.length > 0)
                Bytes.toLower(self.allocatedSlice()[0..self.length]);
            }

            /// Converts all (ASCII) letters to uppercase.
            pub fn toUpper(self: *Self) void {
                if(self.length > 0)
                Bytes.toUpper(self.allocatedSlice()[0..self.length]);
            }

            // Converts all (ASCII) letters to titlecase.
            pub fn toTitle(self: *Self) void {
                if(self.length > 0)
                Bytes.toTitle(self.allocatedSlice()[0..self.length]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Count ───────────────────────────┐
            
            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn countWritten(self: Self) usize {
                return self.length;
            }

            /// Returns the total number of visual characters, stopping at the first null byte.
            pub fn countVisual(self: Self) usize {
                return Bytes.countVisual(self.writtenSlice());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the UTF-8 bytes.
            /// - `utf8.Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) utf8.Iterator.Error!utf8.Iterator {
                return try utf8.Iterator.init(self.writtenSlice());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a slice representing the entire allocated memory range.
            pub fn allocatedSlice(self: Self) []u8 {
                return self.source.ptr[0..self.capacity];
            }

            /// Returns a slice containing only the written part.
            pub fn writtenSlice(self: Self) []const u8 {
                return if(self.length > 0 )self.source.ptr[0..self.length] else "";
            }

            /// Returns a copy of the `Buffer` instance. 
            pub fn clone(self: Self, allocator: Allocator) AllocatorError!Self {
                var new_string : Self = .{};
                try new_string.ensureCapacity(allocator, self.capacity);
                Bytes.unsafeAppend(new_string.allocatedSlice(), self.writtenSlice(), 0);
                new_string.length = self.length;
                return new_string;
            }

            /// Reverses the order of the characters **_(considering unicode)_**.
            pub fn reverse(self: *Self, allocator: Allocator) AllocatorError!void {
                if (self.length == 0) return;
                var original_data = try self.clone(allocator);
                defer original_data.deinit(allocator);

                var utf8_iterator = utf8.Iterator.unsafeInit(original_data.writtenSlice());
                var i: usize = self.length;
                
                while (utf8_iterator.nextGraphemeCluster()) |gc| {
                    i -= gc.len;
                    @memcpy(self.allocatedSlice()[i..i + gc.len], gc);
                    if (i == 0) break; // to avoid underflow.
                }
            }

            /// Converts the `uString` to a `String`, taking ownership of the memory.
            pub fn toManaged(self: *Self, allocator: Allocator) String {
                return .{ .source = self.source, .capacity = self.capacity, .allocator = allocator, .length = self.length };
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌───────────────────────── Internal ───────────────────────────┐

            /// If the current capacity is less than `new_capacity`, this function will
            /// modify the array so that it can hold exactly `new_capacity` source.
            /// Invalidates element pointers if additional memory is needed.
            fn ensureCapacity(self: *Self, allocator: Allocator, new_capacity: usize) AllocatorError!void {
                if (self.capacity >= new_capacity) return;

                // Here we avoid copying allocated but unused bytes by
                // attempting a resize in place, and falling back to allocating
                // a new buffer and doing our own copy. With a realloc() call,
                // the allocator implementation would pointlessly copy our
                // extra capacity. referance: std.ArrayListUnmanaged.
                const old_memory = self.allocatedSlice();
                if (allocator.resize(old_memory, new_capacity)) {
                    self.capacity = new_capacity;
                } else {
                    const new_memory = try allocator.alloc(u8, new_capacity);
                    @memcpy(new_memory[0..self.source.len], self.source);
                    allocator.free(old_memory);
                    self.source.ptr = new_memory.ptr;
                    self.capacity = new_memory.len;
                }
            }

        // └──────────────────────────────────────────────────────────────┘
    };
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝