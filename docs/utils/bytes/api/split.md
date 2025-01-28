# [←](../bytes.md) `bytes`.`split`

> Splits the written portion of the string into substrings separated by the delimiter, returning the substring at the specified index.

```zig
pub fn split(dest: []const u8, dest_wlen: usize, delimiters: []const u8, index: usize) ?[]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                          |
    | ------------ | ------------ | ------------------------------------ |
    | `dest`       | `[]const u8` | The destination to split.            |
    | `dest_wlen`  | `usize`      | The length of the destination.       |
    | `delimiters` | `[]const u8` | The delimiters to split by.          |
    | `index`      | `usize`      | The index of the matching delimiter. |

- #### ✨ Returns : `?[]const u8`

    > Returns the substring at the specified index.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;

    const input = "0👨‍🏭11👨‍🏭2👨‍🏭33";
    const myArray = try Bytes.init(64, input);
    ```

    > Basic splits
    ```zig
    _ = Bytes.split(&myArray, input.len, "👨‍🏭", 0).?; // 👉 "0"
    _ = Bytes.split(&myArray, input.len, "👨‍🏭", 1).?; // 👉 "11"
    _ = Bytes.split(&myArray, input.len, "👨‍🏭", 2).?; // 👉 "2"
    _ = Bytes.split(&myArray, input.len, "👨‍🏭", 3).?; // 👉 "33"
    ```

    > Out-of-bounds indices
    ```zig
    _ = Bytes.split(&myArray, input.len, "👨‍🏭", 4);  // 👉 null
    ```

    > Empty input.
    ```zig
    _ = Bytes.split(&myArray, 0, "👨‍🏭", 0).?;        // 👉 ""
    ```

    > Non-existent delimiter.
    ```zig
    _ = Bytes.split(&myArray, input.len, "X", 0).?; // 👉 "0👨‍🏭11👨‍🏭2👨‍🏭33"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.splitAll`](./splitAll.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>