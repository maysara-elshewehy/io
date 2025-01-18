// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const Bytes = @import("../../utils/bytes/bytes.zig");
    const utf8 = @import("../../utils/utf8/utf8.zig");

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


            // ┌────────────────────────── Methods ───────────────────────────┐

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
            .source = try Bytes.initArray(size),
            .length = 0
        };
    }
    pub const initCapacityError = Bytes.initArrayError;

    /// Initializes a `Buffer` of a pre-specified `size` and `value`.
    /// - `initError.InvalidValue` **_if the `value` is not valid utf8._**
    /// - `initError.ZeroSize` **_if the length of `value` is 0._**
    /// - `initError.OutOfRange` **_if the length of `value` exceeds `size`._**
    pub fn init(comptime size: usize, value: []const u8) initError!Buffer(size) {
        if(!utf8.utils.isValid(value)) return error.InvalidValue;

        return .{
            .source = try Bytes.initArrayWith(size, value),
            .length = value.len
        };
    }
    pub const initError = error { InvalidValue } || Bytes.initArrayWithError;

// ╚══════════════════════════════════════════════════════════════════════════════════╝