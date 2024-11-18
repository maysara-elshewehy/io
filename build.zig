// ═══════════════════════════════════════ LOAD ═══════════════════════════════════════  //

    const std = @import("std");

// ════════════════════════════════════════════════════════════════════════════════════  //



// ═══════════════════════════════════════ CORE ═══════════════════════════════════════  //

    pub fn build(b: *std.Build) void
    {
        const target    = b.standardTargetOptions(.{});
        const optimize  = b.standardOptimizeOption(.{});

        _ = b.addModule("io", .{ .root_source_file = b.path("src/io.zig") });

        var main_tests = b.addTest(
        .{
            .root_source_file   = b.path("src/io.test.zig"),
            .target             = target,
            .optimize           = optimize,
        });

        const test_step = b.step("test", "Run library tests");
        test_step.dependOn(&main_tests.step);
    }

// ════════════════════════════════════════════════════════════════════════════════════  //