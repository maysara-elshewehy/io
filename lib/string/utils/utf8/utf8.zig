// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string/utf8
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌────────────────────────── Conversion ────────────────────────┐

        /// Fast encode a single Unicode `codepoint` to `UTF-8 sequence`
        /// Returns the number of bytes written.
        ///
        /// This function assumes that the input `codepoint` is valid,
        /// And the output slice is large enough to hold the result.
        pub inline fn encode(cp: u21, out: []u8) u3 {
            const length = getCodepointLength(cp);

            switch (length) {
                1 => {
                    out[0] = @truncate(cp);
                },

                2 => {
                    out[0] = @truncate(0xC0  |  (cp >> 6          ));
                    out[1] = @truncate(0x80  |  (cp         & 0x3F));
                },

                3 => {
                    out[0] = @truncate(0xE0  |  (cp >> 12         ));
                    out[1] = @truncate(0x80  | ((cp >> 6)   & 0x3F));
                    out[2] = @truncate(0x80  |  (cp         & 0x3F));
                },

                4 => {
                    out[0] = @truncate(0xF0  |  (cp >> 18         ));
                    out[1] = @truncate(0x80  | ((cp >> 12)  & 0x3F));
                    out[2] = @truncate(0x80  | ((cp >> 6)   & 0x3F));
                    out[3] = @truncate(0x80  |  (cp         & 0x3F));
                },

                else => unreachable,
            }

            return length;
        }

        /// Fast decode a `UTF-8 sequence` to a Unicode `codepoint`
        /// Returns the decoded codepoint.
        ///
        /// This function assumes that the input `UTF-8 sequence` is valid.
        pub inline fn decode(slice: []const u8) u21 {
            return switch (slice.len) {
                1 => @as(u21,
                    slice[0]),

                2 => (@as(u21,
                    (slice[0] & 0x1F)) << 6) | (slice[1] & 0x3F),

                3 => (((@as(u21,
                    (slice[0] & 0x0F)) << 6) | (slice[1] & 0x3F)) << 6) | (slice[2] & 0x3F),

                4 => (((((@as(u21,
                    (slice[0] & 0x07)) << 6) | (slice[1] & 0x3F)) << 6) | (slice[2] & 0x3F)) << 6) | (slice[3] & 0x3F),

                else => unreachable,
            };
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Properties ────────────────────────┐

        /// Returns the number of bytes (`1-4`) needed to encode a `codepoint` in UTF-8 format
        /// **if the codepoint is valid**, otherwise it returns `0`.
        pub inline fn getCodepointLength(cp: u21) u3 {
            return switch (cp) {
                0x00000...0x00007F => @as(u3, 1),
                0x00080...0x0007FF => @as(u3, 2),
                0x00800...0x00FFFF => @as(u3, 3),
                0x10000...0x10FFFF => @as(u3, 4),
                else => @as(u3, 0),
            };
        }

        /// Returns the expected number of bytes (`1-4`) in a `UTF-8 sequence` based on the first byte
        /// **if the codepoint is valid**, otherwise it returns `0`.
        pub inline fn getSequenceLength(first_byte: u8) u3 {
            return switch (first_byte) {
                0x00...0x7F => @as(u3, 1),
                0xC0...0xDF => @as(u3, 2),
                0xE0...0xEF => @as(u3, 3),
                0xF0...0xF7 => @as(u3, 4),
                else => @as(u3, 0),
            };
        }

        /// Returns true if the provided slice contains valid UTF-8 data.
        pub inline fn isValid(slice: []const u8) bool {
            // Inspired by: std.unicode.utf8ValidateSliceImpl

            // default lowest and highest continuation byte
            const lo_cb = 0b10000000;
            const hi_cb = 0b10111111;

            var remaining = slice;
            vectorized: {
                const chunk_len = @import("std").simd.suggestVectorLength(u8) orelse break :vectorized;
                const Chunk = @Vector(chunk_len, u8);

                // Fast path. Check for and skip ASCII characters at the start of the input.
                while (remaining.len >= chunk_len) {
                    const chunk: Chunk = remaining[0..chunk_len].*;
                    const mask: Chunk = @splat(0x80);
                    if (@reduce(.Or, chunk & mask == mask)) {
                        // found a non ASCII byte
                        break;
                    }
                    remaining = remaining[chunk_len..];
                }
            }

            // The first nibble is used to identify the continuation byte range to
            // accept. The second nibble is the size.
            const xx = 0xF1; // invalid: size 1
            const as = 0xF0; // ASCII: size 1
            const s1 = 0x02; // accept 0, size 2
            const s2 = 0x13; // accept 1, size 3
            const s3 = 0x03; // accept 0, size 3
            const s4 = 0x23; // accept 2, size 3
            const s5 = 0x34; // accept 3, size 4
            const s6 = 0x04; // accept 0, size 4
            const s7 = 0x44; // accept 4, size 4

            // Information about the first byte in a UTF-8 sequence.
            const first = comptime ([_]u8{as} ** 128) ++ ([_]u8{xx} ** 64) ++ [_]u8{
                xx, xx, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1,
                s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1, s1,
                s2, s3, s3, s3, s3, s3, s3, s3, s3, s3, s3, s3, s3, s4, s3, s3,
                s5, s6, s6, s6, s7, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
            };

            const n = remaining.len;
            var i: usize = 0;
            while (i < n) {
                const first_byte = remaining[i];
                if (first_byte < 0x80) {
                    i += 1;
                    continue;
                }

                const info = first[first_byte];
                if (info == xx) {
                    return false; // Illegal starter byte.
                }

                const size = info & 7;
                if (i + size > n) {
                    return false; // Short or invalid.
                }

                // Figure out the acceptable low and high continuation bytes, starting
                // with our defaults.
                var accept_lo: u8 = lo_cb;
                var accept_hi: u8 = hi_cb;

                switch (info >> 4) {
                    0 => {},
                    1 => accept_lo = 0xA0,
                    2 => accept_hi = 0x9F,
                    3 => accept_lo = 0x90,
                    4 => accept_hi = 0x8F,
                    else => unreachable,
                }

                const c1 = remaining[i + 1];
                if (c1 < accept_lo or accept_hi < c1) {
                    return false;
                }

                switch (size) {
                    2 => i += 2,
                    3 => {
                        const c2 = remaining[i + 2];
                        if (c2 < lo_cb or hi_cb < c2) {
                            return false;
                        }
                        i += 3;
                    },
                    4 => {
                        const c2 = remaining[i + 2];
                        if (c2 < lo_cb or hi_cb < c2) {
                            return false;
                        }
                        const c3 = remaining[i + 3];
                        if (c3 < lo_cb or hi_cb < c3) {
                            return false;
                        }
                        i += 4;
                    },
                    else => unreachable,
                }
            }

            return true;
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝