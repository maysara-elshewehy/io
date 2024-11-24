# **[SuperZIG](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`once`** 👂

- #### **Definition**

    Continuously listens for key input.
    
- #### **Prototype**

    ```zig
    pub inline fn once
    ( _call: anytype ) 
    !void
    ```

- #### **Parameters**

  - `_call`: A callback function invoked with key details.

- #### **Example**

    ```zig
    inline fn keyCallback(key: io.types.key) !void
    {
        try io.outWith("Key code: {d}\n", .{key.code()});
    }

    try io.on(keyCallback);
    ```

- #### **Notes**

    - **Platform-specific, with support for `Windows` and `Linux`.**

    - **Outputs an error message for unsupported platforms.**

- ##### Related

  - ###### [`io.on`](./on.md)

  - ###### [`io.types.key`](../types/key.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).