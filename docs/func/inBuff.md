# **[SuperZig](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`inBuff`** 📥

- #### **Definition**

    Reads input from the user until a newline character is encountered using custom buffer.

- #### **Prototype**

    ```zig
    pub inline fn inBuff
    ( _buff: []u8 )
    !void
    ```

- #### **Parameters**

  - `_buff`
      
      > The buffer to read to.

- #### **Example**

    ```zig
    var buffer: [20]u8 = undefined;
    try io.inBuff(&buffer);                           // => (wait for user input)
    try io.outWith("You typed: {s}\n", .{ buffer });  // => "You typed: <buffer>\n"
    ```

- #### **Notes**

    - Uses Zig `std.io reader` for input.

    - **Throws an error if reading fails.**

    - **Be careful not to exceed the `buffer storage capacity`.**

- ##### Related

  - ###### [`io.in`](./in.md)
  
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).