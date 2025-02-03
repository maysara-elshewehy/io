# [←](../Bytes.md) `Bytes`.`splitAll`

> Splits the written portion of the string into all substrings separated by the delimiter, returning an array of slices. Caller must free the returned memory.

```zig
pub fn splitAll(allocator: Allocator, _dest: []const u8, dest_wlen: usize, delimiters: []const u8, include_empty: bool) AllocatorError![]const []const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter       | Type         | Description                          |
    | --------------- | ------------ | ------------------------------------ |
    | `allocator`     | `Allocator`  | The allocator to use.                |
    | `dest`          | `[]const u8` | The destination to split.            |
    | `dest_wlen`     | `usize`      | The length of the destination.       |
    | `delimiters`    | `[]const u8` | The delimiters to split by.          |
    | `include_empty` | `bool`       | Whether to include empty substrings. |

- #### 🚫 Errors

    | Error            | Reason                 |
    | ---------------- | ---------------------- |
    | `AllocatorError` | The allocation failed. |

- #### ✨ Returns : `[]const []const u8`

    > Returns an array of slices. Caller must free the returned memory.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const input = "👨‍🏭a👨‍🏭b👨‍🏭";
    ```

    > Basic usage
    ```zig
    const parts = try Bytes.splitAll(allocator, input, input.len, "👨‍🏭", true);
    defer allocator.free(parts);
    // 👉 { "", "a", "b", "" }
    ```

    > With include_empty = false
    ```zig
    const parts = try Bytes.splitAll(allocator, input, input.len, "👨‍🏭", false);
    defer allocator.free(parts);
    // 👉 { "a", "b" }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.split`](./split.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>