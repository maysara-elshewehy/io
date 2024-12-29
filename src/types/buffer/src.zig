// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const chars = @import("../../utils/chars/src.zig");
    const types = chars.types;

    pub const Error = error {
        OutOfMemory,
        InvalidIndex,
        FmtError,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Fixed array of characters.
    pub fn buffer_t(comptime TYPE: type, comptime SIZE: usize) type {
        return struct {
            const Self = @This();
            /// Array of characters to store the content.
            m_buff:  [SIZE]TYPE,
            /// Size of the string.
            m_size: types.len,
            /// Length of the string.
            m_bytes: types.len,


            // ┌─────────────────────────── BASICS ───────────────────────────┐

                /// Returns the number of characters in the string.
                pub fn bytes(_self: Self) types.len {
                    return _self.m_bytes;
                }

                /// Returns the number of characters in the string (Unicode characters are counted as regular characters).
                pub fn ubytes(_self: Self) types.len {
                    if (_self.m_bytes > 0) return chars.ubytes(_self.m_buff[0.._self.m_bytes]);
                    return 0;
                }

                /// Returns the size of the string.
                pub fn size(_self: Self) types.len {
                    return _self.m_size;
                }

                // /// Returns the source of the string.
                // pub fn src(_self: Self) types.cstr {
                //     if(_self.m_bytes > 0) return _self.m_buff[0.._self.m_bytes];
                //     return "";
                // }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── INSERT ───────────────────────────┐

                /// Inserts a (`string` or `char`) into the `end` of the string.
                pub fn append(_self: *Self, _it: anytype) Error!void {
                    return insertReal(_self, _it, _self.m_bytes);
                }

                /// Inserts a (`string` or `char`) into the `beg` of the string.
                pub fn prepend(_self: *Self, _it: anytype) Error!void {
                    return insertReal(_self, _it, 0);
                }

                /// Inserts a (`string` or `char`) into a `specific position` in the string.
                pub fn insert(_self: *Self, _it: anytype, _pos: types.len) Error!void {
                    return insertReal(_self, _it, chars.utils.indexOf(_self.m_buff[0.._self.m_bytes], _pos) orelse return Error.InvalidIndex);
                }

                /// Inserts a (`string` or `char`) into a `specific position` (The real position) in the string.
                /// @Error: InvalidIndex (If the position is out of range).
                pub fn insertReal(_self: *Self, _it: anytype, _pos: types.len) Error!void {
                    if(_pos > _self.m_bytes) return Error.InvalidIndex;

                    if(@TypeOf(_it) == Self) return _self.insertReal(_it.src(), _pos);
                    const l_count = if(chars.utils.isCtype(_it)) 1 else _it.len;

                    if(_pos == _self.m_bytes) {
                        if ( (_self.m_bytes + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        chars.append(_self.m_buff[0.._self.m_size], _self.m_bytes, _it);
                    }
                    else if(_pos == 0) {
                        if ( (_self.m_bytes + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        chars.prepend(_self.m_buff[0..], _self.m_bytes, _it);
                    } else {
                        if ( (_pos + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        chars.insertReal(_self.m_buff[0.._self.m_size], _self.m_bytes, _it, _pos);
                    }

                    _self.m_bytes += l_count;
                }

                /// Creates a new empty buffer.
                pub fn init() Self {
                    return Self{
                        .m_size = 0,
                        .m_bytes = 0,
                        .m_buff = undefined,
                    };
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── REMOVE ───────────────────────────┐

                // This is a sensitive area for the library and everything else that will be built on it
                // so I prefer to leave the instructions clear without shortcuts
                // as I did for the insert functions above.

                /// Removes a (`range` or `position`) from the string.
                pub inline fn remove(_self: *Self, _it: anytype) Error!void {
                    if(_self.m_bytes == 0) return;

                    if(chars.utils.isUtype(_it)) {
                        if(chars.utils.indexOf(_self.m_buff[0.._self.m_bytes], _it)) |l_pos| {
                            const l_beg = l_pos - chars.utils.begOf(_self.m_buff[0..], l_pos);
                            const l_count = chars.utils.sizeOf(_self.m_buff[l_beg]);
                            chars.removeReal(_self.m_buff[0.._self.m_bytes], .{l_beg, l_beg+l_count});
                            _self.m_bytes -= l_count;
                        } else return Error.InvalidIndex;
                    }
                    else {
                        const l_range = chars.utils.rangeOf(_self.m_buff[0.._self.m_bytes], _it);
                        chars.remove(_self.m_buff[0.._self.m_bytes], _it);
                        _self.m_bytes -= l_range[1] - l_range[0];
                    }
                }

                /// Removes a (`range` or `position` (The real position)) from the string.
                pub inline fn removeReal(_self: *Self, _it: anytype) void {
                    if(_self.m_bytes == 0) return;

                    if(chars.utils.isUtype(_it)) {
                        const l_beg = _it - chars.utils.begOf(_self.m_buff[0..], _it);
                        const l_count = chars.utils.sizeOf(_self.m_buff[l_beg]);
                        chars.removeReal(_self.m_buff[0.._self.m_bytes], .{l_beg, l_beg+l_count});
                        _self.m_bytes -= l_count;
                    }
                    else {
                        const l_range = chars.utils.realRangeOf(_self.m_buff[0.._self.m_bytes], _it);
                        chars.removeReal(_self.m_buff[0.._self.m_bytes], _it);
                        _self.m_bytes -= l_range[1] - l_range[0];
                    }
                }

                /// Removes a (`N` bytes) from the `beg` of the string.
                pub inline fn shift(_self: *Self, _count: types.len) void {
                    if(_self.m_bytes == 0) return;

                    const l_count = chars.shift(_self.m_buff[0.._self.m_bytes], _self.m_bytes, _count);
                    _self.m_bytes -= if(_count == _self.m_bytes) _self.m_bytes else l_count;
                }

                /// Removes a (`N` bytes) from the `end` of the string.
                pub inline fn pop(_self: *Self, _count: types.len) void {
                    if(_self.m_bytes == 0) return;

                    const l_count = chars.pop(_self.m_buff[0.._self.m_bytes], _count);
                    _self.m_bytes -= if(_count == _self.m_bytes) _self.m_bytes else l_count;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── TRIM ────────────────────────────┐

                /// Removes all matching characters at the `beg` of the string.
                pub inline fn trimStart(_self: *Self, _char: types.char) void {
                    if(_self.m_bytes == 0) return;

                    const l_count = chars.trimStart(_self.m_buff[0.._self.m_bytes], _char);
                    _self.m_bytes -= if(l_count == _self.m_bytes) _self.m_bytes else l_count;
                }

                /// Removes all matching characters at the `end` of the string.
                pub inline fn trimEnd(_self: *Self, _char: types.char) void {
                    if(_self.m_bytes == 0) return;

                    const l_count = chars.trimEnd(_self.m_buff[0.._self.m_bytes], _char);
                    _self.m_bytes -= if(l_count == _self.m_bytes) _self.m_bytes else l_count;
                }

                /// Removes all matching characters fromt both `beg` and `end` of the string.
                pub inline fn trim(_self: *Self, _char: types.char) void {
                    _self.trimStart(_char);
                    _self.trimEnd(_char);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── FIND ────────────────────────────┐

                /// Returns the first occurrence of a (`string` or `char`) in the string.
                pub inline fn find(_self: *Self, _it: anytype) ?types.len {
                    if(@TypeOf(_it) == Self) return _self.find(_it.src());

                    return if(_self.m_bytes > 0) chars.find(_self.m_buff[0.._self.m_bytes], _it) else null;
                }

                /// Returns the last occurrence of a (`string` or `char`) in the string.
                pub inline fn rfind(_self: *Self, _it: anytype) ?types.len {
                    if(@TypeOf(_it) == Self) return _self.rfind(_it.src());

                    return if(_self.m_bytes > 0) chars.rfind(_self.m_buff[0.._self.m_bytes], _it) else null;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── CASE ────────────────────────────┐

                /// Converts all (ASCII) letters to lowercase.
                pub inline fn toLower(_self: *Self) void {
                    if(_self.m_bytes == 0) return;
                    chars.toLower(_self.m_buff[0.._self.m_bytes]);
                }

                /// Converts all (ASCII) letters to uppercase.
                pub inline fn toUpper(_self: *Self) void {
                    if(_self.m_bytes == 0) return;
                    chars.toUpper(_self.m_buff[0.._self.m_bytes]);
                }

                // Converts all (ASCII) words to titlecase.
                pub inline fn toTitle(_self: *Self) void {
                    if(_self.m_bytes == 0) return;
                    chars.toTitle(_self.m_buff[0.._self.m_bytes]);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── CHECKS ───────────────────────────┐

                /// Returns true if the string are equal to the given (`string` or `char`).
                pub inline fn eql(_self: Self, _with: anytype) bool {
                    if(@TypeOf(_with) == Self) return _self.eql(_with.src());

                    return chars.eql(_self.m_buff[0.._self.m_bytes], _with);
                }

                /// Returns true if the string starts with the given (`string` or `char`).
                pub inline fn startsWith(_self: Self, _with: anytype) bool {
                    if(@TypeOf(_with) == Self) return _self.startsWith(_with.src());

                    return chars.startsWith(_self.m_buff[0.._self.m_bytes], _with);
                }

                /// Returns true if the string ends with the given (`string` or `char`).
                pub inline fn endsWith(_self: Self, _with: anytype) bool {
                    if(@TypeOf(_with) == Self) return _self.startsWith(_with.src());

                    return chars.endsWith(_self.m_buff[0.._self.m_bytes], _with);
                }

                /// Returns true if the string contains a (`string` or `char`).
                pub inline fn includes(_self: Self, _it: anytype) bool {
                    if(@TypeOf(_it) == Self) return _self.includes(_it.src());
                    return chars.includes(_self.m_buff[0.._self.m_bytes], _it);
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── REPLACE ──────────────────────────┐

                /// Replaces the first `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
                pub inline fn replace(_self: *Self, _it: anytype, _with: anytype, _count: types.len) Error!types.len {
                    if(@TypeOf(_it) == Self) return _self.replace(_it.src(), _with, _count);
                    if(@TypeOf(_with) == Self) return _self.replace(_it, _with.src(), _count);

                    if(_self.m_bytes > 0) {
                        const l_size = chars.replacementSize(_self.m_buff[0.._self.m_bytes], _it, _count);
                        const l_withLen = chars.size(_with); // if char: 1, if unicode: 4, if string: size of array
                        const l_newLen = _self.m_bytes + (if(_count > 0) l_withLen * _count else l_withLen) - l_size;
                        if ( l_newLen > _self.m_size) { return Error.OutOfMemory; }

                        _ = chars.replace(_self.m_buff[0..], _self.m_bytes, _it, _with, _count);
                        _self.m_bytes = l_newLen;
                        return l_size;
                    }
                    return 0;
                }

                /// Replaces the last `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
                pub inline fn rreplace(_self: *Self, _it: anytype, _with: anytype, _count: types.len) Error!types.len {
                    if(@TypeOf(_it) == Self) return _self.rreplace(_it.src(), _with, _count);
                    if(@TypeOf(_with) == Self) return _self.rreplace(_it, _with.src(), _count);

                    if(_self.m_bytes > 0) {
                        const l_size = chars.replacementSize(_self.m_buff[0.._self.m_bytes], _it, _count);
                        const l_withLen = chars.size(_with); // if char: 1, if unicode: 4, if string: size of array
                        const l_newLen = _self.m_bytes + (if(_count > 0) l_withLen * _count else l_withLen) - l_size;
                        if ( l_newLen > _self.m_size) { return Error.OutOfMemory; }

                        _ = chars.rreplace(_self.m_buff[0..], _self.m_bytes, _it, _with, _count);
                        _self.m_bytes = l_newLen;
                        return l_size;
                    }
                    return 0;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── MORE ────────────────────────────┐

                /// Repeats the (`string` or `char`) `N` times.
                pub inline fn repeat(_self: *Self, _it: anytype, _count: types.len) Error!void {
                    if(_count == 0) return;
                    if(@TypeOf(_it) == Self) return _self.repeat(_it.src(), _count);

                    const l_size =  chars.size(_it) * _count;
                    if ( (_self.m_bytes + l_size) > _self.m_size) { return Error.OutOfMemory; }

                    _ = chars.repeat(_self.m_buff[0.._self.m_size], _self.m_bytes, _it, _count);
                    _self.m_bytes += l_size;
                }

                /// Reverses the characters in the string.
                pub inline fn reverse(_self: *Self) void {
                    if(_self.m_bytes > 0) {
                        chars.reverse(_self.m_buff[0.._self.m_bytes]);
                    }
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌──────────────────────────── SPLIT ───────────────────────────┐

                /// Returns a slice of the string split by the separator (`string` or `char`) at the specified position, or null if failed.
                pub inline fn split(_self: Self, _sep: anytype, _pos: types.len) ?types.cstr {
                    if(@TypeOf(_sep) == Self) return _self.split(_sep.src(), _pos);

                    if(_self.m_bytes > 0 and _pos < _self.m_bytes) {
                        return chars.split(_self.m_buff[0.._self.m_bytes], _sep, _pos);
                    }

                    return null;
                }

                /// Returns an array of slices of the string split by the separator (`string` or `char`).
                pub inline fn splitAll(_self: Self, _sep: anytype) Error![]types.cstr {
                    if(@TypeOf(_sep) == Self) return _self.splitAll(_sep.src());

                    var l_arr = std.ArrayList(types.cstr).init(std.heap.page_allocator);
                    defer l_arr.deinit();

                    var i: usize = 0;
                    while (_self.split(_sep, i)) |slice| : (i += 1) {
                        try l_arr.append(slice);
                    }

                    return try l_arr.toOwnedSlice();
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌─────────────────────────── WRITER ───────────────────────────┐

                pub usingnamespace struct {
                    /// The underlying type of the Writer returned by `writer()`.
                    pub const Writer = std.io.Writer(*Self, anyerror, __write);

                    /// Returns a writer for the string.
                    pub fn writer(_self: *Self) Writer {
                        return .{ .context = _self };
                    }

                    /// Writes a string to the writer.
                    fn __write(_self: *Self, _it: types.cstr) Error!types.len {
                        try _self.append(_it);
                        return _it.len;
                    }

                    /// Inserts a (`formatted string`) into the `end` of the string.
                    pub fn write(_self: *Self, comptime _fmt: types.cstr, _args: anytype) Error!void {
                        const l_count = std.fmt.count(_fmt, _args);
                        if ( (_self.m_bytes + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        _self.writer().print(_fmt, _args) catch return Error.FmtError;
                    }

                    /// Inserts a (`formatted string`) into the `beg` of the string.
                    pub fn writeStart(_self: *Self, comptime _fmt: types.cstr, _args: anytype) Error!void {
                        const l_count = std.fmt.count(_fmt, _args);
                        if ( (_self.m_bytes + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        chars.utils.moveRight(_self.m_buff[0.._self.m_size], 0, _self.m_bytes, l_count);
                        var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff[0..]);
                        const l_writer = l_fixedBufferStream.writer();
                        l_writer.print(_fmt, _args) catch return Error.FmtError;
                        _self.m_bytes += l_count;
                    }

                    /// Inserts a (`formatted string`) into a `specific position` in the string.
                    pub fn writeAt(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.len) Error!void {
                        if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                        if(_pos == 0) return _self.writeStart(_fmt, _args);

                        if ( (_pos + std.fmt.count(_fmt, _args)) > _self.m_size) { return Error.OutOfMemory; }
                        if(chars.utils.indexOf(_self.m_buff[0.._self.m_bytes], _pos)) |l_pos| {
                            return _self.writeAtReal(_fmt, _args, l_pos);
                        } else return Error.InvalidIndex;
                    }

                    /// Inserts a (`formatted string`) into a `specific position` (The real position) in the string.
                    pub fn writeAtReal(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.len) Error!void {
                        if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                        if(_pos == 0) return _self.writeStart(_fmt, _args);

                        const l_count = std.fmt.count(_fmt, _args);
                        if ( (_pos + l_count) > _self.m_size) { return Error.OutOfMemory; }
                        const l_beg = _pos - chars.utils.begOf(_self.m_buff[0..], _pos);
                        chars.utils.moveRight(_self.m_buff[0..], l_beg, _self.m_bytes-l_beg, l_count);

                        var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff[l_beg..]);
                        const l_writer = l_fixedBufferStream.writer();
                        l_writer.print(_fmt, _args) catch return Error.FmtError;
                        _self.m_bytes += l_count;
                    }
                };

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── ITERATOR ──────────────────────────┐

                pub usingnamespace struct {
                    /// Iterator of the string type.
                    pub const Iterator = struct {
                        /// String to iterate.
                        m_string: *const Self,
                        /// Current index.
                        m_index: types.len,

                        /// Returns the next character in the string.
                        pub fn next(_it: *Iterator) ?types.cstr {
                            if (_it.m_index == _it.m_string.m_size) return null;
                            const i = _it.m_index;
                            _it.m_index += chars.utils.sizeOf(_it.m_string.m_buff[i]);
                            return _it.m_string.m_buff[i.._it.m_index];
                        }
                    };

                    /// Returns an iterator for the string.
                    pub fn iterator(_self: *const Self) Iterator {
                        return Iterator{
                            .m_string = _self,
                            .m_index = 0,
                        };
                    }
                };

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── INTERNAL ──────────────────────────┐


            // └──────────────────────────────────────────────────────────────┘
        };
    }

    /// Creates a fixed array of characters.
    pub fn buffer(_buffer: anytype) buffer_t(@TypeOf(_buffer[0]), _buffer.*.len) {
        const l_bytes = chars.bytes(_buffer.*[0..]);
        const l_size = _buffer.*.len;
        return .{ .m_buff = _buffer.*, .m_size = l_size, .m_bytes = if(l_bytes == l_size) 0 else l_bytes };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝