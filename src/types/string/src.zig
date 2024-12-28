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

    /// Dynamic array of characters.
    pub const string = struct {
        const Self = @This();
        /// Nullable array of characters to store the content.
        m_buff: types.str = &.{},
        /// Allocator used for memory management.
        m_alloc: std.mem.Allocator,
        /// Size of the string.
        m_size: types.unsigned,
        /// Length of the string.
        m_bytes: types.unsigned,


        // ┌─────────────────────────── BASICS ───────────────────────────┐

            /// Returns the number of characters in the string.
            pub fn bytes(_self: Self) types.unsigned {
                return _self.m_bytes;
            }

            /// Returns the number of characters in the string (Unicode characters are counted as regular characters).
            pub fn ubytes(_self: Self) types.unsigned {
                if(_self.m_bytes > 0) return chars.ubytes(_self.m_buff[0.._self.m_bytes]);
                return 0;
            }

            /// Returns the size of the string.
            pub fn size(_self: Self) types.unsigned {
                return _self.m_size;
            }

            /// Returns the source of the string.
            pub fn src(_self: Self) types.cstr {
                if (_self.m_bytes > 0) return _self.m_buff[0.._self.m_bytes];
                return "";
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── INIT ────────────────────────────┐

            /// Initialize an empty string.
            pub fn init() Self {
                return .{
                    .m_buff = &.{},
                    .m_alloc = std.heap.page_allocator, // TODO: change this allocator.
                    .m_size = 0,
                    .m_bytes = 0,
                };
            }

            /// Initialize a string with an allocator and a given _(`string` or `char`)_.
            pub fn initWith(_it: anytype) Error!Self {
                var l_str = init();
                try l_str.append(_it);
                return l_str;
            }

            /// Deallocate the string buffer.
            pub fn deinit(_self: *Self) void {
                _self.m_alloc.free(_self.m_buff);
                _self.m_size = 0;
                _self.m_bytes = 0;
                _self.m_buff = &.{};
            }

            /// Allocate or reallocate the string buffer to a new size.
            pub fn allocate(_self: *Self, _bytes: types.unsigned) Error!void {
                if (_self.m_bytes > 0) {
                    if (_bytes < _self.m_size) _self.m_size = _bytes;
                    _self.m_buff = _self.m_alloc.realloc(_self.m_buff, _bytes) catch { return Error.OutOfMemory; };
                } else {
                    _self.m_buff = _self.m_alloc.alloc(types.char, _bytes) catch { return Error.OutOfMemory; };
                }
                _self.m_size = _bytes;
            }

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
            pub fn insert(_self: *Self, _it: anytype, _pos: types.unsigned) Error!void {
                return insertReal(_self, _it, chars.utils.indexOf(_self.src(), _pos) orelse unreachable);
            }

            /// Inserts a (`string` or `char`) into a `specific position` (The real position) in the string.
            /// @Error: InvalidIndex (If the position is out of range).
            pub fn insertReal(_self: *Self, _it: anytype, _pos: types.unsigned) Error!void {
                if(_pos > _self.m_bytes) return Error.InvalidIndex;

                if(@TypeOf(_it) == Self) return _self.insertReal(_it.src(), _pos);
                const l_count = if(chars.utils.isCtype(_it)) 1 else _it.len;

                if(_pos == _self.m_bytes) {
                    try _self.__alloc(l_count + _self.m_bytes);
                    chars.append(_self.m_buff[0.._self.m_size], _self.m_bytes, _it);
                }
                else if(_pos == 0) {
                    try _self.__alloc(l_count + _self.m_bytes);
                    chars.prepend(_self.m_buff[0..], _self.m_bytes, _it);
                } else {
                    try _self.__alloc(l_count + _pos);
                    chars.insertReal(_self.m_buff[0.._self.m_size], _self.m_bytes, _it, _pos);
                }

                _self.m_bytes += l_count;
            }

            /// Copies this String into a new one
            /// User is responsible for managing the new String
            pub inline fn clone(_self: Self) !Self {
                return try Self.initWith(_self.src());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── REMOVE ───────────────────────────┐

            // This is a sensitive area for the library and everything else that will be built on it
            // so I prefer to leave the instructions clear without shortcuts
            // as I did for the insert functions above.

            /// Removes a (`range` or `position`) from the string.
            pub inline fn remove(_self: *Self, _it: anytype) void {
                if(_self.m_bytes == 0) return;

                if(chars.utils.isUtype(_it)) {
                    if(chars.utils.indexOf(_self.m_buff[0.._self.m_bytes], _it)) |l_pos| {
                        const l_beg = l_pos - chars.utils.begOf(_self.m_buff[0..], l_pos);
                        const l_count = chars.utils.sizeOf(_self.m_buff[l_beg]);
                        chars.removeReal(_self.m_buff[0.._self.m_bytes], .{l_beg, l_beg+l_count});
                        _self.m_bytes -= l_count;
                    } else unreachable;
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
            pub inline fn shift(_self: *Self, _count: types.unsigned) void {
                if(_self.m_bytes == 0) return;

                const l_count = chars.shift(_self.m_buff[0.._self.m_bytes], _self.m_bytes, _count);
                _self.m_bytes -= if(_count == _self.m_bytes) _self.m_bytes else l_count;
            }

            /// Removes a (`N` bytes) from the `end` of the string.
            pub inline fn pop(_self: *Self, _count: types.unsigned) void {
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
            pub inline fn find(_self: *Self, _it: anytype) ?types.unsigned {
                if(@TypeOf(_it) == Self) return _self.find(_it.src());

                return if(_self.m_bytes > 0) chars.find(_self.src(), _it) else null;
            }

            /// Returns the last occurrence of a (`string` or `char`) in the string.
            pub inline fn rfind(_self: *Self, _it: anytype) ?types.unsigned {
                if(@TypeOf(_it) == Self) return _self.rfind(_it.src());

                return if(_self.m_bytes > 0) chars.rfind(_self.src(), _it) else null;
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

                return chars.eql(_self.src(), _with);
            }

            /// Returns true if the string starts with the given (`string` or `char`).
            pub inline fn startsWith(_self: Self, _with: anytype) bool {
                if(@TypeOf(_with) == Self) return _self.startsWith(_with.src());

                return chars.startsWith(_self.src(), _with);
            }

            /// Returns true if the string ends with the given (`string` or `char`).
            pub inline fn endsWith(_self: Self, _with: anytype) bool {
                if(@TypeOf(_with) == Self) return _self.startsWith(_with.src());

                return chars.endsWith(_self.src(), _with);
            }

            /// Returns true if the string contains a (`string` or `char`).
            pub inline fn includes(_self: Self, _it: anytype) bool {
                if(@TypeOf(_it) == Self) return _self.includes(_it.src());
                return chars.includes(_self.src(), _it);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── REPLACE ──────────────────────────┐

            /// Replaces the first `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
            pub inline fn replace(_self: *Self, _it: anytype, _with: anytype, _count: types.unsigned) Error!types.unsigned {
                if(@TypeOf(_it) == Self) return _self.replace(_it.src(), _with, _count);
                if(@TypeOf(_with) == Self) return _self.replace(_it, _with.src(), _count);

                if(_self.m_bytes > 0) {
                    const l_size = chars.replacementSize(_self.m_buff[0.._self.m_bytes], _it, _count);
                    const l_withLen = chars.size(_with); // if char: 1, if unicode: 4, if string: size of array
                    const l_newLen = _self.m_bytes + (if(_count > 0) l_withLen * _count else l_withLen) - l_size;
                    try __alloc(_self, l_newLen);

                    _ = chars.replace(_self.m_buff[0..], _self.m_bytes, _it, _with, _count);
                    _self.m_bytes = l_newLen;
                    return l_size;
                }
                return 0;
            }

            /// Replaces the last `N` occurrences of (`string` or `char`) with another, Returns the number of replacements.
            pub inline fn rreplace(_self: *Self, _it: anytype, _with: anytype, _count: types.unsigned) Error!types.unsigned {
                if(@TypeOf(_it) == Self) return _self.rreplace(_it.src(), _with, _count);
                if(@TypeOf(_with) == Self) return _self.rreplace(_it, _with.src(), _count);

                if(_self.m_bytes > 0) {
                    const l_size = chars.replacementSize(_self.m_buff[0.._self.m_bytes], _it, _count);
                    const l_withLen = chars.size(_with); // if char: 1, if unicode: 4, if string: size of array
                    const l_newLen = _self.m_bytes + (if(_count > 0) l_withLen * _count else l_withLen) - l_size;
                    try __alloc(_self, l_newLen);

                    _ = chars.rreplace(_self.m_buff[0..], _self.m_bytes, _it, _with, _count);
                    _self.m_bytes = l_newLen;
                    return l_size;
                }
                return 0;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── MORE ────────────────────────────┐

            /// Repeats the (`string` or `char`) `N` times.
            pub inline fn repeat(_self: *Self, _it: anytype, _count: types.unsigned) Error!void {
                if(_count == 0) return;
                if(@TypeOf(_it) == Self) return _self.repeat(_it.src(), _count);

                const l_size =  chars.size(_it) * _count;
                try __alloc(_self, _self.m_bytes + l_size);

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
            pub inline fn split(_self: Self, _sep: anytype, _pos: types.unsigned) ?types.cstr {
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

                return l_arr.toOwnedSlice() catch return Error.OutOfMemory;
            }

            /// Returns a slice of the string as (`string` type) split by the separator (`string` or `char`) at the specified position, or null if failed.
            pub inline fn splitToString(_self: Self, _sep: anytype, index: usize) Error!?Self {
                if(@TypeOf(_sep) == Self) return _self.splitToString(_sep.src(), index);

                if (_self.split(_sep, index)) |block| {
                    var l_str = Self.init();
                    try l_str.append(block);
                    return l_str;
                }

                return null;
            }

            /// Returns an array of slices of the string as (`string` type) split by the separator (`string` or `char`).
            pub inline fn splitAllToStrings(_self: Self, _sep: anytype) Error![]Self {
                if(@TypeOf(_sep) == Self) return _self.splitAllToStrings(_sep.src());

                var l_arr = std.ArrayList(Self).init(std.heap.page_allocator);
                defer l_arr.deinit();

                var i: usize = 0;
                while (try _self.splitToString(_sep, i)) |splitStr| : (i += 1) { try l_arr.append(splitStr); }

                return l_arr.toOwnedSlice() catch return Error.OutOfMemory;
            }

            /// Returns an array of slices of the string split by the separator (`\r\n` or `\n`).
            pub inline fn lines(_self: Self) Error![]Self {
                var l_arr = std.ArrayList(Self).init(std.heap.page_allocator);
                defer l_arr.deinit();

                var l_str = try _self.clone();
                defer l_str.deinit();

                _ = try l_str.replace("\r\n", "\n", 0);

                return try l_str.splitAllToStrings("\n");
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
                fn __write(_self: *Self, _it: types.cstr) Error!types.unsigned {
                    try _self.append(_it);
                    return _it.len;
                }

                /// Inserts a (`formatted string`) into the `end` of the string.
                pub fn write(_self: *Self, comptime _fmt: types.cstr, _args: anytype) Error!void {
                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _self.m_bytes);
                    _self.writer().print(_fmt, _args) catch return Error.FmtError;
                }

                /// Inserts a (`formatted string`) into the `beg` of the string.
                pub fn writeStart(_self: *Self, comptime _fmt: types.cstr, _args: anytype) Error!void {
                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _self.m_bytes);
                    chars.utils.moveRight(_self.m_buff[0.._self.m_size], 0, _self.m_bytes, l_count);
                    var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff[0..]);
                    const l_writer = l_fixedBufferStream.writer();
                    l_writer.print(_fmt, _args) catch return Error.FmtError;
                    _self.m_bytes += l_count;
                }

                /// Inserts a (`formatted string`) into a `specific position` in the string.
                pub fn writeAt(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) Error!void {
                    if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                    if(_pos == 0) return _self.writeStart(_fmt, _args);

                    try _self.__alloc(std.fmt.count(_fmt, _args) + _pos);
                    if(chars.utils.indexOf(_self.src(), _pos)) |l_pos| {
                        return _self.writeAtReal(_fmt, _args, l_pos);
                    } else return Error.InvalidIndex;
                }

                /// Inserts a (`formatted string`) into a `specific position` (The real position) in the string.
                pub fn writeAtReal(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) Error!void {
                    if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                    if(_pos == 0) return _self.writeStart(_fmt, _args);

                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _pos);
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
                    m_index: types.unsigned,

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

            /// Internal methods used by other methods in the string type to check and allocate/reallocate memory if necessary.
            inline fn __alloc(_self: *Self, _bytes: types.unsigned) Error!void {
                // std.debug.print("allocating {d} bytes\n", .{_bytes});
                if (_self.m_size <= _bytes+1) {
                    _self.allocate((_bytes+1) * 2) catch { return Error.OutOfMemory; };
                }
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝