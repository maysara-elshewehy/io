// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Bytes = @import("../../utils/bytes/bytes.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Mutable fixed utf8 string type.
    pub fn Buffer(comptime array_size: usize) type {
        return struct {

            // ┌──────────────────────────── ---- ────────────────────────────┐

                const Self = @This();

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── Fields ───────────────────────────┐

                /// The mutable UTF-8 encoded bytes.
                source: [array_size]u8 = .{0} ** array_size,

                /// The number of written bytes to `source`.
                length: usize = 0,

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Find ────────────────────────────┐

                /// Finds the **real position** of the **first** occurrence of `value`. 
                pub fn find(self: Self, target: []const u8) ?usize {
                    return Bytes.find(self.source[0..self.length], target);
                }

                /// Finds the **visual position** of the **first** occurrence of `value`.
                pub fn findVisual(self: Self, target: []const u8) !?usize {
                    return Bytes.findVisual(self.source[0..self.length], target);
                }

                /// Finds the **real position** of the **last** occurrence of `value`.
                pub fn rfind(self: Self, target: []const u8) ?usize {
                    return Bytes.rfind(self.source[0..self.length], target);
                }

                /// Finds the **visual position** of the **last** occurrence of `value`.
                pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                    return Bytes.rfindVisual(self.source[0..self.length], target);
                }

                /// Returns `true` **if contains `target`**.
                pub fn includes(self: Self, target: []const u8) bool {
                    return Bytes.includes(self.source[0..self.length], target);
                }

                /// Returns `true` **if starts with `target`**.
                pub fn startsWith(self: Self, target: []const u8) bool {
                    return Bytes.startsWith(self.source[0..self.length], target);
                }

                /// Returns `true` **if ends with `target`**.
                pub fn endsWith(self: Self, target: []const u8) bool {
                    return Bytes.endsWith(self.source[0..self.length], target);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── Case ────────────────────────────┐

                /// Converts all (ASCII) letters to lowercase.
                pub fn toLower(self: *Self) void {
                    Bytes.toLower(self.source[0..self.length]);
                }

                /// Converts all (ASCII) letters to uppercase.
                pub fn toUpper(self: *Self) void {
                    Bytes.toUpper(self.source[0..self.length]);
                }

                // Converts all (ASCII) letters to titlecase.
                pub fn toTitle(self: *Self) void {
                    Bytes.toTitle(self.source[0..self.length]);
                }

            // └──────────────────────────────────────────────────────────────┘

            
            // ┌──────────────────────────── Count ───────────────────────────┐
                
                /// Returns the total number of written bytes, stopping at the first null byte.
                pub fn countWritten(self: Self) usize {
                    return self.length;
                }

                /// Returns the total number of visual characters, stopping at the first null byte.
                pub fn countVisual(self: Self) usize {
                    return Bytes.countVisual(self.source[0..self.length]);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── Iterator ──────────────────────────┐

                /// Creates an iterator for traversing the UTF-8 bytes.
                /// - `utf8.Iterator.Error` **_if the initialization failed._**
                pub fn iterator(self: Self) utf8.Iterator.Error!utf8.Iterator {
                    return try utf8.Iterator.init(self.source[0..self.length]);
                }

            // └──────────────────────────────────────────────────────────────┘
        
        };
    }
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAKE ══════════════════════════════════════╗

    /// Initializes a `Buffer` of a pre-specified `size`.
    /// - `initCapacityError.ZeroSize` _if the `size` is 0._
    pub fn initCapacity(comptime size: usize) initCapacityError!Buffer(size) {
        return .{
            .source = try Bytes.initCapacity(size),
            .length = 0
        };
    }
    pub const initCapacityError = Bytes.initCapacityError;

    /// Initializes a `Buffer` of a pre-specified `size` and `value`.
    /// - `initError.InvalidValue` **_if the `value` is not valid utf8._**
    /// - `initError.ZeroSize` **_if the length of `value` is 0._**
    /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
    pub fn init(comptime size: usize, value: []const u8) initError!Buffer(size) {
        if(!utf8.utils.isValid(value)) return error.InvalidValue;

        return .{
            .source = try Bytes.init(size, value),
            .length = Bytes.countWritten(value)
        };
    }
    pub const initError = error { InvalidValue } || Bytes.initError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝