// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std               = @import("std");
    const cli               = @import("./cli.zig");
    const expect            = std.testing.expect;
    const expectEqual       = std.testing.expectEqual;
    const expectError       = std.testing.expectError;
    const expectStrings     = std.testing.expectEqualStrings;
    const expectSlices      = std.testing.expectEqualSlices;
    const Allocator         = std.mem.Allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Test ══════════════════════════════════════╗

    // ┌──────────────────────────── ---- ────────────────────────────┐

        fn TrueHandler(_: []const cli.option) bool { return true; }
        fn FalseHandler(_: []const cli.option) bool { return false; }

        test "No command provided" {
            const commands = &[_]cli.command{};
            const options = &[_]cli.option{};
            const args = &[_][]const u8{"program_name"};
            try expectError(cli.Error.NoArgsProvided, cli.startWithArgs(commands, options, args, false));
        }

        test "Unknown command" {
            const commands = &[_]cli.command{
                .{ .name = "known_command", .func = TrueHandler },
            };
            const options = &[_]cli.option{};
            const args = &[_][]const u8{"program_name", "unknown_command"};
            try expectError(cli.Error.UnknownCommand, cli.startWithArgs(commands, options, args, false));
        }

        test "Unknown option" {
            const commands = &[_]cli.command{
                .{ .name = "known_command", .func = TrueHandler },
            };
            const options = &[_]cli.option{
                .{ .name = "known_option", .short = 'k', .long = "known" },
            };
            const args = &[_][]const u8{"program_name", "known_command", "--unknown"};
            try expectError(cli.Error.UnknownOption, cli.startWithArgs(commands, options, args, false));
        }

        test "Missing required option" {
            const commands = &[_]cli.command{
                .{ .name = "known_command", .func = TrueHandler, .req = &.{ "required_option" } },
            };
            const options = &[_]cli.option{
                .{ .name = "required_option", .short = 'r', .long = "required" },
            };
            const args = &[_][]const u8{"program_name", "known_command"};
            try expectError(cli.Error.MissingRequiredOption, cli.startWithArgs(commands, options, args, false));
        }

        test "Unexpected argument" {
            const commands = &[_]cli.command{
                .{ .name = "known_command", .func = TrueHandler },
            };
            const options = &[_]cli.option{};
            const args = &[_][]const u8{"program_name", "known_command", "unexpected_arg"};
            try expectError(cli.Error.UnexpectedArgument, cli.startWithArgs(commands, options, args, false));
        }

        test "Command execution failed" {
            const commands = &[_]cli.command{
                .{ .name = "known_command", .func = FalseHandler },
            };
            const options = &[_]cli.option{};
            const args = &[_][]const u8{"program_name", "known_command"};
            try expectError(cli.Error.CommandExecutionFailed, cli.startWithArgs(commands, options, args, false));
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝
