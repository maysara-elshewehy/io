# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`cls`**

- #### **Definition**

    Clears the terminal(Screen).

- #### **Prototype**

    ```zig
    pub inline fn cls
    () 
    !void
    ```

- #### **Example**

    ```zig
    try io.out("Welcome!"); // print => "Welcome!\n"
    try io.cls();           // cleanup
    ```

- ##### Related

  - ###### [`clsLine`](./clsLine.md)
  
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).