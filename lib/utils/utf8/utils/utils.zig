// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Codepoint = @import("../mods/Codepoint/Codepoint.zig").Codepoint;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // All the functions here are designed to be used internally across a lot of other modules and its functions,
    // so most of the functions here are `inline` as expected and required,
    // and this module can be considered internal only, so to speak.
    // I have reasons for this that may not be obvious in the current form of the project.


    // ┌──────────────────────────── ----- ───────────────────────────┐

        /// Returns length of the codepoint depending on the first byte.
        /// - `error.InvalidValue` **_if the `value` is not valid a utf8 start byte._**
        pub inline fn lengthOfStartByte(value: u8) error{InvalidValue}!usize {
            return switch (value) {
                0b0000_0000...0b0111_1111 => 1,
                0b1100_0000...0b1101_1111 => 2,
                0b1110_0000...0b1110_1111 => 3,
                0b1111_0000...0b1111_0111 => 4,
                else => error.InvalidValue,
            };
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ----- ───────────────────────────┐

        /// Returns a slice of the first codepoint.
        pub inline fn firstCpSlice(value: []const u8) ?[]const u8 {
            if(!std.unicode.utf8ValidateSlice(value)) return null;
            if(value.len == 0) return null;
            return value[0..lengthOfStartByte(value[0]) catch null];
        }

        /// Returns the first codepoint.
        pub inline fn firstCp(value: []const u8) ?Codepoint {
            return Codepoint.init((firstCpSlice(value) orelse return null)) catch null;
        }

        /// Returns a slice of the last codepoint.
        pub inline fn lastCpSlice(value: []const u8) ?[]const u8 {
            if(value.len == 0) return null;
            var i : usize = value.len;
            while(i > 0) {
                const byte = value[i - 1];
                // check if the byte is part of the unicode sequence
                // and try to get the index of the start byte of this codepoint.
                if ((byte & 0xC0) != 0x80) return value[i-1 ..];
                i -= 1;
            }
            return null;
        }

        /// Returns the last codepoint.
        pub inline fn lastCp(value: []const u8) ?Codepoint {
            return Codepoint.init((lastCpSlice(value) orelse return null)) catch null;
        }

        /// Returns a slice of the first grapheme cluster.
        pub inline fn firstGcSlice(value: []const u8) ?[]const u8 {
            if(!std.unicode.utf8ValidateSlice(value)) return null;
            if(value.len == 0) return null;

            var iterator = std.unicode.Utf8Iterator{ .bytes = value, .i = 0 };
            var previous_codepoint :? Codepoint = null;
            var counted_length : usize = 0;

            while(iterator.nextCodepointSlice()) |curr_cp| {
                const current_codepoint = Codepoint.init(curr_cp) catch return null;

                // Check previous codepoint.
                if(previous_codepoint) |prev_cp| {
                    if(prev_cp.mode == .ZWJ or (prev_cp.mode == .None and current_codepoint.mode == .Mod)) {
                        counted_length += current_codepoint.len;
                        previous_codepoint = current_codepoint;
                        continue;
                    } else break;
                }

                // First Time.
                else counted_length += current_codepoint.len;

                // Check next codepoint.
                const original_i = iterator.i;
                if(iterator.nextCodepointSlice()) |next_cp| {
                    const next_codepoint = Codepoint.init(next_cp) catch return null;

                    if(next_codepoint.mode == .ZWJ) {
                        previous_codepoint = next_codepoint;
                        counted_length += next_codepoint.len;
                        continue;
                    }
                }

                // Reset the current iterator index if the next codepoint is not a jointer.
                iterator.i = original_i;

                // Update the previous codepoint to the current one.
                previous_codepoint = current_codepoint;
            }

            return value[0..counted_length];
        }

        /// Returns a slice of the last grapheme cluster.
        pub inline fn lastGcSlice(value: []const u8) ?[]const u8 {
            // TODO: clean this up.

            if(!std.unicode.utf8ValidateSlice(value)) return null;
            if(value.len == 0) return null;

            // Use lastCp to quickly find the last codepoint in the string
            var last_end_i : usize = value.len;
            var last_beg_i : usize = value.len;
            var current_i : usize = value.len;
            var next_of_current_cp_was_None : bool = true;

            // Iterate through the codepoint sequence backwards
            while (true) {
                // Use lastCp to quickly find the last codepoint in the string
                const current_cp = lastCp(value[0..current_i]) orelse return null;

                if(current_cp.len == 1) return value[last_beg_i-1..last_end_i];

                last_beg_i -= current_cp.len;
                current_i = last_beg_i;

                if(next_of_current_cp_was_None){
                    last_end_i = current_i+current_cp.len;
                }

                // is the current is Modifier or ZWJ ? skip
                if(current_cp.mode == .Mod or current_cp.mode == .ZWJ) {
                    next_of_current_cp_was_None = false;
                    continue;
                }

                if(current_i == 0) {
                    return value[last_beg_i..last_end_i];
                } else {
                    while(true) {
                        const prev_cp = lastCp(value[0..last_beg_i]) orelse return value[last_beg_i..last_end_i];

                        last_beg_i -= prev_cp.len;
                        current_i = last_beg_i;

                        if(prev_cp.mode == .ZWJ) continue;

                        if(!next_of_current_cp_was_None or prev_cp.len == 1) return value[last_beg_i+prev_cp.len..last_end_i];

                        return value[last_beg_i..last_end_i];
                    }
                }

                next_of_current_cp_was_None = true;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ----- ───────────────────────────┐

        pub const getRealPositionError   = error { InvalidValue, OutOfRange };
        pub const getVisualPositionError = getRealPositionError;

        /// Returns the real position in the array based on the visual position.
        /// - `getRealPositionError.OutOfRange` **_if `visual_pos` is out of range._**
        /// - `getRealPositionError.InvalidValue` **_if `value` is not valid UTF-8._**
        pub inline fn getRealPosition(value: []const u8, visual_pos: usize) getRealPositionError!usize {
            if(visual_pos > value.len) return getRealPositionError.OutOfRange;

            var i: usize = 0;
            var j: usize = 0;

            while (i < value.len and value[i] != 0 and j < visual_pos) {
                i += (firstGcSlice(value[i..]) orelse return getRealPositionError.InvalidValue).len;
                j += 1;
            }

            return i;
        }

        /// Returns the visual position in the array based on the real position.
        /// - `getVisualPositionError.OutOfRange` **_if `real_pos` is out of range._**
        /// - `getVisualPositionError.InvalidValue` **_if `value` is not valid UTF-8._**
        pub inline fn getVisualPosition(value: []const u8, real_pos: usize) getVisualPositionError!usize {
            if (real_pos > value.len) return getVisualPositionError.OutOfRange;

            var i: usize = 0;
            var j: usize = 0;

            while (i < value.len and value[i] != 0 and i < real_pos) {
                i += (firstGcSlice(value[i..]) orelse return getRealPositionError.InvalidValue).len;
                j += 1;
            }

            return j;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ----- ───────────────────────────┐

        pub const isValid = std.unicode.utf8ValidateSlice;

    // └──────────────────────────────────────────────────────────────┘


// ╚══════════════════════════════════════════════════════════════════════════════════╝