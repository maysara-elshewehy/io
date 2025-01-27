// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const utf8 = @import("../../utils/utf8/utf8.zig");
    pub const Bytes = @import("../../utils/bytes/bytes.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Immutable fixed utf8 string type.
    pub const Viewer = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The UTF-8 encoded bytes to be viewed.
            m_source: []const u8,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new `Viewer` instance with the given UTF-8 bytes.
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            pub fn init(value: []const u8) initError!Self {
                if(value.len == 0) return initError.ZeroSize;
                return Self{ .m_source = value[0..Bytes.countWritten(value)] };
            }
            pub const initError = error { ZeroSize };

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the `position` of the **first** occurrence of `target`.
            pub fn find(self: Self, target: []const u8) ?usize {
                return Bytes.find(self.slice(), target);
            }

            /// Finds the `visual position` of the **first** occurrence of `target`.
            pub fn findVisual(self: Self, target: []const u8) !?usize {
                return Bytes.findVisual(self.slice(), target);
            }

            /// Finds the `position` of the **last** occurrence of `target`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return Bytes.rfind(self.slice(), target);
            }

            /// Finds the `visual position` of the **last** occurrence of `target`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return Bytes.rfindVisual(self.slice(), target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return Bytes.includes(self.slice(), target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return Bytes.startsWith(self.slice(), target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return Bytes.endsWith(self.slice(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Count ───────────────────────────┐

            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn length(self: Self) usize {
                return self.m_source.len;
            }

            /// Returns the total number of visual characters.
            pub fn countVisual(self: Self) usize {
                return Bytes.countVisual(self.m_source[0..self.m_source.len]) catch unreachable;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the UTF-8 bytes.
            pub fn iterator(self: Self) utf8.Iterator {
                // why Unchecked version ?
                // because we already checked the validity of the input bytes
                // when we initialized this instance of the `Viewer` struct.
                return utf8.Iterator.unsafeInit(self.m_source);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a slice containing only the written part.
            pub fn slice(self: Self) []const u8 {
                return if(self.m_source.len > 0 ) self.m_source[0..self.m_source.len] else "";
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝