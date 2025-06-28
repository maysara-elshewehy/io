// codepoint.zig — Codepoint handling module for I/O library.
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string/utils/codepoint
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const utf8 = @import("../utf8/utf8.zig");
    const Codepoint = @This();

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌─────────────────────────── Fields ───────────────────────────┐

        /// Numeric value of the Unicode codepoint (U+0000 to U+10FFFF).
        src: u21 = 0,

        /// Length of this codepoint in UTF-8 (1-4 bytes).
        len: u3  = 0,

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Methods ───────────────────────────┐



    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ITER ══════════════════════════════════════╗

    pub const Utf8Iterator = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The UTF-8 encoded string that the iterator will traverse.
            src: []const u8,

            /// The current byte position in the string.
            pos: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Decodes and returns the next codepoint and increments the position.
            pub inline fn nextCodepoint(self: *Utf8Iterator) ?Codepoint {
                if(self.peekCodepoint()) |cp| {
                    self.pos += cp.len;
                    return cp;
                } else return null;
            }

            /// Returns the next utf8 slice and increments the position.
            pub inline fn nextSlice(self: *Utf8Iterator) ?[]const u8 {
                if(self.peekSlice()) |slice| {
                    self.pos += slice.len;
                    return slice;
                } else return null;
            }

            /// Returns the next codepoint length and increments the position.
            pub inline fn nextLength(self: *Utf8Iterator) ?u3 {
                if(self.peekLength()) |len| {
                    self.pos += len;
                    return len;
                } else return null;
            }

            /// Decodes and returns the next codepoint without incrementing the position.
            pub inline fn peekCodepoint(self: Utf8Iterator) ?Codepoint {
                if(self.peekLength()) |len| {
                    return Codepoint {
                        .src = utf8.decode(self.src[self.pos..self.pos+len]),
                        .len = len
                    };
                } else return null;
            }

            /// Returns the next utf8 slice without incrementing the position.
            pub inline fn peekSlice(self: Utf8Iterator) ?[]const u8 {
                if(self.peekLength()) |len| {
                    return self.src[self.pos..self.pos+len];
                } else return null;
            }

            /// Returns the next codepoint length without incrementing the position.
            pub inline fn peekLength(self: Utf8Iterator) ?u3 {
                if(self.pos == self.src.len) return null;
                const len = utf8.getSequenceLength(self.src[self.pos]);
                return if(len == 0) null else len;
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝