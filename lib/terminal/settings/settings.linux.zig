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

    const std = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const GetSettingsError = error { FailedToGetSettings };
    pub const SetSettingsError = error { FailedToSetSettings };

    // Terminal settings structure.
    pub const TerminalSettings = struct {
        core: std.posix.termios,

        // Input/Output handles
        handles : struct {
            inputHandle :? i32,
            outputHandle :? i32,
        },

        // Options
        options: TerminalOptions
    };

    // Terminal settings options structure.
    pub const TerminalOptions = struct {

        /// true if the raw mode is enabled.
        rawMode: bool,

        /// true if the echo is enabled.
        echo: bool,

        /// true if canonical input is enabled.
        canonical: bool,

        /// true if extended input processing is enabled.
        extended: bool,

        /// true if signals (SIGINT, SIGTSTP, SIGTTIN, SIGTTOU) are enabled.
        signals: bool,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // Get current terminal settings.
    pub fn get() GetSettingsError!TerminalSettings {
        const inputHandle = std.io.getStdIn().handle;
        const outputHandle = std.io.getStdOut().handle;

        // get the current terminal settings
        const current_settings = std.posix.tcgetattr(inputHandle) catch return GetSettingsError.FailedToGetSettings;

        // returns the current settings wrapped by `TerminalSettings` structure
        return TerminalSettings{
            .core = current_settings,

            // Input/Output handles
            .handles = .{
                .inputHandle = inputHandle,
                .outputHandle = outputHandle,
            },

            // Options
            .options = .{
                .rawMode    = !current_settings.lflag.ICANON and !current_settings.lflag.IEXTEN and !current_settings.lflag.ISIG and !current_settings.lflag.ECHO,
                .echo       = current_settings.lflag.ECHO,
                .canonical  = current_settings.lflag.ICANON,
                .extended   = current_settings.lflag.IEXTEN,
                .signals    = current_settings.lflag.ISIG
            }
        };
    }

    // Set current terminal settings.
    pub fn set(settings: TerminalSettings) SetSettingsError!void {
        // make a new settings from the current settings
        var new_settings = get() catch return SetSettingsError.FailedToSetSettings;

        // apply the new settings
        {
            // echo
            if (settings.options.echo != new_settings.options.echo) {
                if (settings.options.echo) {
                    new_settings.core.lflag.ECHO = true;
                } else {
                    new_settings.core.lflag.ECHO = false;
                }
            }

            // canonical
            if (settings.options.canonical != new_settings.options.canonical) {
                if (settings.options.canonical) {
                    new_settings.core.lflag.ICANON = true;
                } else {
                    new_settings.core.lflag.ICANON = false;
                }
            }

            // extended
            if (settings.options.extended != new_settings.options.extended) {
                if (settings.options.extended) {
                    new_settings.core.lflag.IEXTEN = true;
                } else {
                    new_settings.core.lflag.IEXTEN = false;
                }
            }

            // signals
            if (settings.options.signals != new_settings.options.signals) {
                if (settings.options.signals) {
                    new_settings.core.lflag.ISIG = true;
                } else {
                    new_settings.core.lflag.ISIG = false;
                }
            }

            // raw mode
            if (settings.options.rawMode != new_settings.options.rawMode) {
                if (settings.options.rawMode) {
                    new_settings.core.lflag.ECHO    = false;
                    new_settings.core.lflag.ICANON  = false;
                    new_settings.core.lflag.IEXTEN  = false;
                    new_settings.core.lflag.ISIG    = false;

                    new_settings.core.cc[@intFromEnum(std.posix.V.MIN)] = 1;
                    new_settings.core.cc[@intFromEnum(std.posix.V.TIME)] = 0;
                } else {
                    new_settings.core.lflag.ECHO    = true;
                    new_settings.core.lflag.ICANON  = true;
                    new_settings.core.lflag.IEXTEN  = true;
                    new_settings.core.lflag.ISIG    = true;

                    new_settings.core.cc[@intFromEnum(std.posix.V.MIN)] = 1;
                    new_settings.core.cc[@intFromEnum(std.posix.V.TIME)] = 0;
                }
            }
        }

        // apply the new settings
        const handle = if(new_settings.handles.inputHandle) |_inputHandle| _inputHandle else 0;
        std.posix.tcsetattr(handle, .FLUSH, new_settings.core) catch return SetSettingsError.FailedToSetSettings;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝