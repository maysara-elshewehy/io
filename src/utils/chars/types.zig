// ╔═════════════════════════════════════ TYPES ══════════════════════════════════════╗

    /// Data type structure for the chars utility.
    pub const types = struct {
        /// Unified signed integr type.
        pub const signed = isize;
        /// Unified unsigned integr type.
        pub const unsigned = usize;
        /// Character type.
        pub const char = u8;
        /// Array of characters type.
        pub const str =  []types.char;
        /// Constant array of characters type.
        pub const cstr = []const types.char;
        /// Range type.
        pub const range = [2]types.unsigned;
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝