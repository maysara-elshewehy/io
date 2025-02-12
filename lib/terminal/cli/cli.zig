// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std       = @import("std");
    const builtin   = @import("builtin");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Starts the CLI application.
    pub fn start ( commands: anytype, options: anytype, debug_mode: bool ) !void {
        if (comptime false)
            @compileError("This function must run at runtime!");

        // Create a general-purpose allocator for managing memory during execution
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};

        // - Ensures that `gpa` is properly cleaned up (memory released) when the function ends.
        defer _ = gpa.deinit();

        // - `allocator` is a reference to the allocator created by `gpa`, used for memory operations.
        const allocator = gpa.allocator();

        // Retrieve the command-line arguments in a cross-platform manner
        const args = try std.process.argsAlloc(allocator);

        // - Frees the memory allocated for the `args` array once it's no longer needed.
        defer std.process.argsFree(allocator, args);

        // If no command is provided, return an error
        if (args.len < 2) {
            try std.debug.print("No command provided by user!\n", .{});
            return Error.NoArgsProvided;
        }

        // Extract the name of the command (the second argument after the program name)
        const command_name = args[1];

        var detected_command: ?command = null;

        // Search through the list of available commands to find a match
        for (commands) |cmd| {
            if (std.mem.eql(u8, command_name, cmd.name)) {
                detected_command = cmd;
                break;
            }
        }

        // If no matching command is found, return an error
        if (detected_command == null) {
            try std.debug.print("Unknown command: {s}\n", .{command_name});
            return Error.UnknownCommand;
        }

        // Retrieve the matched command from the optional variable
        const cmd = detected_command.?;

        if(debug_mode)
            try std.debug.print("Detected command: {s}\n", .{cmd.name});

        // Allocate memory for detected options based on remaining arguments
        var detected_options: []option = try allocator.alloc(option, args.len - 2);

        // - Ensures that memory allocated for `detected_options` is freed after usage.
        defer allocator.free(detected_options);

        // - Counter to keep track of the number of detected options.
        var detected_len : usize = 0;

        // - Starts parsing options from the third argument (index 2).
        var i: usize = 2;

        // Parsing options to capture their values
        while (i < args.len) {
            const arg = args[i];

            if (arg[0] == '-') {
                const option_name = if (arg.len > 2 and arg[1] == '-') arg[2..] else arg[1..];

                var matched_option: ?option = null;

                for (options) |opt| {
                    if (std.mem.eql(u8, option_name, opt.long) or (option_name.len == 1 and option_name[0] == opt.short)) {
                        matched_option = opt;
                        break;
                    }
                }

                if (matched_option == null) {
                    try std.debug.print("Unknown option: {s}\n", .{arg});
                    return Error.UnknownOption;
                }

                var opt = matched_option.?;

                // Detect the value for the option
                if (i + 1 < args.len and args[i + 1][0] != '-') {
                    opt.value = args[i + 1];
                    i += 1;             // Skip the value in the next iteration
                } else {
                    opt.value = "";     // No value provided
                }

                detected_options[detected_len] = opt;
                detected_len += 1;
            }
            else {
                try std.debug.print("Unexpected argument: {s}\n", .{arg});
                return Error.UnexpectedArgument;
            }

            i += 1;
        }

        // Slice the detected options to the actual number of detected options
        const used_options = detected_options[0..detected_len];

        // Ensure all required options for the detected command are provided
        for (cmd.req) |req_option| {
            // - Flag to check if the required option is found.
            var found = false;

            for (used_options) |opt| {
                if (std.mem.eql(u8, req_option, opt.name)){
                    found = true; break;
                }
            }

            if (!found) {
                try std.debug.print("Missing required option: {s}\n", .{req_option});
                return Error.MissingRequiredOption;
            }
        }

        // Execute the command's associated function with the detected options
        if (!cmd.func(used_options)) { return Error.CommandExecutionFailed; }
        else {
            // Execute option functions
            for (used_options) |opt| {
                // Function Defined ?
                if(opt.func == null) continue;

                // Call the function associated with the option
                const result = opt.func.?(opt.value);

                if (!result) {
                    try std.debug.print("Option function execution failed: {s}\n", .{opt.name});
                    return Error.CommandExecutionFailed;
                }
            }
        }

        // If execution reaches this point, the command was executed successfully
        if(debug_mode) {
            try std.debug.print("Command executed successfully: {s}\n", .{cmd.name});
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const byte    = u8;
    const slice   = []const u8;
    const slices  = []const slice;

    /// Structure to represent the type of command.
    pub const command = struct {
        name : slice,                   // Name of the command
        func : fnType,                  // Function to execute the command
        req  : slices = &.{},           // Required options
        opt  : slices = &.{},           // Optional options
        const fnType = *const fn ([]const option) bool;
    };

    /// Structure to represent the type of option.
    pub const option = struct {
        name  : slice,                  // Name of the option
        func  : ?fnType = undefined,    // Function to execute the option
        short : byte,                   // Short form, e.g., -n|-N
        long  : slice,                  // Long form, e.g., --name
        value : slice = "",             // Value of the option
        const fnType = *const fn (slice) bool;
    };

    /// -
    pub const Error = error {
        NoArgsProvided,
        UnknownCommand,
        UnknownOption,
        MissingRequiredOption,
        UnexpectedArgument,
        CommandExecutionFailed,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝