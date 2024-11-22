// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const       io          = @import("./src/io.zig");
    const       std         = @import("std");
    const       testing     = std.testing;

// ╚══════════════════════════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test
    {
        // outWriter 📢
        {
            {
                // Setup: Create a buffer to capture the output
                var buffer: [1024]u8 = undefined;
                var bufferStream = std.io.fixedBufferStream(buffer[0..]);
                var writer = bufferStream.writer();

                // Act: Call your io.outWriter function with the custom writer
                try io.outWriter("Hello, World!", &writer);

                // Assert: Compare the captured output with the expected output
                try testing.expectEqualStrings("Hello, World!", bufferStream.getWritten());
            }
        }

        // TODO: implement it !
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
