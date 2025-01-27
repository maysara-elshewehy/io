// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");

    const Codepoint = @import("./Codepoint.zig").Codepoint;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;

    const ZWJ_array    : [3]u8     = .{0xE2, 0x80, 0x8D};
    const MOD_array    : [2]u8     = .{0xCC, 0x81};
    const invalid_utf8 : [2]u8     = .{0xc0, 0x80};

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "Codepoint" {
        const None = try Codepoint.init("A");          // Regular character.
        try expectEqual(.None, None.mode);
        try expectEqual(1, None.len);

        const ZWJ = try Codepoint.init(&ZWJ_array);    // Zero Width Joiner.
        try expectEqual(.ZWJ, ZWJ.mode);
        try expectEqual(3, ZWJ.len);

        const MOD = try Codepoint.init(&MOD_array);    // Combining Acute Accent.
        try expectEqual(.Mod, MOD.mode);
        try expectEqual(2, MOD.len);

        try expectError(error.InvalidValue, Codepoint.init(&invalid_utf8));

        // more complex
        {
            const txt = "Aأ你🌟☹️👨‍🏭@";
            {
                const cp = try Codepoint.init(txt[0..1]);
                try expectEqual(1, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[1..3]);
                try expectEqual(2, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[3..6]);
                try expectEqual(3, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[6..10]);
                try expectEqual(4, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[10..13]);
                try expectEqual(3, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[13..16]);
                try expectEqual(3, cp.len);
                try expectEqual(.Mod, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[16..20]);
                try expectEqual(4, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[20..23]);
                try expectEqual(3, cp.len);
                try expectEqual(.ZWJ, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[23..27]);
                try expectEqual(4, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                const cp = try Codepoint.init(txt[27..28]);
                try expectEqual(1, cp.len);
                try expectEqual(.None, cp.mode);
            }
            {
                try expectError(error.InvalidValue, Codepoint.init(txt[6..8])); // 👉 error.InvalidValue (half of 🌟)
            }
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝