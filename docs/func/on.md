# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`on`** 👂

- #### **Definition**

    Continuously listens for key inputs until the condition is met.
    
- #### **Prototype**

    ```zig
    pub inline fn on
    ( _cond: anytype, _condArgs: anytype, _call: anytype, _callArgs: anytype ) 
    !void
    ```

- #### **Parameters**

  - `_cond`: A condition function that returns `true` to continue listening.

  - `_condArgs`: Conditional arguments **[REQUIRED]**.

  - `_call`: A callback function invoked with key details.

  - `_callArgs`: Callback arguments **[REQUIRED]**.

- #### **Example**

    ```zig
    inline fn condition(_: anytype) !bool
    {
        return true; // Keeps listening.
    }

    inline fn keyCallback(key: io.types.key, _: anytype) !void
    {
        try io.outWith("Key code: {d}\n", .{key.code()});
    }

    try io.on(condition, .{}, keyCallback, .{});
    ```

- #### **Notes**

    - **Platform-specific, with support for `Windows` and `Linux`.**

    - **Outputs an error message for unsupported platforms.**

    - **You can pass your arguments inside the `.{ }`.**

- ##### Related

  - ###### [`io.once`](./once.md)

  - ###### [`io.types.key`](../types/key.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).