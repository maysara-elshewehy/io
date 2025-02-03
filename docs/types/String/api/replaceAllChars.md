# [←](../String.md) `String`.`replaceAllChars`

> Replaces all occurrence of a character with another.

```zig
pub fn replaceAllChars(self: *Self, match: u8, replacement: u8) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                    |
    | ------------- | ------- | ------------------------------ |
    | `self`        | `*Self` | The `String` instance.         |
    | `match`       | `u8`    | The character to replace.      |
    | `replacement` | `u8`    | The character to replace with. |

- #### ✨ Returns : `void`

    > Modifies `String` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "aXb");
    defer string.deinit();
    ```

    ```zig
    string.replaceAllChars('X', 'Y'); // 👉 "aYb"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.replaceAllSlices`](./replaceAllSlices.md)

  > [`String.replaceRange`](./replaceRange.md)

  > [`String.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>