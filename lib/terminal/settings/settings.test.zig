// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std               = @import("std");
    const testing           = std.testing;
    const builtin           = @import("builtin");
    const settings          = @import("./settings.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    test "settings.TerminalSettings" {
        const TerminalSettings = settings.TerminalSettings;
        try testing.expect(@hasField(TerminalSettings, "core"));
        try testing.expect(@hasField(TerminalSettings, "handles"));
        try testing.expect(@hasField(TerminalSettings, "options"));
    }

    test "settings.TerminalOptions" {
        const TerminalOptions = settings.TerminalOptions;
        try testing.expect(@hasField(TerminalOptions, "rawMode"));
        if (builtin.os.tag == .linux) {
            try testing.expect(@hasField(TerminalOptions, "echo"));
            try testing.expect(@hasField(TerminalOptions, "canonical"));
            try testing.expect(@hasField(TerminalOptions, "extended"));
            try testing.expect(@hasField(TerminalOptions, "signals"));
        }

        const FN = struct {
            pub fn enableAndDisableOption(comptime field: []const u8) !void {
                // get current terminal settings
                const original_settings = try settings.get();

                // make a new terminal settings with different data
                var new_settings = original_settings;
                @field(new_settings.options, field) = true;

                // set the new terminal settings
                try settings.set(new_settings);

                // now get the current settings and compare with the new_settings options
                const current_settings = try settings.get();
                try testing.expect(@field(current_settings.options, field));

                // restore the original settings
                try settings.set(original_settings);
            }
        };

        try FN.enableAndDisableOption("rawMode");
        if (builtin.os.tag == .linux) {
            try FN.enableAndDisableOption("echo");
            try FN.enableAndDisableOption("canonical");
            try FN.enableAndDisableOption("extended");
            try FN.enableAndDisableOption("signals");
        }
    }

    test "settings.enableRawMode/disableRawMode" {
        // enable raw mode
        const original_settings = try settings.enableRawMode();
        var updated_settings = try settings.get();
        try testing.expect(updated_settings.options.rawMode);
        if (builtin.os.tag == .linux) {
            try testing.expect(!updated_settings.options.echo);
            try testing.expect(!updated_settings.options.canonical);
            try testing.expect(!updated_settings.options.extended);
            try testing.expect(!updated_settings.options.signals);
        }
        try testing.expect(try settings.isRawModeEnabled());

        // disable raw mode
        try settings.disableRawMode(original_settings);
        updated_settings = try settings.get();
        try testing.expect(!updated_settings.options.rawMode);
        if (builtin.os.tag == .linux) {
            try testing.expect(updated_settings.options.echo);
            try testing.expect(updated_settings.options.canonical);
            try testing.expect(updated_settings.options.extended);
            try testing.expect(updated_settings.options.signals);
        }
        try testing.expect(!try settings.isRawModeEnabled());
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
