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
        core : struct {
            inputMode : std.os.windows.DWORD,
            outputMode : std.os.windows.DWORD,
        },

        // Input/Output handles
        handles : struct {
            inputHandle :? *anyopaque,
            outputHandle :? *anyopaque,
        },

        // Options
        options: TerminalOptions
    };

    // Terminal settings options structure.
    pub const TerminalOptions = struct {

        /// true if the raw mode is enabled.
        rawMode: bool,
    };

    pub extern "kernel32" fn SetConsoleCP(
        wCodePageID: std.os.windows.UINT,
    ) callconv(.winapi) std.os.windows.BOOL;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // Get current terminal settings.
    pub fn get() GetSettingsError!TerminalSettings {
        const inputHandle = try getInputHandle();
        const outputHandle = try getOutputHandle();

        // get the current terminal settings
        var inputMode : std.os.windows.DWORD = undefined;
        if (std.os.windows.kernel32.GetConsoleMode(inputHandle.?, &inputMode) == 0)
            return GetSettingsError.FailedToGetSettings;

        var outputMode : std.os.windows.DWORD = undefined;
        if (std.os.windows.kernel32.GetConsoleMode(outputHandle.?, &outputMode) == 0)
            return GetSettingsError.FailedToGetSettings;

        // returns the current settings wrapped by `TerminalSettings` structure
        return TerminalSettings{
            .core = .{
                .inputMode = inputMode,
                .outputMode = outputMode,
            },

            // Input/Output handles
            .handles = .{
                .inputHandle = inputHandle,
                .outputHandle = outputHandle,
            },

            // Options
            .options = .{
                .rawMode    = (inputMode & ENABLE_VIRTUAL_TERMINAL_INPUT) == ENABLE_VIRTUAL_TERMINAL_INPUT,
            }
        };
    }

    // Set current terminal settings.
    pub fn set(settings: TerminalSettings) SetSettingsError!void {
        // make a new settings from the current settings
        var new_settings = get() catch return SetSettingsError.FailedToSetSettings;

        // apply the new settings
        {
            // raw mode
            if (settings.options.rawMode != new_settings.options.rawMode) {
                if (settings.options.rawMode) {
                    new_settings.core.inputMode &= ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT);
                    new_settings.core.inputMode |= ENABLE_VIRTUAL_TERMINAL_INPUT | ENABLE_KEYBOARD_INPUT;
                } else {
                    new_settings.core.inputMode |= ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT;
                    new_settings.core.inputMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT | ENABLE_KEYBOARD_INPUT;
                }
            }
        }

        // Set the console code page to UTF-8 for both input and output
        if (std.os.windows.kernel32.SetConsoleOutputCP(65001) == 0)
            return SetSettingsError.FailedToSetSettings;

        if (SetConsoleCP(65001) == 0)
            return SetSettingsError.FailedToSetSettings;

        // apply the new settings
        const handle = if(new_settings.handles.inputHandle) |_inputHandle| _inputHandle else unreachable;
        if (std.os.windows.kernel32.SetConsoleMode(handle, new_settings.core.inputMode) == 0)
            return SetSettingsError.FailedToSetSettings;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ Internal ════════════════════════════════════╗

    // Define missing Windows console mode flags and constants
    const ENABLE_ECHO_INPUT             : std.os.windows.DWORD = 0x0004;
    const ENABLE_PROCESSED_INPUT        : std.os.windows.DWORD = 0x0001;
    const ENABLE_LINE_INPUT             : std.os.windows.DWORD = 0x0002;
    const ENABLE_KEYBOARD_INPUT         : std.os.windows.DWORD = 0x0008;
    const ENABLE_MOUSE_INPUT            : std.os.windows.DWORD = 0x0010;
    const ENABLE_VIRTUAL_TERMINAL_INPUT : std.os.windows.DWORD = 0x0200;

    /// Get windows API input handle.
    inline fn getInputHandle() GetSettingsError!?*anyopaque {
        const handle = std.os.windows.kernel32.GetStdHandle(std.os.windows.STD_INPUT_HANDLE);
        if (handle == std.os.windows.INVALID_HANDLE_VALUE)
            return GetSettingsError.FailedToGetSettings;

        return handle;
    }

    /// Get windows API output handle.
    inline fn getOutputHandle() GetSettingsError!?*anyopaque {
        const handle = std.os.windows.kernel32.GetStdHandle(std.os.windows.STD_OUTPUT_HANDLE);
        if (handle == std.os.windows.INVALID_HANDLE_VALUE)
            return GetSettingsError.FailedToGetSettings;

        return handle;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝