# [←](../Buffer.md) `Buffer`.`replaceAllChars`

> Replaces all occurrence of a character with another.

```zig
pub fn replaceAllChars(self: *Self, match: u8, replacement: u8) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                    |
    | ------------- | ------- | ------------------------------ |
    | `self`        | `*Self` | The `Buffer` instance.         |
    | `match`       | `u8`    | The character to replace.      |
    | `replacement` | `u8`    | The character to replace with. |

- #### ✨ Returns : `void`

    > Modifies `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(64, "aXb");
    ```

    ```zig
    buffer.replaceAllChars('X', 'Y'); // buffer 👉 "aYb"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.replaceAllSlices`](./replaceAllSlices.md)

  > [`Buffer.replaceRange`](./replaceRange.md)

  > [`Buffer.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>