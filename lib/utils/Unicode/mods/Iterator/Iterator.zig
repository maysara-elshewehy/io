// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const utils = @import("../../utils/utils.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// A _(`grapheme cluster`, `codepoint`)_ iterator for iterating over a slice of Bytes.
    pub const Iterator = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

            /// Unified error set of `iterator` functions.
            pub const Error = error { InvalidValue };

            /// Modes of the iterator.
            pub const modes = enum { codepoint, graphemeCluster };

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The input bytes to iterate over.
            input_bytes: []const u8,

            /// The current position of the iterator.
            current_index: usize,

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Initializes a Iterator with the given input Bytes.
            /// Returns `Error.InvalidValue` **_if the `input_bytes` is not a valid Unicode._**
            pub fn init(input_bytes: []const u8) Error!Self {
                if(!utils.Utf8Validate(input_bytes)) return Error.InvalidValue;
                return unsafeInit(input_bytes);
            }

            /// Initializes a Iterator with the given input Bytes.
            pub fn unsafeInit(input_bytes: []const u8) Self {
                return .{ .input_bytes = input_bytes, .current_index = 0, };
            }

            /// Retrieves the next codepoint slice and advances the iterator.
            pub fn nextSlice(self: *Self) ?[]const u8 {
                return self.getNextSlice(.codepoint);
            }

            /// Retrieves the next grapheme cluster slice and advances the iterator.
            pub fn nextGraphemeCluster(self: *Self) ?[]const u8 {
                return self.getNextSlice(.graphemeCluster);
            }

            /// Retrieves the next codepoint slice and advances the iterator.
            fn getNextSlice(self: *Self, mode: modes) ?[]const u8 {
                if (self.current_index >= self.input_bytes.len) return null;
                const cp_len = switch (mode) {
                    .codepoint => utils.lengthOfStartByte(self.input_bytes[self.current_index]) catch return null,
                    .graphemeCluster => (utils.firstGcSlice(self.input_bytes[self.current_index..]) orelse return null).len,
                };

                self.current_index += cp_len;
                return self.input_bytes[self.current_index - cp_len..self.current_index];
            }

            /// Decodes and returns the next codepoint and advances the iterator.
            pub fn next(self: *Self) ?u21 {
                const slice = self.nextSlice() orelse return null;
                return utils.Utf8Decode(slice[0..]) catch null;
            }

            /// Decodes and returns the next codepoint without advancing the iterator.
            pub fn peek(self: *Self, codepoints_count: usize) ?[]const u8 {
                const original_i = self.current_index;
                defer self.current_index = original_i;

                var end_ix = original_i;
                var found: usize = 0;
                while (found < codepoints_count) : (found += 1) {
                    const next_codepoint_slice = self.nextSlice() orelse return null;
                    end_ix += next_codepoint_slice.len;
                }

                return self.input_bytes[original_i..end_ix];
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝