# `SuperZIG` - IO

> easy/lite(inline functions) way to read/write the terminal !

- ## Overview

    ```zig
    const io = @import("io");

    pub fn main() !void
    {
        io.out("Hi:");                                          // print msg

        const name = io.ask("> What is your name ?");           // print msg and read user input

        io.outFMT("> Nice to meet you Mr.{s} !\n", .{ name });  // print and format msg

        io.out("Bye.");                                         // print msg
    }
    ```

    **_result :_**
    
    ```bash
    Hi:                                                         # using out
    > What is your name ?                                       # using ask/out
    Maysara                                                     # using ask/get
    > Nice to meet you Mr.Maysara !                             # using outFMT
    Bye.                                                        # using out
    ```

- ## Functions
  
    - #### out(`_msg`) `void`
    - #### outFMT(`_msg`, `_args`) `void`
    - #### get(`_msg`) `[]const u8`
    - #### ask(`_msg`) `void`
    - #### eql(`_type`, `_one`, `_two`) `bool`