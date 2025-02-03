// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const Iterator = @import("./mods/Iterator/Iterator.zig").Iterator;
    pub const Codepoint = @import("./mods/Codepoint/Codepoint.zig").Codepoint;

    pub const utils = @import("./utils/utils.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./mods/Codepoint/Codepoint.test.zig");
        _ = @import("./mods/Iterator/Iterator.test.zig");
        _ = @import("./utils/utils.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝