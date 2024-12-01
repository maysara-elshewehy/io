// ╔══════════════════════════════════════ FILE ══════════════════════════════════════╗

    const builtin = @import("builtin");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TYPE ══════════════════════════════════════╗

    /// Struct to represent key press details.
    pub const key = struct {
        /// Press state.
        pub const State = enum { None, SinglePress, DoublePress, };
        pub const Arrow = enum { None, Up, Down, Right, Left };

        m_val   : u8    = 0,            // key code
        m_mod   : u3    = 0,            // modifier keys (ctrl, alt, shift)
        m_state : State = State.None,   // press state 
        m_arrow : Arrow = Arrow.None,   // arrow keys
        
        /// Returns the press state.
        pub inline fn state(_self: *const key) State {
            if(_self.m_state == State.None) {
                const isSinglePress = _self.m_mod == 0;

                if (isSinglePress)  { _self.m_state = State.SinglePress; }
                else                { _self.m_state = State.DoublePress; }
            }

            return _self.m_state;
        }

        /// Returns the key code.
        pub inline fn code(_self: *const key) u8 {
            return _self.m_val;
        }

        /// Returns a character representation of the key.
        pub inline fn char(_self: *const key) u8 {
            return switch (_self.m_mod) {
                4    => { return '@' + _self.m_val; }, // ctrl 
                5    => { return '@' + _self.m_val; }, // alt + ctrl 
                else => { return       _self.m_val; }, // others
            };
        }

        /// Returns a string representation of the modifiers.
        pub inline fn mod(_self: *const key) [] const u8 {
            return switch (_self.m_mod) {
                0    => "none",
                1    => "alt",
                2    => "shift",
                3    => "alt + shift",
                4    => "ctrl",
                5    => "alt + ctrl",
                else => "unknown",
            };
        }

        /// Returns true if the Alt modifier key was pressed.
        pub inline fn alt (_self: *const key) bool {
            return (_self.m_mod & 1 << 0) != 0;
        }

        /// Returns true if the Ctrl modifier key was pressed.
        pub inline fn ctrl (_self: *const key) bool {
            return (_self.m_mod & 1 << 2) != 0;
        }

        /// Returns true if the Shift modifier key was pressed.
        pub inline fn  shift(_self: *const key) bool {
            return (_self.m_mod & 1 << 1) != 0;
        }

        /// Returns true if the Enter key was pressed.
        pub inline fn  enter(_self: *const key) bool {
            return (builtin.os.tag == .windows and _self.m_val == 13) or
                    (builtin.os.tag != .windows and _self.m_val == 10);
        }

        /// Returns true if the backspace key was pressed.
        pub inline fn  backspace(_self: *const key) bool {
            return (builtin.os.tag == .windows and _self.m_val == 8) or
                    (builtin.os.tag != .windows and _self.m_val == 127);
        }

        /// Returns true if up arrow key was pressed.
        pub inline fn upArrow(_self: *const key) bool {
            return _self.m_arrow == Arrow.Up;
        }

        // Returns true if down arrow key was pressed.
        pub inline fn downArrow(_self: *const key) bool {
            return _self.m_arrow == Arrow.Down;
        }

        /// Returns true if right arrow key was pressed.
        pub inline fn rightArrow(_self: *const key) bool {
            return _self.m_arrow == Arrow.Right;
        }

        /// Returns true if left arrow key was pressed.
        pub inline fn leftArrow(_self: *const key) bool {
            return _self.m_arrow == Arrow.Left;
        }

        /// Returns true if up arrow key was pressed.
        pub inline fn arrow(_self: *const key) Arrow {
            return _self.m_arrow;
        }

        /// Returns count of pressed keys.
        pub inline fn count (_self: *const key) u8 {
            var m_count : u8 = 1;

            if (_self.alt())     m_count += 1;
            if (_self.ctrl())    m_count += 1;
            if (_self.shift())   m_count += 1;

            return m_count;
        }
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝
