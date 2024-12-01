# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`types.key`** 🎹

- #### **Definition**

    A struct representing the details of a key press event, including its code, modifiers, and state.

- #### **Prototype**

    ```zig
    pub const key = struct
    {
        pub const State = enum { None, SinglePress, DoublePress, };
        pub const Arrow = enum { None, Up, Down, Right, Left };

        m_val   : u8,                   // Key code
        m_mod   : u3,                   // Modifier keys (ctrl, alt, shift)
        m_state : State,                // Press state
        m_arrow : Arrow = Arrow.None,   // arrow keys

    };
    ```

- #### **Fields**

  - `m_val` The key code (as an 8-bit unsigned integer).

  - `m_mod` Modifier keys applied (`ctrl`, `alt`, `shift`), represented as a 3-bit unsigned integer.

  - `m_state` The press state, represented by the `State` enum:

    - `None` No press detected.

    - `SinglePress` A single key press.

    - `DoublePress` A double key press.

  - `m_arrow` Arrow keys, represented by the `Arrow` enum:
    
    - `None` No arrow pressed.
    
    - `Up` Up arrow pressed.
    
    - `Down` Down arrow pressed.
    
    - `Left` Left arrow pressed.
    
    - `Right` Right arrow pressed.

- #### **Methods**

  - **state**  
      
      > Returns the press state of the key.  

      ```zig
      pub inline fn state(_self: *const key) State;
      ```

  - **code**  
      
      > Returns the key code.  

      ```zig
      pub inline fn code(_self: *const key) u8;
      ```

  - **char**  
      
      > Returns the character representation of the key based on modifiers.  

      ```zig
      pub inline fn char(_self: *const key) u8;
      ```

  - **mod**  
      
      > Returns a string representation of the active modifiers.  

      ```zig
      pub inline fn mod(_self: *const key) []const u8;
      ```

  - **alt**  
      
      > Returns `true` if the `Alt` modifier is active.  

      ```zig
      pub inline fn alt(_self: *const key) bool;
      ```

  - **ctrl**  
      
      > Returns `true` if the `Ctrl` modifier is active.  

      ```zig
      pub inline fn ctrl(_self: *const key) bool;
      ```

  - **shift**  
      
      > Returns `true` if the `Shift` modifier is active.  

      ```zig
      pub inline fn shift(_self: *const key) bool;
      ```

  - **enter**  
      
      > Returns `true` if the `Enter` key is pressed.  

      ```zig
      pub inline fn shift(_self: *const key) bool;
      ```

  - **backspace**  
      
      > Returns `true` if the `Backspace` key is pressed.  

      ```zig
      pub inline fn backspace(_self: *const key) bool;
      ```

  - **upArrow**  
      
      > Returns `true` if the `upArrow` key is pressed.  

      ```zig
      pub inline fn upArrow(_self: *const key) bool;
      ```

  - **downArrow**  
      
      > Returns `true` if the `downArrow` key is pressed.  

      ```zig
      pub inline fn downArrow(_self: *const key) bool;
      ```

  - **rightArrow**  
      
      > Returns `true` if the `rightArrow` key is pressed.  

      ```zig
      pub inline fn rightArrow(_self: *const key) bool;
      ```

  - **leftArrow**  
      
      > Returns `true` if the `leftArrow` key is pressed.  

      ```zig
      pub inline fn leftArrow(_self: *const key) bool;
      ```

  - **arrow**  
      
      > Returns `Arrow` enum.  

      ```zig
      pub inline fn leftArrow(_self: *const key) Arrow;
      ```

  - **count**  
      
      > Returns the count of active modifiers. 

      > 1 for the key itself, and 1 for ctrl, 1 for shift, 1 for alt, so the min is 1, max is 4.  

      ```zig
      pub inline fn count(_self: *const key) u8;
      ```

- #### **Example**

    ```zig
    const myKey = key
    {
        .m_val      = 65,                     // 'A'
        .m_mod      = 2,                      // 'Shift'
        .m_state    = key.State.DoublePress   // 'A' + 'Shift',
    };

    try io.outWith( "Char: {c},    Modifiers: {s},    Count: {d}   \n",
                 .{ myKey.char(),   myKey.mod(),     myKey.count() });
    ```

    **_RESULT_**

    ```zig
    Char: 'A', Modifiers: 'Shift', Count: 2
    ```

- #### **Notes**

    - **Platform-specific, with support for `Windows` and `Linux`.**

    - **Outputs an error message for unsupported platforms.**

- ##### Related

  - ###### [`io.on`](../func/on.md)
  - ###### [`io.once`](../func/once.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).