# [←](../uString.md) `uString`.`replaceAllChars`

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
    | `self`        | `*Self` | The `uString` instance.        |
    | `match`       | `u8`    | The character to replace.      |
    | `replacement` | `u8`    | The character to replace with. |

- #### ✨ Returns : `void`

    > Modifies `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "aXb");
    defer string.deinit(allocator);
    ```

    ```zig
    string.replaceAllChars('X', 'Y'); // 👉 "aYb"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.replaceAllSlices`](./replaceAllSlices.md)

  > [`uString.replaceRange`](./replaceRange.md)

  > [`uString.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>