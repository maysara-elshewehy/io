# [←](../Buffer.md) `Buffer`.`init`

> Initializes a `Buffer` of a pre-specified `size` and `value`.

```zig
pub fn init(comptime size: usize, value: []const u8) initError!Buffer(size)
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type             | Description                            |
    | --------- | ---------------- | -------------------------------------- |
    | `size`    | `comptime usize` | The total size of the buffer in bytes. |
    | `value`   | `[]const u8`     | The UTF-8 encoded bytes to be viewed.  |

- #### 🚫 Errors

    | Error          | Reason                                |
    | -------------- | ------------------------------------- |
    | `ZeroSize`     | The `value` length is 0.              |
    | `OutOfRange`   | The length of `value` exceeds `size`. |

- #### ✨ Returns : `Self`

    > Produces a `Buffer` instance initialized with the given UTF-8 bytes and size.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Buffer.init(64, "..");
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = try Buffer.init(0, ""); // 👉 error.ZeroSize
        ```

        > **_OutOfRange._**

        ```zig
        _ = try Buffer.init(1, ".."); // 👉 error.OutOfRange
        ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.initCapacity`](./initCapacity.md)

  > [`Buffer.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>