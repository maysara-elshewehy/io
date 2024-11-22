// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const   std         = @import("std");
    const   io          = @import("./src/io.zig");

    const   testing     = std.testing;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAIN ══════════════════════════════════════╗

    pub fn main() !void
    {
        // OUTPUT
        {
            // out 📢
            TRY("out");
            {
                try io.out("out");                                                  // => "out\n"
            }

            // outWith 📤
            TRY("outWith");
            {
                try io.outWith("{s}\n", .{"outWith"});                              // => "outWith\n"
            }

            // outWriter 📢
            TRY("outWriter");
            {
                // create a buffer to capture the output
                var buffer       : [1024]u8     = undefined;
                var bufferStream                = std.io.fixedBufferStream(buffer[0..]);
                var writer                      = bufferStream.writer();

                // call your io.outWriter function with the custom writer
                try io.outWriter("outWriter", &writer);                             // => "outWriter"

                // print buffer
                std.debug.print("{s}\n", .{ bufferStream.getWritten() });           // print buffer
            }

            // outWriterWith 📢
            TRY("outWriterWith");
            {
                // create a buffer to capture the output
                var buffer       : [1024]u8     = undefined;
                var bufferStream                = std.io.fixedBufferStream(buffer[0..]);
                var writer                      = bufferStream.writer();

                // call your io.outWriterWith function with the custom writer
                try io.outWriterWith("{s}", .{ "outWriterWith" }, &writer);         // => "outWriterWith"

                // print buffer
                std.debug.print("{s}\n", .{ bufferStream.getWritten() });           // print buffer
            }
        }

        // INPUT
        {
            // in 📥
            TRY("in");
            {
                const res = try io.in();                                            // => (wait for user input)
                
                try io.outWith("You typed: {s}\n", .{ res });                       // print user input
            }

            // inBuff 📥
            TRY("inBuff");
            {
                var buffer: [20]u8 = undefined;
                try io.inBuff(&buffer);                                             // => (wait for user input)

                // for(0..buffer.len) |i| { if(buffer[i] == '\n') { buffer[i] = 0; break; } }
                try io.outWith("You typed: {s}", .{ buffer });                      // print user input
            }

            // ask ❓
            TRY("ask");
            {
                const res = try io.ask("What's your name?");                        // print "What's your name?\n"
                                                                                    // => (wait for user input)
                                                                                    
                try io.outWith("You typed: {s}\n", .{ res });                       // print user input
            }
            
            // askBuff ❓
            TRY("askBuff");
            {
                var buffer: [20]u8 = undefined;

                try io.askBuff("What's your name?", &buffer);                       // print "What's your name?\n"
                                                                                    // => (wait for user input)
                                                                                    
                try io.outWith("You typed: {s}", .{ buffer });                      // print user input
            }
        }

        // EVENTS
        {
            // on / once 👂
            {
                const example = struct
                {
                    inline fn callback(key: io.types.key) !void
                    {
                        try io.outWith("code: {d} , char:  {c} , mod: {s}       \n"   , .{ key.get(),  key.char(),  key.mod() });
                        try io.outWith("ctrl: {}  , shift: {}  , alt: {}        \n\n" , .{ key.ctrl(), key.shift(), key.alt() });
                    }

                    inline fn condition() !bool
                    {
                        return true;
                    }

                    inline fn run() !void
                    {
                        TRY("once");
                        {
                            try io.once(callback);
                        }

                        TRY("on");
                        {
                            try io.on(condition, callback);
                        }
                    }
                };

                try example.run();
            }
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ____ ══════════════════════════════════════╗

    var __isNotFirstTest = false;
    pub fn TRY (_msg: []const u8) void
    {
        if(__isNotFirstTest)
        {
            std.debug.print("---------------------- \n", .{ });

            std.time.sleep(2 * std.time.ns_per_s);
        }
        else
        {
            __isNotFirstTest = true;
        }

        io.cls() catch unreachable;

        std.debug.print("[TRY] ==> [{s}] \n", .{ _msg });
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
