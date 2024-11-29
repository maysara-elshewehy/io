# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../README.md)** \ Documentation 📚

| index                             |
| --------------------------------- |
| [Functions](#functions)           |
| [Functions : Output](#output)     |
| [Functions : Input](#input)       |
| [Functions : Events](#events)     |
| [Functions : Terminal](#terminal) |
| [Functions : Files](#files)       |
| [Types](#types)                   |

---

- ## Functions

  - ### Output

    - [out ( `_msg` )](./func/out.md)
        
        > Outputs a formatted message to the console.

        ```zig
        pub inline fn out
        ( comptime _msg: []const u8 )
        !void
        ```

    - [outWith ( ` _fmt`, `_args` )](./func/outWith.md)
        
        > Outputs a simple message followed by a newline to the console.

        ```zig
        pub inline fn outWith
        ( comptime _fmt: []const u8, _args: anytype )
        !void
        ```

    - [outWriter ( ` _msg`, `_writer` )](./func/outWriter.md)
        
        > Outputs a simple message followed by a newline to a specific writer.

        ```zig
        pub inline fn outWith
        ( comptime _msg: []const u8, _writer: anytype )
        !void
        ```

    - [outWriterWith ( ` _fmt`, `_args`, `_writer` )](./func/outWriterWith.md)
        
        > Outputs a simple message followed by a newline to a specific writer.

        ```zig
        pub inline fn outWriterWith
        ( comptime _fmt: []const u8, _args: anytype, _writer: anytype )
        !void
        ```

  - ### Input

    - [in ( )](./func/in.md)
        
        > Reads input from the user until a newline character is encountered.

        ```zig
        pub inline fn in
        ( )
        ![]const u8
        ```

    - [inBuff ( `_buff` )](./func/inBuff.md)
        
        > Reads input from the user until a newline character is encountered using custom buffer.

        ```zig
        pub inline fn inBuff
        ( _buff: []u8 )
        !void
        ```

    - [ask ( `_msg` )](./func/ask.md)
        
        > Displays a message and waits for the user to respond.

        ```zig
        pub inline fn ask
        ( comptime _msg: []const u8 )
        ![]const u8
        ```

    - [askBuff ( `_msg`, `_buff` )](./func/askBuff.md)
        
        > Displays a message and waits for the user to respond using custom buffer.

        ```zig
        pub inline fn ask
        ( comptime _msg: []const u8, _buff: []u8 )
        !void
        ```

  - ### Events
    
    - [once ( `_call`, `_args` )](./func/once.md) 
        
        > Listens for key input.

        ```zig
        pub inline fn once
        ( _call: anytype, _args: anytype )
        !void
        ```

    - [on ( `_cond`, `_condArgs`, `_call`, `_callArgs` )](./func/on.md) 
        
        > Listens for key input until the condition is met.

        ```zig
        pub inline fn on
        ( _cond: anytype, _condArgs: anytype, _call: anytype, _callArgs: anytype )
        !void
        ```

    > **More?** _Check out the **[`key`](./types/key.md)** structure documentation._

  - ### Terminal

    - [cls ( )](./func/cls.md) 
        
        > Clears the terminal _(Screen)_.

        ```zig
        pub inline fn cls
        ( )
        !void
        ```

    > _.. ?_

  - ### Files

    > _.. ?_


- ## Types

  - [key](./types/key.md)
    
    > _Struct to represent key press details._

  > _.. ?_

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).
