// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("./Bytes.zig");
    pub const Types = Bytes.Types;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Dynamic array of bytes.
    pub const String = struct {
        /// ..?
        m_gpa :? std.heap.GeneralPurposeAllocator(.{}),
        /// Allocator used for memory management.
        m_alloc: std.mem.Allocator = undefined,
        /// Array of characters to store the content.
        m_buff: Types.bytes = &.{},
        /// Size of the string.
        m_size: Types.len = 0,
        /// Length of the string.
        m_bytes: Types.len = 0,


        // ┌──────────────────────────── ---- ────────────────────────────┐

            /// Returns the number of (`bytes` / `characters`) in the string.
            pub fn len(_self: String) Types.len {
                return _self.m_bytes;
            }

            /// Returns the size of the string.
            pub fn size(_self: String) Types.len {
                return _self.m_size;
            }

            /// Returns the source of the string.
            pub fn src(_self: String) Types.cbytes {
                return _self.m_buff[0.._self.m_bytes];
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── HEAP ────────────────────────────┐

            /// Allocate or reallocate the string to a new size.
            /// - Returns `error.AllocationFailed` if the allocation fails.
            pub fn alloc(_self: *String, _size: Types.len) !void {
                if (_self.m_size > 0) {
                    _self.m_buff = _self.m_alloc.realloc(_self.m_buff, _size) catch return error.AllocationFailed;
                } else {
                    _self.m_buff = _self.m_alloc.alloc(Types.byte, _size) catch return error.AllocationFailed;
                }
                _self.m_size = _size;
            }

            /// Deallocate the allocated memory and reset the string.
            pub fn deinit(_self: *String) void {
                if (_self.m_size > 0) {
                    if(_self.m_gpa) |_| {
                        if(_self.m_gpa.?.deinit() == .leak) {
                            std.debug.panic("Memory leak detected.", .{});
                            return;
                        }
                    } else {
                        _self.m_alloc.free(_self.m_buff);
                    }
                }
                _self.m_size = 0;
                _self.m_bytes = 0;
                _self.m_buff = &.{};
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAKE ══════════════════════════════════════╗

    /// Initializes a new empty string.
    pub fn init() String {
        return internalInit("", null, false) catch unreachable;
    }

    /// Initializes a new string and copies the value into it.
    /// - `error.InvalidType` _if the type is invalid._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    /// - `error.AllocationFailed` _if the allocation fails._
    pub fn initWith(_it: anytype) !String {
        return internalInit(_it, null, false);
    }

    /// Initializes a new string with a `specific allocator`.
    pub fn initAlloc(_alloc: std.mem.Allocator) String {
        return internalInit("", _alloc, false) catch unreachable;
    }

    /// Initializes a new string with a `specific allocator` and copies the value into it.
    /// - `error.InvalidType` _if the type is invalid._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    /// - `error.AllocationFailed` _if the allocation fails._
    pub fn initAllocWith(_alloc: std.mem.Allocator, _it: anytype) !String {
        return internalInit(_it, _alloc, false);
    }

    /// Copies the value into a new string.
    /// - `error.AllocationFailed` _if the allocation fails._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    /// - `error.InvalidType` _if the type is invalid._
    pub fn clone(_it: anytype) !String {
        return internalInit(_it, null, true);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ INTERNAL ════════════════════════════════════╗

    /// Returns a Types.cbytes from anytype.
    /// - `error.InvalidType` _if the type is invalid._
    fn internalToBytes(_it: anytype) !Types.cbytes {
        const _Type = @TypeOf(_it);

        if(_Type == u8 or _Type == comptime_int) { return &[_]Types.byte {_it}; }
        else if(_Type == String) { return _it.src(); }
        else if(Bytes.isBytes(_it)) { return _it; }

        return error.InvalidType;
    }

    /// Creates a new string with a specific allocator and size and copies the passed value into it.
    /// - `error.InvalidType` _if the type is invalid._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    /// - `error.AllocationFailed` _if the allocation fails._
    fn internalInit(_it: anytype, _alloc: ?std.mem.Allocator, _same: bool) !String {
        return internalInitString(try internalToBytes(_it), _alloc, _same);
    }

    /// Creates a new string with a specific allocator and copies the bytes into it.
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    /// - `error.AllocationFailed` _if the allocation fails._
    fn internalInitString(_it: Types.cbytes, _alloc: ?std.mem.Allocator, _same: bool) !String {
        var _String =  String { .m_gpa = null };

        // Specific allocator ?
        if(_alloc) |__alloc| {
            _String.m_alloc = __alloc;
        } else {
            var _gpa = std.heap.GeneralPurposeAllocator(.{}){};
            _String.m_gpa = _gpa;
            _String.m_alloc = _gpa.allocator();
        }

        if(_it.len > 0) {
            if(!Bytes.isUTF8(_it)) return error.InvalidUTF8;
            try _String.alloc(if(_same) _it.len else _it.len*2);
            Bytes.copy(_String.m_buff, _it);
            _String.m_bytes = _it.len;
        }

        return _String;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝