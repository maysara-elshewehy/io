# **[SuperZig](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`out`** 📢

- #### **Definition**

    A function to output a simple message followed by new line to the console.

- #### **Prototype**

    ```zig
    pub inline fn out
    ( comptime _msg: []const u8 )
    !void
    ```

- #### **Parameters**

  - `_msg`
      
      > The message to output.

- #### **Example**

    ```zig
    io.out("Welcome!"); // Output => "Welcome!"
    ```

- #### **Notes**

    - Uses Zig `std.io writer` for output.

    - **Internally calls `outWith` with `"\n"` appended to `_msg`.**
  
    - **Can throw errors if writing to `stdout` fails.**

- ##### Related

  - ###### [`io.outWith`](./outWith.md)
  
  - ###### [`io.outWriter`](./outWriter.md)

  - ###### [`io.outWriterWith`](./outWriterWith.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).