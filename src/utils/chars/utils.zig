// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const types = @import("./types.zig").types;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // Everything here are used [ONLY] internally.

    /// Returns true if the given argument is a valid single character type.
    pub inline fn isCtype(arg: anytype) bool {
        const T = @TypeOf(arg);
        return T == types.char or T == comptime_int;
    }

    /// Returns true if the given argument is a valid unsigned type.
    pub inline fn isUtype(arg: anytype) bool {
        const T = @TypeOf(arg);
        return T == types.len or T == comptime_int;
    }

    /// Returns true if the given argument is a valid solo type.
    pub inline fn isSoloType(comptime T: type) bool {
        const I = @typeInfo(T);
        return I != .Struct and I != .Array;
    }

    /// Returns true if a byte is part of a multi-byte Unicode character.
    pub inline fn isPartOfUTF8(_byte: types.char) bool {
        return ((_byte & 0x80) > 0) and (((_byte << 1) & 0x80) == 0);
    }

    /// Returns the size (in bytes) of the Unicode character.
    /// Given the first byte of a UTF-8 codepoint, returns a number 1-4 indicating the total length of the codepoint in bytes.
    pub inline fn sizeOf(_char: types.char) types.len {
        return std.unicode.utf8ByteSequenceLength(_char) catch 1;
    }

    /// Returns the real index of a Unicode character.
    pub inline fn indexOf(_str: types.cstr, _pos: types.len) ?types.len {
        var i: types.len = 0; // index
        var j: types.len = 0; // sub index
        while (i < _str.len and j < _pos) {
            i += sizeOf(_str[i]);
            j += 1;
        }
        return if (j == _pos) i else null;
    }

    /// Returns the starting byte position of the Unicode character at a given index
    /// if the character is a part of a multi-byte character.
    pub inline fn begOf(_str: types.cstr, _pos: types.len) types.len {
        var i: types.len = _pos;
        while(i > 0 and isPartOfUTF8(_str[i])) : (i -= 1) {}
        return _pos - i;
    }

    /// Returns the real range of the given position.
    pub inline fn rangeOf(_it: types.cstr, _pos: anytype) types.range {
        if(!isSoloType(@TypeOf(_pos))) {

            var l_range: types.range = _pos;

            // get beg of first elem
            if(indexOf(_it, _pos[0])) |l_pos| { l_range[0] = l_pos; } else unreachable;

            // get end of last elem
            if(indexOf(_it, _pos[1])) |l_pos| { l_range[1] = l_pos; } else unreachable;

            return l_range;
        }
        else {
            if(indexOf(_it, _pos)) |l_pos| { return realRangeOf(_it, l_pos); }
            else unreachable;
        }
    }

    /// Returns the real range of the given position (The real position).
    pub inline fn realRangeOf(_it: types.cstr, _pos: anytype) types.range {
        if(!isSoloType(@TypeOf(_pos))) {
            return _pos;
        } else {
            var l_range: types.range = .{ _pos, _pos+1 };
            if(sizeOf(_it[_pos]) > 1) {
                l_range[0] = _pos - begOf(_it[0..], _pos);
                l_range[1] = _pos + sizeOf(_it[l_range[0]]);
            }
            return l_range;
        }
    }

    /// Moves a range of elements in the string to the right without overlapping.
    /// `_src`: Source string.
    /// `_start`: Starting index of the range to move.
    /// `_count`: Number of elements to move.
    /// `_shift`: Number of positions to shift the elements to the right.
    pub inline fn moveRight(_src: types.str, _start: types.len, _count: types.len, _shift: types.len) void {
        if (_shift == 0 or _count == 0) return;
        var i: types.len = _start + _count;
        while (i > _start) : (i -= 1) {
            _src[i + _shift - 1] = _src[i - 1];
        }
    }

    /// Moves a range of elements in the string to the left without overlapping.
    /// `_src`: Source string.
    /// `_start`: Starting index of the range to move.
    /// `_count`: Number of elements to move.
    /// `_shift`: Number of positions to shift the elements to the left.
    pub inline fn moveLeft(_src: types.str, _start: types.len, _count: types.len, _shift: types.len) void {
        if (_shift == 0 or _count == 0) return;
        var i: types.len = _start;
        while (i < _start + _count) : (i += 1) {
            _src[i - _shift] = _src[i];
        }
    }

    /// Copies the given string to another string.
    pub inline fn copy(_to: types.str, _len: types.len, _from: types.cstr) void {
        var i: types.len = 0;
        while (i < _from.len) : (i += 1) { _to[_len + i] = _from[i]; }
    }

    /// Prints the given string (followed by a newline) to the console.
    pub inline fn print(_str: types.cstr) void {
        std.debug.print("{s}\n", .{_str});
    }

    /// Changes the case of the given string.
    pub inline fn changeCase(_it: types.str, func: fn (types.char) types.char) void {
        var i: types.len = 0;
        while (i < _it.len) {
            const l_size = sizeOf(_it[i]);
            if (l_size == 1) _it[i] = func(_it[i]);
            i += l_size;
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝