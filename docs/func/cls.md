# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`cls`**

- #### **Definition**

    Clears the terminal(Screen).

- #### **Prototype**

    ```zig
    pub inline fn cls
    () 
    !void
    ```

- #### **Parameters**

  - `_msg`
      
      > The message to output.

- #### **Example**

    ```zig
    try io.out("Welcome!"); // print => "Welcome!\n"
    try io.cls();           // cleanup
    ```

- #### **Notes**

    - `. . ?`

- ##### Related

  - ###### [`. . ?`](#)
  
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).