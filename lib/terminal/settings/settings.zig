// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const cross = switch (@import("builtin").os.tag) {
        .linux    => @import("./settings.linux.zig"),
        .windows  => @import("./settings.win.zig"),
        else      => @compileError("OS not supported"),
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const GetSettingsError = cross.GetSettingsError;
    pub const SetSettingsError = cross.SetSettingsError;
    pub const GetOrSetSettingsError = GetSettingsError || SetSettingsError;

    /// Terminal settings structure.
    pub const TerminalSettings = cross.TerminalSettings;

    /// Terminal settings options structure.
    pub const TerminalOptions = cross.TerminalOptions;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Get current terminal settings.
    pub const get = cross.get;

    /// Set current terminal settings.
    pub const set = cross.set;

    /// Enable raw mode.
    pub fn enableRawMode() GetOrSetSettingsError!TerminalSettings {
        // get current settings
        const current_settings = try get();

        // make a new settings with raw mode enabled
        var new_settings = current_settings;
        new_settings.options.rawMode = true;

        // apply the new settings
        try set(new_settings);

        // return the current settings
        return current_settings;
    }

    /// Disable raw mode.
    pub fn disableRawMode(original_settings:? TerminalSettings) GetOrSetSettingsError!void {
        // make a new settings with raw mode disabled
        var new_settings = if(original_settings) |_original_settings| _original_settings else try get();
        new_settings.options.rawMode = false;

        // apply the new settings
        try set(new_settings);
    }

    /// Returns true if raw mode is enabled.
    pub fn isRawModeEnabled() GetSettingsError!bool {
        return (try get()).options.rawMode;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝