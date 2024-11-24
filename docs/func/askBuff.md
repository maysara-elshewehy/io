# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`askBuff`** ❓

- #### **Definition**

    Displays a message and waits for the user to respond using custom buffer.

- #### **Prototype**

    ```zig
    pub inline fn askBuff
    ( comptime _msg: []const u8, _buff: []u8 ) 
    !void
    {
        try out     (_msg);
        try inBuff  (_buff);
    }
    ```

- #### **Parameters**

  - `_msg`
  
    > The question to ask.

  - `_buff`
  
    > The buffer to read to.

- #### **Return**

  - `[]const u8`
  
    > The answer of the question.

- #### **Example**

    ```zig
    var buffer: [20]u8 = undefined;
    try io.askBuff("What's your name?", &buffer);       // => print "What's your name?\n"
                                                        // wait for user input
    try io.outWith("You typed: {s}\n", .{ buffer });    // => "You typed <buffer>\n"
    ```

- #### **Notes**

  - **Combines `out` and `inBuff` to create a ask-response mechanism.**
  
  > see notes of [`out`](./out.md) and [`inBuff`](./inBuff.md) for more details.

- ##### Related

  - ###### [`io.out`](./out.md)
  
  - ###### [`io.inBuff`](./inBuff.md)

  - ###### [`io.ask`](./ask.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).