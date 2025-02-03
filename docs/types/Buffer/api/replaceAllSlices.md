# [←](../Buffer.md) `Buffer`.`replaceAllSlices`

> Replaces all occurrences of a slice with another.

```zig
pub fn replaceAllSlices(self: *Self, match: []const u8, replacement: []const u8) replaceError!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                |
    | ------------- | ------- | -------------------------- |
    | `self`        | `*Self` | The `Buffer` instance.     |
    | `match`       | `[]u8`  | The slice to match.        |
    | `replacement` | `[]u8`  | The slice to replace with. |

- #### 🚫 Errors

    | Error        | Reason                                                   |
    | ------------ | -------------------------------------------------------- |
    | `OutOfRange` | The `Buffer` size is not enough to hold the replacement. |

- #### ✨ Returns : `usize`

    > Modifies `Buffer` instance in place and returns the number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(64, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        const res = try buffer.replaceAllSlices("👨‍🏭", "World");
        // res    👉 1
        // buffer 👉 "Hello World!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        var buffer = try Buffer.init(3, "aXb");
        _ = buffer.replaceAllSlices("X", "YYY"); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.replaceAllChars`](./replaceAllChars.md)

  > [`Buffer.replaceRange`](./replaceRange.md)

  > [`Buffer.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>