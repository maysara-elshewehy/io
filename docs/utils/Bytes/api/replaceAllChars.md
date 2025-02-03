# [←](../Bytes.md) `Bytes`.`replaceAllChars`

> Replaces all occurrence of a character with another.

```zig
pub inline fn replaceAllChars(dest: []u8, match: u8, replacement: u8) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type   | Description                    |
    | ------------- | ------ | ------------------------------ |
    | `dest`        | `[]u8` | The destination to handle.     |
    | `match`       | `u8`   | The character to replace.      |
    | `replacement` | `u8`   | The character to replace with. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(64, "aXb");
    ```

    ```zig
    Bytes.replaceAllChars(&array, 'X', 'Y'); // array[0..3] 👉 "aYb"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.replaceAllSlices`](./replaceAllSlices.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>