# [←](../Buffer.md) `Buffer`.`split`

> Splits the written portion of the string into substrings separated by the delimiter, returning the substring at the specified index.

```zig
pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                          |
    | ------------ | ------------ | ------------------------------------ |
    | `self`       | `Self`       | The `Buffer` instance.               |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?[]const u8`

    > Returns the substring at the specified index.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init(64, "0👨‍🏭11👨‍🏭2👨‍🏭33");
    ```

    > Basic splits
    ```zig
    _ = buffer.split("👨‍🏭", 0).?; // 👉 "0"
    _ = buffer.split("👨‍🏭", 1).?; // 👉 "11"
    _ = buffer.split("👨‍🏭", 2).?; // 👉 "2"
    _ = buffer.split("👨‍🏭", 3).?; // 👉 "33"
    ```

    > Out-of-bounds indices
    ```zig
    _ = buffer.split("👨‍🏭", 4); // 👉 null
    ```

    > Empty input.
    ```zig
    _ = buffer.split(&buffer, 0, "👨‍🏭", 0).?; // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    _ = buffer.split("X", 0).?; // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.splitAll`](./splitAll.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>