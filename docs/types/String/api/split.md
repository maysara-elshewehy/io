# [←](../String.md) `String`.`split`

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
    | `self`       | `Self`       | The `String` instance.               |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?[]const u8`

    > Returns the substring at the specified index.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    const string = try String.init(allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
    defer string.deinit();
    ```

    > Basic splits
    ```zig
    _ = string.split("👨‍🏭", 0).?; // 👉 "0"
    _ = string.split("👨‍🏭", 1).?; // 👉 "11"
    _ = string.split("👨‍🏭", 2).?; // 👉 "2"
    _ = string.split("👨‍🏭", 3).?; // 👉 "33"
    ```

    > Out-of-bounds indices
    ```zig
    _ = string.split("👨‍🏭", 4); // 👉 null
    ```

    > Empty input.
    ```zig
    _ = string.split(&string, 0, "👨‍🏭", 0).?; // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    _ = string.split("X", 0).?; // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.splitAll`](./splitAll.md)

  > [`String.splitToString`](./splitToString.md)

  > [`String.splitAllToStrings`](./splitAllToStrings.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>