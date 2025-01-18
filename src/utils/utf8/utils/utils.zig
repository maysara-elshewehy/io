// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const bytes = @import("../../bytes/bytes.zig");
    const Codepoint = @import("../mods/Codepoint/Codepoint.zig").Codepoint;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Error for `lengthOfFirst`
    const lengthOfFirstError = error { InvalidValue };

    /// Returns length of the codepoint depending on the first byte **if single-byte**,
    /// or total length of the first grapheme cluster **if multi-byte**.
    /// - `InvalidValueError.InvalidValue` **_if the `value` is multi-byte and is not a valid utf8 byte._**
    /// - `InvalidValueError.InvalidValue` **_if the `value` is single-byte and not valid a utf8 start byte._**
    pub fn lengthOfFirst(value: anytype) lengthOfFirstError!usize {
        // Single-byte
        if(bytes.isByte(value)) {
            return std.unicode.utf8ByteSequenceLength(value) catch lengthOfFirstError.InvalidValue;
        }
        
        // Multi-byte
        else if(bytes.isBytes(value)) {
            if(!std.unicode.utf8ValidateSlice(value)) return lengthOfFirstError.InvalidValue;
            var iterator = std.unicode.Utf8Iterator{ .bytes = value, .i = 0 };
            var previous_codepoint :? Codepoint = null;
            var result : usize = 0;

            while(iterator.nextCodepointSlice()) |curr_cp| {
                const current_codepoint = try Codepoint.init(curr_cp);

                // Check previous codepoint.
                if(previous_codepoint) |prev_cp| {
                    if(prev_cp.mode == .ZWJ or (prev_cp.mode == .None and current_codepoint.mode == .Mod)) {
                        result += current_codepoint.len;
                        previous_codepoint = current_codepoint;
                        continue;
                    } else break;
                }

                // First Time.
                else result += current_codepoint.len;

                // Check next codepoint.
                const original_i = iterator.i;
                if(iterator.nextCodepointSlice()) |next_cp| {
                    const next_codepoint = try Codepoint.init(next_cp);

                    if(next_codepoint.mode == .ZWJ) {
                        previous_codepoint = next_codepoint;
                        result += next_codepoint.len;
                        continue;
                    }
                }
                
                // Reset the current iterator index if the next codepoint is not a jointer.
                iterator.i = original_i;

                // Update the previous codepoint to the current one.
                previous_codepoint = current_codepoint;
            }

            return result;
        }
        
        // Otherwise
        return lengthOfFirstError.InvalidValue;
    }

    pub const isValid = std.unicode.utf8ValidateSlice;

// ╚══════════════════════════════════════════════════════════════════════════════════╝