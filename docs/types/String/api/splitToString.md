# [←](../String.md) `String`.`splitToString`

> Splits the written portion of the string into substrings separated by the delimiter, returning the substring at the specified index as a new `String` instance.

```zig
pub fn splitToString(self: Self, allocator: Allocator, delimiters: []const u8, index: usize) Allocator.Error!?Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                          |
    | ------------ | ------------ | ------------------------------------ |
    | `self`       | `Self`       | The `String` instance.              |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?Self`

    > Returns the substring at the specified index as a new `String` instance.

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
    if(try string.splitToString("👨‍🏭", 0)) |res| {
        defer res.deinit();
        res.slice(); // 👉 "0"
    }
    if(try string.splitToString("👨‍🏭", 1)) |res| {
        defer res.deinit();
        res.slice(); // 👉 "11"
    }
    if(try string.splitToString("👨‍🏭", 2)) |res| {
        defer res.deinit();
        res.slice(); // 👉 "2"
    }
    if(try string.splitToString("👨‍🏭", 3)) |res| {
        defer res.deinit();
        res.slice(); // 👉 "33"
    }
    ```

    > Out-of-bounds indices
    ```zig
    try string.splitToString("👨‍🏭", 4); // 👉 null
    ```

    > Empty input.
    ```zig
    var string2 = String.initAlloc(alloctor);
    (try string2.splitToString("👨‍🏭", 0)).?.slice(); // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    if(try string.splitToString("X", 0)) |res| {
        defer res.deinit();
        res.slice(); // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.split`](./splitAll.md)

  > [`String.splitAll`](./splitAll.md)

  > [`String.splitAllToStrings`](./splitAllToStrings.md)


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>