// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Internal = @import("./_Internal.zig");
    const Bytes = @import("./Bytes.zig");
    pub const Types = Internal.Types;

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


            // ┌─────────────────────────── BASICS ───────────────────────────┐

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
    pub fn make(comptime _size: Types.len) !Buffer(Types.byte, _size) {
        return .{
            .m_buff  = try Bytes.make(_size),
            .m_size  = _size,
            .m_bytes = 0
        };
    }

    /// Creates a buffer of the specified size and copies the bytes into it.
    /// - `error.OutOfRange` _if the length of `_it` is greater than the `_size`._
    /// - `error.ZeroValue` _if the `_it` length is 0._
    /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
    pub fn makeWith(comptime _size: Types.len, _it: Types.cbytes) !Buffer(Types.byte, _size) {
        return .{
            .m_buff  = try Bytes.makeWith(_size, _it),
            .m_size  = _size,
            .m_bytes = _it.len
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