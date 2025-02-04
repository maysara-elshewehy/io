# [←](../Bytes.md) `Bytes`.`writtenSlice`

> Returns a slice containing only the written part.

```zig
pub fn writtenSlice(value: []const u8) []const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description          |
    | --------- | ------------ | -------------------- |
    | `value`   | `[]const u8` | The value to handle. |

- #### ✨ Returns : `[]const u8`

    > Returns a slice containing only the written part.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const array = try Bytes.init(64, "Hello  🌍!");
    ```

    ```zig
    _ = Bytes.writtenSlice(&array); // 👉 "Hello  🌍!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.countWritten`](./countWritten.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>