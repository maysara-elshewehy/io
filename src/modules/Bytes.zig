// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");

    /// A unified set of data types to facilitate subsequent library creation and maintenance.
    pub const Types = struct
    {
        pub const len = usize;              // Length type.
        pub const range = [2]len;           // Range type.

        pub const byte = u8;                // Byte type.
        pub const bytes =  []byte;          // Array of bytes type.
        pub const cbytes = []const byte;    // Constant array of bytes type.
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        /// Returns `true` if the type of `input` is a `byte`.
        pub fn isByte(_input: anytype) bool {
            const _Type = @TypeOf(_input);
            return _Type == Types.byte or (_Type == comptime_int and (_input >= 0 and _input <= 255));
        }

        /// Returns `true` if the type of `input` is a `bytes`.
        pub fn isBytes(_input: anytype) bool {
            const _Type = @TypeOf(_input);
            if(_Type == Types.bytes or _Type == Types.cbytes) return true;

            const _TypeInfo = @typeInfo(_Type);
            if(_TypeInfo == .Pointer) {
                const _ChildTypeInfo = @typeInfo(_TypeInfo.Pointer.child);
                if(_ChildTypeInfo == .Array) {
                    return _ChildTypeInfo.Array.child == Types.byte;
                }
            }
            return false;
        }

        /// Safely casts the `input` value to a `byte`
        /// - Returns `error.OutOfRange` if the value is out of range or `error.InvalidType` if the type is invalid.
        pub fn toByte(_input: anytype) !Types.byte {
            const _Type = @TypeOf(_input);
            return
                if(_Type != Types.byte and _Type != comptime_int) error.InvalidType
                else if(_input >= 0 and _input <= 255) @as(Types.byte, _input)
                else error.OutOfRange;
        }

        /// Returns `true` if the `bytes` is valid UTF-8, `false` otherwise.
        pub fn isUTF8(_input: Types.cbytes) bool {
            return std.unicode.utf8ValidateSlice(_input);
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        /// Creates an array of `size` bytes.
        /// - Returns `error.ZeroValue` _if the `size` is 0._
        pub fn make(comptime _size: Types.len) ![_size]Types.byte {
            if(_size == 0) return error.ZeroValue;
            return makeUnchecked(_size);
        }

        /// Creates an array of `size` bytes.
        pub fn makeUnchecked(comptime _size: Types.len) [_size]Types.byte {
            return .{0} ** _size;
        }

        /// Creates a valid utf-8 array of `size` bytes and copies the `_it` value into it.
        /// - `error.OutOfRange` _if the length of `_it` is greater than the `_size`._
        /// - `error.ZeroisUTF8the `_it` length is 0._
        /// - `error.InvalidUTF8` _if the `_it` is not valid UTF-8._
        pub fn makeWith(comptime _size: Types.len, _it: anytype) ![_size]Types.byte {
            const _It = try internalToBytes(_it);

            if(_It.len > _size) return error.OutOfRange;
            if(_It.len == 0) return error.ZeroValue;
            if(!isUTF8(_It)) return error.InvalidUTF8;
            return makeWithUnchecked(_size, _It);
        }

        /// Creates a valid utf-8 array of `size` bytes and copies the `_it` value into it.
        pub fn makeWithUnchecked(comptime _size: Types.len, _it: anytype) [_size]Types.byte {
            const _It = internalToBytes(_it) catch unreachable;

            var _Dist: [_size]Types.byte = undefined;
            @memcpy(_Dist[0.._It.len], _It);
            _Dist[_It.len] = 0;
            return _Dist;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        /// Copies the `_it` bytes into another array.
        pub fn copy(_to: Types.bytes, _from: Types.cbytes) void {
            @memcpy(_to[0.._from.len], _from);
        }

        /// Copies the `_it` bytes into a new array.
        pub fn clone(comptime _it: Types.cbytes) [_it.len]Types.byte {
            var _Dist: [_it.len]Types.byte = undefined;
            copy(_Dist[0.._it.len], _it);
            return _Dist;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌──────────────────────────── ---- ────────────────────────────┐

        /// Returns the number of bytes in the `input` array, stops at the first 0 byte, or at the size.
        pub fn count(_it: Types.cbytes) Types.len {
            var i: Types.len = 0;
            while (i < _it.len and _it[i] != 0) : (i += 1) {}
            return i;
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ INTERNAL ════════════════════════════════════╗

    /// Returns a Types.cbytes from anytype.
    /// - `error.InvalidType` _if the type is invalid._
    fn internalToBytes(_it: anytype) !Types.cbytes {
        const _Type = @TypeOf(_it);

        if(_Type == u8 or _Type == comptime_int) { return &[_]Types.byte {_it}; }
        else if(isBytes(_it)) { return _it; }

        return error.InvalidType;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝