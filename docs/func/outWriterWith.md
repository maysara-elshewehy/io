# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`outWriterWith`** 📢

- #### **Definition**

    A function to outputs a formatted message followed by a new line to a specific writer.

    This function supports formatting with placeholders and arguments.

- #### **Prototype**

    ```zig
    pub inline fn outWriterWith
    ( comptime _fmt: []const u8, _args: anytype, writer: anytype )
    !void
    ```

- #### **Parameters**

  - `_fmt`
      
      > A compile-time string with formatting placeholders.

  - `_args`
      
    > The arguments to fill into the placeholders.

  - `_writer`
      
      > The writer.

- #### **Example**

    ```zig
    // create a buffer to capture the output
    var buffer       : [1024]u8     = undefined;
    var bufferStream                = std.io.fixedBufferStream(buffer[0..]);
    var writer                      = bufferStream.writer();

    // call your io.outWriterWith function with the custom writer
    try io.outWriterWith("{s}", .{ "outWriterWith" }, &writer); // => "outWriterWith"

    // print the buffer
    std.debug.print("{s}\n", .{ bufferStream.getWritten() });   // => "outWriterWith\n"
    ```

- #### **Notes**
        
    - **Can throw errors if writing to `_writer.print` fails.**
    
    - **Be careful not to exceed the `buffer storage capacity`.**

- ##### Related

  - ###### [`io.outWriter`](./outWriter.md)

  - ###### [`io.out`](./out.md)
  
  - ###### [`io.outWith`](./outWith.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).