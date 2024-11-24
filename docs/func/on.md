# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`on`** 👂

- #### **Definition**

    Continuously listens for key inputs until the condition is met.
    
- #### **Prototype**

    ```zig
    pub inline fn on
    ( _cond: anytype, _call: anytype ) 
    !void
    ```

- #### **Parameters**

  - `_cond`: A condition function that returns `true` to continue listening.

  - `_call`: A callback function invoked with key details.

- #### **Example**

    ```zig
    inline fn condition() !bool
    {
        return true; // Keeps listening.
    }

    inline fn keyCallback(key: io.types.key) !void
    {
        try io.outWith("Key code: {d}\n", .{key.get()});
    }

    try io.on(condition, keyCallback);
    ```

- #### **Notes**

    - **Platform-specific, with support for `Windows` and `Linux`.**

    - **Outputs an error message for unsupported platforms.**

- ##### Related

  - ###### [`io.once`](./once.md)

  - ###### [`io.types.key`](../types/key.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).