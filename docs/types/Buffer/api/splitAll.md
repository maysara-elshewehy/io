# [←](../Buffer.md) `Buffer`.`splitAll`

> Splits the written portion of the string into all substrings separated by the delimiter, returning an array of slices. Caller must free the returned memory.

```zig
pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, include_empty: bool) AllocatorError![]const []const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter       | Type         | Description                          |
    | --------------- | ------------ | ------------------------------------ |
    | `self`          | `Self`       | The `Buffer` instance.               |
    | `allocator`     | `Allocator`  | The allocator to use.                |
    | `delimiters`    | `[]const u8` | The delimiters to split by.          |
    | `include_empty` | `bool`       | Whether to include empty substrings. |

- #### 🚫 Errors

    | Error            | Reason                 |
    | ---------------- | ---------------------- |
    | `AllocatorError` | The allocation failed. |

- #### ✨ Returns : `[]const []const u8`

    > Returns an array of slices. Caller must free the returned memory.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init(35, "👨‍🏭a👨‍🏭b👨‍🏭");
    // the size of the buffer must be the same as the contents.
    ```


    > Basic usage
    ```zig
    const parts = try buffer.splitAll(allocator, "👨‍🏭", true);
    defer allocator.free(parts);
    // 👉 { "", "a", "b", "" }
    ```

    > With include_empty = false
    ```zig
    const parts = try buffer.splitAll(allocator, "👨‍🏭", false);
    defer allocator.free(parts);
    // 👉 { "a", "b" }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.split`](./split.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>