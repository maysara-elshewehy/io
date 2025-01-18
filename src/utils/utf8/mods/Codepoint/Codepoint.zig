// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");

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

            /// Initializes a Codepoint using the given input bytes.
            /// - `Error.InvalidValue` **_if the `slice` is not a valid utf8._**
            pub fn init(slice: []const u8) Error!Self {
                if(!std.unicode.utf8ValidateSlice(slice)) return Error.InvalidValue;
                
                const decoded_value = std.unicode.utf8Decode(slice) catch return Error.InvalidValue;
                return .{
                    .mode = if(decoded_value == 0x200d) .ZWJ else if(isModifier(decoded_value)) .Mod else .None,
                    .len = slice.len,
                };
            }

            /// Returns `true` if the code point is a modifier using **_the decoded code point value._**
            inline fn isModifier(codepoint: u21) bool {
                return
                // Combining Diacritical Marks
                (codepoint >= 0x0300 and codepoint <= 0x036F) or
                // Combining Diacritical Marks Extended
                (codepoint >= 0x1AB0 and codepoint <= 0x1AFF) or
                // Combining Diacritical Marks Supplement
                (codepoint >= 0x1DC0 and codepoint <= 0x1DFF) or
                // Combining Diacritical Marks for Symbols
                (codepoint >= 0x20D0 and codepoint <= 0x20FF) or
                // Combining Half Marks
                (codepoint >= 0xFE20 and codepoint <= 0xFE2F) or
                // Variation Selectors
                (codepoint >= 0xFE00 and codepoint <= 0xFE0F); 
            }

        // └──────────────────────────────────────────────────────────────┘
    };
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝