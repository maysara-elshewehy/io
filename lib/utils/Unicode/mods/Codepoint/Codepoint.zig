// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const utils = @import("../../utils/utils.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// A struct to represent a single Unicode codepoint with properties.
    pub const Codepoint = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

            /// Unified error set of `Codepoint` functions.
            pub const Error = error { InvalidValue };

            /// Modes of the codepoint.
            pub const Mode = enum { ZWJ, Mod, None };

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The mode of the code point _(`ZeroWidthJointer`/`Modifier`/`None`)_.
            mode: Mode,

            /// The length of the codepoint slice.
            len: usize,

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Initializes a Codepoint using the given input Bytes.
            /// - `Error.InvalidValue` **_if the `slice` is not a valid Unicode._**
            pub fn init(slice: []const u8) Error!Self {
                if(slice.len == 0) return Error.InvalidValue;
                if(!utils.Utf8Validate(slice)) return Error.InvalidValue;

                const decoded_value = utils.Utf8Decode(slice) catch return Error.InvalidValue;
                return .{
                    .mode = if(decoded_value == 0x200d) .ZWJ else if(isModifier(decoded_value)) .Mod else .None,
                    .len = slice.len,
                };
            }

            /// Returns `true` if the code point is a modifier using **_the decoded code point value._**
            inline fn isModifier(codepoint: u21) bool {
                return switch (codepoint) {
                    0x0300...0x036F,  // Combining Diacritical Marks
                    0x1AB0...0x1AFF,  // Combining Diacritical Marks Extended
                    0x1DC0...0x1DFF,  // Combining Diacritical Marks Supplement
                    0x20D0...0x20FF,  // Combining Diacritical Marks for Symbols
                    0xFE20...0xFE2F,  // Combining Half Marks
                    0xFE00...0xFE0F   // Variation Selectors
                    => true,
                    else => false,
                };
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝