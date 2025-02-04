# [←](../Buffer.md) `Buffer`.`init`

> Initializes a `Buffer` of a pre-specified `size` and `value`.

```zig
pub fn init(comptime size: usize, value: []const u8) initError!Buffer(size)
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type             | Description                             |
    | --------- | ---------------- | --------------------------------------- |
    | `size`    | `comptime usize` | The total size of the buffer in Bytes.  |
    | `value`   | `[]const u8`     | The unicode encoded bytes to be viewed. |

- #### 🚫 Errors

    | Error        | Reason                                |
    | ------------ | ------------------------------------- |
    | `OutOfRange` | The length of `value` exceeds `size`. |

- #### ✨ Returns : `Self`

    > Produces a `Buffer` instance initialized with the given unicode bytes and size.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    ```

    - ##### 🟢 Success Cases

        > nonEmpty.

        ```zig
        var buffer = try Buffer.init(64, "Hello World!");

        _ = buffer.length(); // 👉 12
        ```

        > Empty

        ```zig
        var buffer = try Buffer.init(64, "");

        _ = buffer.length(); // 👉 0
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Buffer.init(1, ".."); // 👉 error.OutOfRange
        ```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.initCapacity`](./initCapacity.md)

  > [`Buffer.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>