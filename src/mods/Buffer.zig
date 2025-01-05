// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Bytes = @import("./Bytes.zig");
    pub const Types = Bytes.Types;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Fixed array of bytes.
    pub fn Buffer(comptime _type: type, comptime _size: Types.len) type {
        return struct {
            const Self = @This();
            /// Array of characters to store the content.
            m_buff:  [_size]_type = undefined,
            /// Size of the buffer.
            m_size: Types.len,
            /// Length of the buffer.
            m_bytes: Types.len = 0,


            // ┌──────────────────────────── ---- ────────────────────────────┐

                /// Returns the number of (`bytes` / `characters`) in the buffer.
                pub fn len(_self: Self) Types.len {
                    return _self.m_bytes;
                }

                /// Returns the size of the buffer.
                pub fn size(_self: Self) Types.len {
                    return _self.m_size;
                }

            // └──────────────────────────────────────────────────────────────┘
        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAKE ══════════════════════════════════════╗

    /// Creates a buffer of the specified size.
    /// - Returns `error.ZeroValue` _if the `size` is 0._
    pub fn init(comptime _size: Types.len) !Buffer(Types.byte, _size) {
        return .{
            .m_buff  = try Bytes.init(_size),
            .m_size  = _size,
            .m_bytes = 0
        };
    }

    /// Creates a buffer of the specified size and copies the value into it.
    /// - `error.InvalidType` _if the type is invalid._
    /// - `error.OutOfRange` _if the length of `_it` is greater than the `_size`._
    /// - `error.ZeroValue` _if the `_it` length is 0._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    pub fn initWith(comptime _size: Types.len, _it: anytype) !Buffer(Types.byte, _size) {
        const _It = try internalToBytes(_it);

        return .{
            .m_buff  = try Bytes.initWith(_size, _It),
            .m_size  = _size,
            .m_bytes = _It.len
        };
    }

    /// Creates a buffer and copies the bytes into it.
    pub fn clone(comptime _it: Types.cbytes) Buffer(Types.byte, _it.len) {
        return .{
            .m_buff  = Bytes.clone(_it),
            .m_size  = _it.len,
            .m_bytes = _it.len
        };
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝


// ╔════════════════════════════════════ INTERNAL ════════════════════════════════════╗

    /// Returns a Types.cbytes from anytype.
    /// - `error.InvalidType` _if the type is invalid._
    fn internalToBytes(_it: anytype) !Types.cbytes {
        const _Type = @TypeOf(_it);
        const _TypeInfo = @typeInfo(_Type);

        if(_Type == u8 or (_Type == comptime_int and (_it >= 0 and _it <= 255))) { return &[_]Types.byte {_it}; }
        else if(_TypeInfo == .Struct and @hasField(_Type, "m_buff")) { return _it.m_buff[0.._it.m_bytes]; }
        else if(Bytes.isBytes(_it)) { return _it; }

        return error.InvalidType;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝