// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const utf8 = @import("../../utils/utf8/utf8.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Immutable fixed utf8 string type.
    pub const Viewer = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The UTF-8 encoded bytes to be viewed.
            source: []const u8,

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Initializes a new `Viewer` instance with the given UTF-8 bytes.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `initError.InvalidValue` **_if the `value` is not valid UTF-8._**
            pub fn init(value: []const u8) initError!Self {
                if(value.len == 0) return initError.ZeroSize;
                if(!utf8.utils.isValid(value)) return initError.InvalidValue;
                return Self{ .source = value };
            }
            pub const initError = error { InvalidValue, ZeroSize };

            /// Creates an iterator for traversing the UTF-8 bytes.
            pub fn iterator(self: Self) utf8.Iterator {
                // why Unchecked version ?
                // because we already checked the validity of the input bytes
                // when we initialized this instance of the `Viewer` struct.
                return utf8.Iterator.initUnchecked(self.source);
            }

        // └──────────────────────────────────────────────────────────────┘
    };
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝