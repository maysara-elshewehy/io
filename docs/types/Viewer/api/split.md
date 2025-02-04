# [←](../Viewer.md) `Viewer`.`split`

> Splits the written portion of the string into substrings separated by the delimiter, returning the substring at the specified index.

```zig
pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                          |
    | ------------ | ------------ | ------------------------------------ |
    | `self`       | `Self`       | The `Viewer` instance.               |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?[]const u8`

    > Returns the substring at the specified index.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewer = Viewer.init("0👨‍🏭11👨‍🏭2👨‍🏭33");
    ```

    > Basic splits
    ```zig
    _ = viewer.split("👨‍🏭", 0).?; // 👉 "0"
    _ = viewer.split("👨‍🏭", 1).?; // 👉 "11"
    _ = viewer.split("👨‍🏭", 2).?; // 👉 "2"
    _ = viewer.split("👨‍🏭", 3).?; // 👉 "33"
    ```

    > Out-of-bounds indices
    ```zig
    _ = viewer.split("👨‍🏭", 4); // 👉 null
    ```

    > Empty input.
    ```zig
    _ = viewer.split(&viewer, 0, "👨‍🏭", 0).?; // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    _ = viewer.split("X", 0).?; // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.splitAll`](./splitAll.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>