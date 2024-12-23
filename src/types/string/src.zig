// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const chars = @import("../../utils/chars/src.zig");
    const types = chars.types;
    const builtin = @import("builtin");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// Dynamic array of characters.
    pub const string = struct {
        const Self = @This();
        /// Nullable array of characters to store the content.
        m_buff: ?types.str,
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
                if(_self.m_buff) |m_buff| return chars.ubytes(m_buff[0.._self.m_bytes]);
                return 0;
            }

            /// Returns the size of the string.
            pub fn size(_self: Self) types.unsigned {
                return _self.m_size;
            }

            /// Returns the source of the string.
            pub fn src(_self: Self) types.cstr {
                if (_self.m_buff) |m_buff| return m_buff[0.._self.m_bytes];
                return "";
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── INIT ────────────────────────────┐

            /// Initialize an empty string.
            pub fn init() Self {
                // set the console output to UTF-8 encoding for Windows.
                if (builtin.os.tag == .windows) { _ = std.os.windows.kernel32.SetConsoleOutputCP(65001); }

                return .{
                    .m_buff  = null,
                    .m_alloc = std.testing.allocator, // Use testing allocator for simplicity.
                    .m_size  = 0,
                    .m_bytes   = 0,
                };
            }

            /// Initialize a string with an allocator and a given substring.
            pub fn initWith(_it: anytype) anyerror!Self {
                var l_str = init();
                try l_str.append(_it);
                return l_str;
            }

            /// Deallocate the string buffer.
            pub fn deinit(_self: *Self) void {
                if (_self.m_buff) |m_buff| _self.m_alloc.free(m_buff);
                _self.m_size = 0;
                _self.m_bytes = 0;
            }

            /// Allocate or reallocate the string buffer to a new size.
            pub fn allocate(_self: *Self, _bytes: types.unsigned) anyerror!void {
                if (_self.m_buff) |m_buff| {
                    if (_bytes < _self.m_size) _self.m_size = _bytes;
                    _self.m_buff = _self.m_alloc.realloc(m_buff, _bytes) catch { return error.OutOfMemory; };
                } else {
                    _self.m_buff = _self.m_alloc.alloc(u8, _bytes) catch { return error.OutOfMemory; };
                }
                _self.m_size = _bytes;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── INSERT ───────────────────────────┐

            /// Appends a substring or character into the end of the string.
            pub fn append(_self: *Self, _it: anytype) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.append(_it.src());
                const l_count = if(chars.utils.isCharType(@TypeOf(_it))) 1 else _it.len;
                try __alloc(_self, l_count);
                chars.append(_self.m_buff.?[0..], _self.m_bytes, _it);
                _self.m_bytes += l_count;
            }

            /// Appends a formatted string into the end of the string.
            pub fn appendf(_self: *Self, comptime _fmt: anytype, _args: anytype) anyerror!void {
                const l_count = std.fmt.count(_fmt, _args);
                try __alloc(_self, l_count);
                _self.writer().print(_fmt, _args) catch {};
            }

            /// Prepends a substring or character into the beginning of the string.
            pub fn prepend(_self: *Self, _it: anytype) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.prepend(_it.src());
                const l_count = if(chars.utils.isCharType(@TypeOf(_it))) 1 else _it.len;
                try __alloc(_self, l_count);
                chars.prepend(_self.m_buff.?[0..], _self.m_bytes, _it);
                _self.m_bytes += l_count;
            }

            /// Prepends a formatted string into the beginning of the string.
            pub fn prependf(_self: *Self, comptime _fmt: anytype, _args: anytype) anyerror!void {
                const l_count = std.fmt.count(_fmt, _args);
                try __alloc(_self, l_count);
                chars.utils.moveRight(_self.m_buff.?[0..], 0, _self.m_bytes, l_count);
                var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff.?[0..]);
                const l_writer = l_fixedBufferStream.writer();
                l_writer.print(_fmt, _args) catch {};
                _self.m_bytes += l_count;
            }

            /// Inserts a substring or character into the string at the specified index.
            pub fn insert(_self: *Self, _it: anytype, _pos: types.unsigned) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.insert(_it.src(), _pos);
                const l_count = if(chars.utils.isCharType(@TypeOf(_it))) 1 else _it.len;
                try __alloc(_self, l_count);
                chars.insert(_self.m_buff.?[0..], _self.m_bytes, _it, _pos);
                _self.m_bytes += l_count;
            }

            /// Inserts a formatted string into the string at the specified index.
            pub fn insertf(_self: *Self, comptime _fmt: anytype, _args: anytype, _pos: types.unsigned) anyerror!void {
                if(_pos == _self.m_bytes) return _self.appendf(_fmt, _args);
                if(_pos == 0) return _self.appendf(_fmt, _args);

                const l_count = std.fmt.count(_fmt, _args);
                try __alloc(_self, l_count);
                if(chars.utils.indexOf(_self.src(), _pos)) |l_pos| {
                    chars.utils.moveRight(_self.m_buff.?[0..], l_pos, _self.m_bytes, l_count);
                }

                var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff.?[_pos..]);
                const l_writer = l_fixedBufferStream.writer();
                l_writer.print(_fmt, _args) catch {};
                _self.m_bytes += l_count;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── SPACE ───────────────────────────┐

            /// Writer.
            pub usingnamespace struct {
                pub const Writer = std.io.Writer(*Self, anyerror, appendWrite);

                /// Writer of string type.
                pub fn writer(self: *Self) Writer {
                    return .{ .context = self };
                }

                fn appendWrite(self: *Self, m: []const u8) !usize {
                    try self.append(m);
                    return m.len;
                }
            };

            /// Iterator.
            pub usingnamespace struct {
                pub const Iterator = struct {
                    _string: *const Self,
                    index: usize,

                    pub fn next(it: *Iterator) ?[]const u8 {
                        if (it._string.m_buff) |m_buff| {
                            if (it.index == it._string.m_size) return null;
                            const i = it.index;
                            it.index += chars.utils.sizeOf(m_buff[i]);
                            return m_buff[i..it.index];
                        } else {
                            return null;
                        }
                    }
                };

                /// Iterator of string type.
                pub fn iterator(self: *const Self) Iterator {
                    return Iterator{
                        ._string = self,
                        .index = 0,
                    };
                }
            };

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── MORE ────────────────────────────┐

            /// ..?
            inline fn __alloc(_self: *Self, _bytes: types.unsigned) anyerror!void {
                if (_self.m_buff) |_| {
                    if (_self.m_size <= (_bytes + _self.m_bytes)) {
                        try _self.allocate((_self.m_size + _bytes) * 2);
                    }
                } else {
                    try _self.allocate(_bytes * 2);
                }
            }

            /// ..?
            inline fn __indexOf(_self: *Self, _pos: types.unsigned) ?types.unsigned {
                return chars.utils.indexOf(_self.m_buff.?[0.._self.m_bytes], _pos).?;
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝