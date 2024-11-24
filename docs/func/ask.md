# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`ask`** ❓

- #### **Definition**

    Displays a message and waits for the user to input a response.

- #### **Prototype**

    ```zig
    pub inline fn ask
    ( comptime _msg: []const u8 ) 
    ![]const u8
    ```

- #### **Parameters**

  - `_msg`
  
    > The question to ask.

- #### **Return**

  - `[]const u8`
  
    > The answer of the question.

- #### **Example**

    ```zig
    const res = try io.ask("What's your name?");    // => "What's your name?\n"
                                                    // (wait for user input)
    try io.outWith("You typed: {s}\n", .{ res });   // => "You typed <res>\n"
    ```

- #### **Notes**

  - **Combines `out` and `in` to create a ask-response mechanism.**
  
  > see notes of [`out`](./out.md) and [`in`](./in.md) for more details.

- ##### Related

  - ###### [`io.out`](./out.md)
  
  - ###### [`io.in`](./in.md)

  - ###### [`io.askBuff`](./askBuff.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).