# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`outWith`** 📢

- #### **Definition**

    A function to output a formatted message to the console.

- #### **Prototype**

    ```zig
    pub inline fn outWith
    ( comptime _fmt: []const u8, _args: anytype )
    !void
    ```

- #### **Parameters**

  - `_fmt`
      
      > A compile-time string with formatting placeholders.

  - `_args`
    
    > The arguments to fill into the placeholders.

- #### **Example**

    ```zig
    io.outWith("Hello, {s}!\n", .{ "World" }); // Output => Hello, World!
    ```

- #### **Notes**
  
    - Uses ZIG `std.io writer` for output.

    - **Can throw errors if writing to `stdout` fails.**

- ##### Related

  - ###### [`io.out`](./out.md)
  
  - ###### [`io.outWriter`](./outWriter.md)
  
  - ###### [`io.outWriterWith`](./outWriterWith.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).