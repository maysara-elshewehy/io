// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const types = @import("./types.zig").types;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Returns true if the given argument is a valid single character type.
    pub inline fn isCtype(comptime T: type) bool {
        return T == types.char or T == comptime_int;
    }

    /// Returns true if the given argument is a valid unsigned type.
    pub inline fn isUtype(comptime T: type) bool {
        return T == types.unsigned or T == comptime_int;
    }

    /// Returns true if a byte is part of a multi-byte Unicode character.
    pub inline fn isPartOfUTF8(_byte: types.char) bool {
        return ((_byte & 0x80) > 0) and (((_byte << 1) & 0x80) == 0);
    }

    /// Returns the size (in bytes) of the Unicode character.
    /// Given the first byte of a UTF-8 codepoint, returns a number 1-4 indicating the total length of the codepoint in bytes.
    pub inline fn sizeOf(_char: types.char) types.unsigned {
        return std.unicode.utf8ByteSequenceLength(_char) catch { return 1; };
    }

    /// Returns the real index of a Unicode character.
    pub inline fn indexOf(_str: types.cstr, _pos: types.unsigned) ?types.unsigned {
        var i: types.unsigned = 0; // index
        var j: types.unsigned = 0; // sub index
        while (i < _str.len and j < _pos) {
            i += sizeOf(_str[i]);
            j += 1;
        }
        return if (j == _pos) i else null;
    }

    /// Returns the starting byte position of the Unicode character at a given index
    /// if the character is a part of a multi-byte character.
    pub inline fn begOf(_str: types.cstr, _pos: types.unsigned) types.unsigned {
        var i: types.unsigned = _pos;
        while(i > 0 and isPartOfUTF8(_str[i])) : (i -= 1) {}
        return _pos - i;
    }

    /// Returns the real range of the given position.
    pub inline fn rangeOf(_it: types.cstr, _pos: anytype) types.range {
        if(isUtype(@TypeOf(_pos))) {
            if(indexOf(_it, _pos)) |l_pos| { return realRangeOf(_it, l_pos); }
            else unreachable;
        }
        else {
            var l_range: types.range = _pos;

            // get beg of first elem
            if(indexOf(_it, _pos[0])) |l_pos| { l_range[0] = l_pos; } else unreachable;

            // get end of last elem
            if(indexOf(_it, _pos[1])) |l_pos| { l_range[1] = l_pos; } else unreachable;

            return l_range;
        }
    }

    /// Returns the real range of the given position (The real position).
    pub inline fn realRangeOf(_it: types.cstr, _pos: anytype) types.range {
        if(isUtype(@TypeOf(_pos))) {
            var l_range: types.range = .{ _pos, _pos+1 };
            if(sizeOf(_it[_pos]) > 1) {
                l_range[0] = _pos - begOf(_it[0..], _pos);
                l_range[1] = _pos + sizeOf(_it[l_range[0]]);
            }
            return l_range;
        } else {
            return _pos;
        }
    }

    /// Moves a range of elements in the string to the right without overlapping.
    /// `_src`: Source string.
    /// `_start`: Starting index of the range to move.
    /// `_count`: Number of elements to move.
    /// `_shift`: Number of positions to shift the elements to the right.
    pub inline fn move_right(_src: types.str, _start: types.unsigned, _count: types.unsigned, _shift: types.unsigned) void {
        if (_shift == 0 or _count == 0) return;
        var i: types.unsigned = _start + _count;
        while (i > _start) : (i -= 1) {
            _src[i + _shift - 1] = _src[i - 1];
        }
    }

    /// Moves a range of elements in the string to the left without overlapping.
    pub inline fn move_left(_src: types.str, _start: types.unsigned, _count: types.unsigned, _shift: types.unsigned) void {
        if (_shift == 0 or _count == 0) return;
        var i: types.unsigned = _start;
        while (i < _start + _count) : (i += 1) {
            _src[i - _shift] = _src[i];
        }
    }

    /// Appends a substring or character into the end of the string.
    pub inline fn copy(_to: types.str, _len: types.unsigned, _from: types.cstr) void {
        var i: types.unsigned = 0;
        while (i < _from.len) : (i += 1) { _to[_len + i] = _from[i]; }
    }

    /// Prints the given string (followed by a newline) to the console.
    pub inline fn print(_str: types.cstr) void {
        std.debug.print("{s}\n", .{_str});
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝