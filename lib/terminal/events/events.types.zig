// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub const Key = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            pub const State = enum { None, SinglePress, DoublePress };
            pub const Arrow = enum { None, Up, Down, Right, Left };
            pub const Error = error { SomeError };

            /// -
            m_val   : u8,

            /// -
            m_mod   : u3,

            /// -
            m_state : State,

            /// -
            m_arrow : Arrow,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// -
            pub fn init(i_val: u8, i_mod: u3, i_state: State, i_arrow: Arrow) Key {
                return .{
                    .m_val   = i_val,
                    .m_mod   = i_mod,
                    .m_state = i_state,
                    .m_arrow = i_arrow
                };
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝