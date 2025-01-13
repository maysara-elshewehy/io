// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A unified set of data types to facilitate subsequent library creation and maintenance.
    pub const Types = struct
    {
        pub const len = usize;              // Length type.
        pub const range = [2]len;           // Range type.

        pub const byte = u8;                // Byte type.
        pub const bytes =  []byte;          // Array of bytes type.
        pub const cbytes = []const byte;    // Constant array of bytes type.

        pub const codepoint = u21;          // code point type.
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝