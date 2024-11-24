# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`outWriter`** 📢

- #### **Definition**

    A function to outputs a simple message followed by a new line to a specific writer.
    
- #### **Prototype**

    ```zig
    pub inline fn outWriter
    ( comptime _msg: []const u8, writer: anytype )
    !void
    ```

- #### **Parameters**

  - `_msg`
      
      > The message to output.

  - `_writer`
      
      > The writer.

- #### **Example**

    ```zig
    // create a buffer to capture the output
    var buffer       : [1024]u8     = undefined;
    var bufferStream                = std.io.fixedBufferStream(buffer[0..]);
    var writer                      = bufferStream.writer();

    // call your io.outWriter function with the custom writer
    try io.outWriter("outWriter", &writer);                     // => "outWriter\n"

    // print the buffer
    std.debug.print("{s}\n", .{ bufferStream.getWritten() });   // => "outWriter\n"
    ```

- #### **Notes**
  
    - **Internally calls `_writer.print` with `"\n"` appended to `_msg`.**
  
    - **Can throw errors if writing to `_writer.print` fails.**

    - **Be careful not to exceed the `buffer storage capacity`.**

- ##### Related

  - ###### [`io.outWriterWith`](./outWriterWith.md)

  - ###### [`io.out`](./out.md)
  
  - ###### [`io.outWith`](./outWith.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).