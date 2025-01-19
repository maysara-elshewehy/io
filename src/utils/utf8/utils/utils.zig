// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Codepoint = @import("../mods/Codepoint/Codepoint.zig").Codepoint;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌──────────────────────────── COUNT ───────────────────────────┐

        /// Returns length of the codepoint depending on the first byte.
        /// - `lengthOfStartByteError.InvalidValue` **_if the `value` is not valid a utf8 start byte._**
        pub fn lengthOfStartByte(value: u8) lengthOfStartByteError!usize {
            return std.unicode.utf8ByteSequenceLength(value) catch lengthOfStartByteError.InvalidValue;
        }
        pub const lengthOfStartByteError = error { InvalidValue };

        /// Returns total length of the first grapheme cluster.
        /// - `lengthOfFirstGraphemeError.InvalidValue` **_if the `value` is not a valid utf8._**
        pub fn lengthOfFirstGrapheme(value: []const u8) lengthOfFirstGraphemeError!usize {
            if(!std.unicode.utf8ValidateSlice(value)) return lengthOfFirstGraphemeError.InvalidValue;
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
        pub const lengthOfFirstGraphemeError = lengthOfStartByteError;

        /// Returns the real position in the array based on the visual position.
        /// - `getRealPositionError.OutOfRange` **_if `visual_pos` is out of range._**
        /// - `getRealPositionError.InvalidValue` **_if `value` is not valid UTF-8._**
        pub fn getRealPosition(value: []const u8, visual_pos: usize) getRealPositionError!usize {
            if(visual_pos > value.len) return getRealPositionError.OutOfRange;

            var i: usize = 0;

            while (i < value.len and value[i] != 0 and i < visual_pos) {
                i += try lengthOfFirstGrapheme(value[i..]);
            }

            return i;
        }
        pub const getRealPositionError = lengthOfStartByteError || error { OutOfRange };

        /// Returns the visual position in the array based on the real position.
        /// - `getVisualPositionError.OutOfRange` **_if `real_pos` is out of range._**
        /// - `getVisualPositionError.InvalidValue` **_if `value` is not valid UTF-8._**
        pub fn getVisualPosition(value: []const u8, real_pos: usize) getVisualPositionError!usize {
            if (real_pos > value.len) return getVisualPositionError.OutOfRange;

            var i: usize = 0;
            var _VisualPosition: usize = 0;

            while (i < value.len and value[i] != 0 and i < real_pos) {
                i += try lengthOfFirstGrapheme(value[i..]);
                _VisualPosition += 1;
            }

            return _VisualPosition;
        }
        pub const getVisualPositionError = getRealPositionError;

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── VALID ───────────────────────────┐

        ///
        pub const isValid = std.unicode.utf8ValidateSlice;

    // └──────────────────────────────────────────────────────────────┘


// ╚══════════════════════════════════════════════════════════════════════════════════╝