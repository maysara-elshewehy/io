# [←](../Buffer.md) `Buffer`.`replaceVisualRange`

> Replaces a visual range of bytes with another.

```zig
pub fn replaceVisualRange(self: anytype, start: usize, len: usize, replacement: []const u8) replaceError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                                                 |
    | ------------- | ------- | ----------------------------------------------------------- |
    | `self`        | `*Self` | The `Buffer` instance.                                      |
    | `start`       | `usize` | The start index.                                            |
    | `len`         | `usize` | The length to replace (any unicode character equals **1**). |
    | `replacement` | `[]u8`  | The slice to replace with.                                  |

- #### 🚫 Errors

    | Error        | Reason                                                   |
    | ------------ | -------------------------------------------------------- |
    | `OutOfRange` | The `Buffer` size is not enough to hold the replacement. |

- #### ✨ Returns : `void`

    > Modifies `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(64, "Hello 👨‍🏭!");
    defer buffer.deinit();
    ```

    ```zig
    try buffer.replaceVisualRange(6, 1, "World"); // 👉 "Hello World!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.replaceAllChars`](./replaceAllChars.md)

  > [`Buffer.replaceAllSlices`](./replaceAllSlices.md)

  > [`Buffer.replaceRange`](./replaceRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>