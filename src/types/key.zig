// ╔═════════════════════════════════════ MACRO ══════════════════════════════════════╗

    pub const   MOD_ALT       = 1 << 0;
    pub const   MOD_SHIFT     = 1 << 1;
    pub const   MOD_CTRL      = 1 << 2;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ key ═══════════════════════════════════════╗

    /// Struct to represent key press details.
    pub const key = struct
    {

        // ┌─────────────────────────── DATA ───────────────────────────┐

            pub const State = enum
            {
                None,
                SinglePress,
                DoublePress,
            };

            m_val   : u8    = 0,            // key code
            m_mod   : u3    = 0,            // modifier keys (ctrl, alt, shift)
            m_state : State = State.None,   // press state 

        // └────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── FUNC ───────────────────────────┐

            /// Returns the press state.
            pub inline fn state
            (_self: *const key) 
            State
            {
                if(_self.m_state == State.None)
                {
                    const isSinglePress = _self.m_mod == 0;

                    if(isSinglePress)
                    {
                        _self.m_state = State.SinglePress;
                    }
                    else
                    {
                        _self.m_state = State.DoublePress;
                    }
                }

                return _self.m_state;
            }

            /// Returns the key code.
            pub inline fn get
            (_self: *const key) 
            u8 
            {
                return _self.m_val;
            }

            /// Returns a character representation of the key.
            pub inline fn char
            (_self: *const key) 
            u8 
            {
                return switch (_self.m_mod)
                {
                    4      =>
                    {
                        // ctrl 
                        return '@' + _self.m_val;
                    },

                    5      =>
                    {
                        // alt + ctrl 
                        return '@' + _self.m_val;
                    },

                    else    =>
                    {
                        // others
                        return _self.m_val;
                    },
                };
            }

            /// Returns a string representation of the modifiers.
            pub inline fn mod
            (_self: *const key) 
            [] const u8 
            {
                return switch (_self.m_mod)
                {
                    0       => "none"           ,
                    1       => "alt"            ,
                    2       => "shift"          ,
                    3       => "alt + shift"    ,
                    4       => "ctrl"           ,
                    5       => "alt + ctrl"     ,
                    else    => "unknown"        ,
                };
            }

            /// Returns true if the Alt modifier key was pressed.
            pub inline fn alt
            (_self: *const key)
            bool
            {
                return (_self.m_mod & MOD_ALT) != 0;
            }

            /// Returns true if the Ctrl modifier key was pressed.
            pub inline fn ctrl
            (_self: *const key)
            bool
            {
                return (_self.m_mod & MOD_CTRL) != 0;
            }

            // Returns true if the Shift modifier key was pressed.
            pub inline fn 
            shift(_self: *const key)
            bool
            {
                return (_self.m_mod & MOD_SHIFT) != 0;
            }

            /// Returns count of pressed keys.
            pub inline fn count
            (_self: *const key)
            u8
            {
                var m_count : u8 = 1;

                if (_self.alt())     m_count += 1;
                if (_self.ctrl())    m_count += 1;
                if (_self.shift())   m_count += 1;

                return m_count;
            }

        // └────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝
