# **[SuperZig](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`in`** 📥

- #### **Definition**

    Reads input from the user until a newline character is encountered.

- #### **Prototype**

    ```zig
    pub inline fn in
    ( )
    ![]const u8
    ```

- #### **Return**

  - `[]const u8`
      
      > The user input.

- #### **Example**

    ```zig
    const input = io.in();              // (User types "Hello" and presses Enter)
    io.outWith("{s}!\n", .{ input });   // Output => Hello
    ```

- #### **Notes**

    - Uses Zig `std.io reader` for input.

    - **Reads input into a global buffer `g_buff_1024`.**
  
    - **Throws an error if reading fails.**

- ##### Related

  - ###### [`io.inBuff`](./inBuff.md)
  
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).