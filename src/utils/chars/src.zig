// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");

    /// Utilities for `io.utils.chars` unit.
    pub const utils = @import("./utils.zig");

    /// Data type structure for the `io.utils.chars` unit.
    pub const types = @import("./types.zig").types;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌──────────────────────────── HELP ────────────────────────────┐

        /// Returns a fixed-sized array of characters depending on the specified size and value (at compile-time).
        pub inline fn make(comptime _size: comptime_int, comptime _with :? types.cstr) [_size]types.char {
            if(_with) |_src| {
                var t_res : [_size]types.char = undefined;
                append(t_res[0..], 0, _src);
                return t_res;
            }
            return undefined;
        }

        /// Returns the number of characters in the string.
        pub inline fn bytes(_it: types.cstr) types.unsigned {
            var i: types.unsigned = 0;
            while (i < _it.len) { if(_it[i] == 0) break; i += 1; }
            return i;
        }

        /// Returns the number of characters in the string (Unicode characters are counted as regular characters).
        pub inline fn ubytes(_it: types.cstr) types.unsigned {
            var i: types.unsigned = 0;
            var j: types.unsigned = 0;
            while (i < _it.len) {
                if(_it[i] == 0) break;
                i += utils.sizeOf(_it[i]);
                j += 1;
            }
            return j;
        }

        /// Returns the size of the specified (array of characters : The actual size of the array)
        /// or (single character : Given the first byte of a UTF-8 codepoint, returns a number 1-4 indicating the total length of the codepoint in bytes).
        pub inline fn size(_it: anytype) types.unsigned {
            if(utils.isCharType(@TypeOf(_it))) { return utils.sizeOf(_it); }
            else { return _it.len; }
        }

        /// Returns the (`unicode` or `char`) at the specified position(non-real) in the string.
        pub inline fn get(_in: types.cstr, _pos: types.unsigned) ?types.cstr {
            if (utils.indexOf(_in, _pos)) |i| {
                const l_size = utils.sizeOf(_in[i]);
                return _in[i..(i + l_size)];
            }
            return null;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── INSERT ───────────────────────────┐

        /// Inserts a (`string` or `char`) into the end of the string.
        pub inline fn append(_to: types.str, _len: types.unsigned, _it: anytype) void {
            if (utils.isCharType(@TypeOf(_it))) {
                _to[_len] = _it;
            } else {
                utils.copy(_to, _len, _it);
            }
        }

        /// Inserts a (`string` or `char`) into the beginning of the string.
        pub inline fn prepend(_to: types.str, _len: types.unsigned, _it: anytype) void {
            if (utils.isCharType(@TypeOf(_it))) {
                utils.moveRight(_to[0..], 0, _len, 1);
                _to[0] = _it;
            } else {
                utils.moveRight(_to[0..], 0, _len, _it.len);
                utils.copy(_to, 0, _it);
            }
        }

        /// Inserts a (`string` or `char`) into a specific position in the string.
        pub inline fn insert(_to: types.str, _len: types.unsigned, _it: anytype, _pos: types.unsigned) void {
            if(_pos == _len) return append(_to, _len, _it);
            if(_pos == 0) return prepend(_to, _len, _it);

            if(utils.indexOf(_to, _pos)) |_i| {
                if (utils.isCharType(@TypeOf(_it))) {
                    utils.moveRight(_to[0..], _i, _len, 1);
                    _to[_i] = _it;
                } else {
                    utils.moveRight(_to[0..], _i, _len-_i, _it.len);
                    utils.copy(_to, _i, _it);
                }
            }
        }

        /// Inserts a (`string` or `char`) into a specific position in the string.
        pub inline fn insertReal(_to: types.str, _len: types.unsigned, _it: anytype, _pos: types.unsigned) void {
            if(_pos == _len) return append(_to, _len, _it);
            if(_pos == 0) return prepend(_to, _len, _it);
            if (utils.isCharType(@TypeOf(_it))) {
                utils.moveRight(_to[0..], _pos, _len, 1);
                _to[_pos] = _it;
            } else {
                utils.moveRight(_to[0..], _pos, _len, _it.len);
                utils.copy(_to, _pos - utils.begOf(_to[0..], _pos), _it);
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REMOVE ───────────────────────────┐

        /// Removes a (`range` or `position`) from the string.
        pub inline fn remove(_from: types.str, _it: anytype) void {
            const l_range = if(utils.isUnsignedType(@TypeOf(_it))) utils.rangeOf(_from, _it) else _it;
            var i : types.unsigned = l_range[1];
            while (i < _from.len) : (i += 1) { _from[i - (l_range[1] - l_range[0])] = _from[i]; }
        }

        /// Removes a (`range` or `position`) from the string.
        pub inline fn removeReal(_from: types.str, _it: anytype) void {
            const l_range = if(utils.isUnsignedType(@TypeOf(_it))) .{ _it, _it+1} else _it;
            var i : types.unsigned = l_range[1];
            while (i < _from.len) : (i += 1) { _from[i - (l_range[1] - l_range[0])] = _from[i]; }
        }

        /// Removes a (`N` bytes) from the beginning of the string.
        pub inline fn shift(_from: types.str, _len: types.unsigned, _bytes: types.unsigned) void {
            utils.moveLeft(_from[0..], _bytes, _len-_bytes, _bytes);
            _from[_len - _bytes] = 0;
        }

        /// Removes a (`N` bytes) from the end of the string (using `/0`).
        pub inline fn pop(_from: types.str, _len: types.unsigned, _bytes: types.unsigned) void {
            _from[_len - _bytes] = 0;
        }

        /// Fills the string with (`\0` character).
        pub inline fn zeros(_it: types.str) void {
            for (_it) |*byte| { byte.* = 0; }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── TRIM ────────────────────────────┐

        /// Removes all matching characters at the beginning of the string.
        pub inline fn trimStart(_it: types.str, _char: types.char) types.unsigned {
            const l_len = _it.len;
            var i: types.unsigned = 0;
            while (i < l_len) : (i += 1) { if (_it[i] != _char) break; }
            if (i > 0) shift(_it, l_len, i);
            return i;
        }

        /// Removes all matching characters at the end of the string.
        pub inline fn trimEnd(_it: types.str, _char: types.char) types.unsigned {
            const l_len = _it.len;
            var i: types.unsigned = l_len;
            while (i > 0) : (i -= 1) { if (_it[i-1] != _char) break; }
            if (i < l_len) pop(_it, l_len, l_len - i);
            return l_len - i;
        }

        /// Removes all matching characters fromt both start and end of the string.
        pub inline fn trim(_it: types.str, _char: types.char) types.unsigned {
            const l_beg = trimStart(_it[0.._it.len], _char);
            const l_end = trimEnd(_it[0.._it.len-l_beg], _char);
            return l_beg + l_end;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── FIND ────────────────────────────┐

        /// Returns the first occurrence of a (`string` or `char`) in the string.
        pub inline fn find(_in: types.cstr, _it: anytype) ?types.unsigned {
            if (utils.isCharType(@TypeOf(_it))) {
                return std.mem.indexOf(types.char, _in[0.._in.len], &[_]types.char{_it});
            } else {
                return std.mem.indexOf(types.char, _in[0.._in.len], _it);
            }
        }

        /// Returns the last occurrence of a (`string` or `char`) in the string.
        pub inline fn rfind(_in: types.cstr, _it: anytype) ?types.unsigned {
            if (utils.isCharType(@TypeOf(_it))) {
                return std.mem.lastIndexOf(types.char, _in[0.._in.len], &[_]types.char{_it});
            } else {
                return std.mem.lastIndexOf(types.char, _in[0.._in.len], _it);
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── CASE ────────────────────────────┐

        /// Converts all (ASCII) letters to lowercase.
        pub inline fn toLower(_it: anytype) void {
            var i: types.unsigned = 0;
            while (i < _it.len) {
                const l_size = utils.sizeOf(_it[i]);
                if (l_size == 1) _it[i] = std.ascii.toLower(_it[i]);
                i += l_size;
            }
        }

        /// Converts all (ASCII) letters to uppercase.
        pub inline fn toUpper(_it: anytype) void {
            var i: types.unsigned = 0;
            while (i < _it.len) {
                const l_size = utils.sizeOf(_it[i]);
                if (l_size == 1) _it[i] = std.ascii.toUpper(_it[i]);
                i += l_size;
            }
        }

        // Converts all (ASCII) words to titlecase.
        pub inline fn toTitle(_it: anytype) void {
            var l_isNew: bool = true;
            var i: types.unsigned = 0;
            while (i < _it.len) {
                const char = _it[i];
                if (std.ascii.isWhitespace(char)) { l_isNew = true; i += 1; continue; }
                if (l_isNew) { _it[i] = std.ascii.toUpper(char); l_isNew = false; }
                i += 1;
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── CHECKS ───────────────────────────┐

        /// Returns true if the given strings are equivalent.
        pub inline fn eql(_str1: types.cstr, _str2: types.cstr) bool {
            return std.mem.eql(u8, _str1[0..], _str2[0..]);
        }

        /// Returns true if the string starts with the given substring.
        pub inline fn startsWith(_it: types.cstr, _with: types.cstr) bool {
            const i = std.mem.indexOf(u8, _it[0.._it.len], _with);
            return i == 0;
        }

        /// Returns true if the string ends with the given substring.
        pub inline fn endsWith(_it: types.cstr, _with: types.cstr) bool {
            const i = std.mem.lastIndexOf(u8, _it[0.._it.len], _with);
            return i == _it.len - _with.len;
        }

        /// Returns true if the string contains a (`string` or `char`).
        pub inline fn includes(_in: types.cstr, _it: anytype) bool {
            if(find(_in, _it)) |_| { return true; }
            return false;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌─────────────────────────── REPLACE ──────────────────────────┐

        /// Replaces the first `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
        pub inline fn replace(_in: types.str, _len: types.unsigned, _it: anytype, _with: anytype, _count: types.unsigned) types.unsigned {
            var i = find(_in[0..], _it);
            var l_count: types.unsigned = 0;
            const it_len = if(utils.isCharType(@TypeOf(_it))) 1 else _it.len;
            while (i != null) {
                removeReal(_in[0..], .{ i.?, i.? + it_len });
                insertReal(_in[0..], _len-it_len, _with, i.?);
                i = find(_in[0..], _it);
                l_count += 1;
                if (l_count == _count) break;
            }
            return l_count;
        }

        /// Replaces the last `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
        pub inline fn rreplace(_in: types.str, _len: types.unsigned, _it: anytype, _with: anytype, _count: types.unsigned) types.unsigned {
            var i = rfind(_in[0..], _it);
            var l_count: types.unsigned = 0;
            const it_len = if(utils.isCharType(@TypeOf(_it))) 1 else _it.len;
            while (i != null) {
                removeReal(_in[0..], .{ i.?, i.? + it_len });
                insertReal(_in[0..], _len-it_len, _with, i.?);
                i = rfind(_in[0..], _it);
                l_count += 1;
                if (l_count == _count) break;
            }
            return l_count;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── MORE ────────────────────────────┐

        /// Repeats the (`string` or `char`) `N` times.
        pub inline fn repeat(_in: types.str, _len: types.unsigned, _it: anytype, _count: types.unsigned) void {
            var i: types.unsigned = 0;
            const _itLen = if(utils.isCharType(@TypeOf(_it))) 1 else _it.len;
            while (i < _count) {
                append(_in[0..], _len + (_itLen*i) , _it);
                i += 1;
            }
        }

        /// Reverses the characters in the string.
        pub inline fn reverse(_it: types.str) void {
            const l_len = _it.len;
            var i: types.unsigned = 0;
            while (i < l_len) {
                const t_size = utils.sizeOf(_it[i]);
                if (t_size > 1) std.mem.reverse(u8, _it[i..(i + t_size)]);
                i += t_size;
            }
            std.mem.reverse(u8, _it[0..l_len]);
        }

        /// Splits the string into a slice based on a delimiter and a target position.
        pub inline fn split(_it: types.cstr, _by: types.cstr, _pos: types.unsigned) ?types.cstr {
            var i: types.unsigned = 0;
            var l_block: types.unsigned = 0;
            var l_start: types.unsigned = 0;
            while (i < _it.len) {
                const l_size = utils.sizeOf(_it[i]);
                if (l_size == _by.len) {
                    if (std.mem.eql(u8, _by, _it[i..(i + l_size)])) {
                        if (l_block == _pos) return _it[l_start..i];
                        l_start = i + l_size;
                        l_block += 1;
                    }
                }
                i += l_size;
            }
            if (i >= _it.len - 1 and l_block == _pos) { return _it[l_start.._it.len]; }
            return null;
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝