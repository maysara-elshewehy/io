# [←](../uString.md) `uString`.`splitToString`

> Splits the written portion of the string into substrings separated by the delimiter, returning the substring at the specified index as a new `uString` instance.

```zig
pub fn splitToString(self: Self, allocator: Allocator, delimiters: []const u8, index: usize) Allocator.Error!?Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                          |
    | ------------ | ------------ | ------------------------------------ |
    | `self`       | `Self`       | The `uString` instance.              |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?Self`

    > Returns the substring at the specified index as a new `uString` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    const string = try uString.init(allocator, "0👨‍🏭11👨‍🏭2👨‍🏭33");
    defer string.deinit(allocator);
    ```

    > Basic splits
    ```zig
    if(try string.splitToString(allocator, "👨‍🏭", 0)) |res| {
        defer res.deinit(allocator);
        res.slice(); // 👉 "0"
    }
    if(try string.splitToString(allocator, "👨‍🏭", 1)) |res| {
        defer res.deinit(allocator);
        res.slice(); // 👉 "11"
    }
    if(try string.splitToString(allocator, "👨‍🏭", 2)) |res| {
        defer res.deinit(allocator);
        res.slice(); // 👉 "2"
    }
    if(try string.splitToString(allocator, "👨‍🏭", 3)) |res| {
        defer res.deinit(allocator);
        res.slice(); // 👉 "33"
    }
    ```

    > Out-of-bounds indices
    ```zig
    try string.splitToString(allocator, "👨‍🏭", 4); // 👉 null
    ```

    > Empty input.
    ```zig
    var string2 = uString.initAlloc(alloctor);
    (try string2.splitToString(allocator, "👨‍🏭", 0)).?.slice(); // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    if(try string.splitToString(allocator, "X", 0)) |res| {
        defer res.deinit(allocator);
        res.slice(); // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.split`](./splitAll.md)

  > [`uString.splitAll`](./splitAll.md)

  > [`uString.splitToString`](./splitToString.md)

  > [`uString.splitAllToStrings`](./splitAllToStrings.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>