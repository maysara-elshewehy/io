# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`clsLine`**

- #### **Definition**

    Clears the current line of the terminal.

- #### **Prototype**

    ```zig
    pub inline fn clsLine
    () 
    !void
    ```

- #### **Example**

    ```zig
    try io.out("Welcome!"); // print => "Welcome!\n"
    try io.clsLine();       // remove previous line.
    ```

- ##### Related

  - ###### [`cls`](./cls.md)
  
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).