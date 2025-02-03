# [←](../uString.md) `uString`.`splitAll`

> Splits the written portion of the string into all substrings separated by the delimiter, returning an array of slices. Caller must free the returned memory.

```zig
pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, include_empty: bool) AllocatorError![]const []const u8
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter       | Type         | Description                          |
    | --------------- | ------------ | ------------------------------------ |
    | `self`          | `Self`       | The `uString` instance.              |
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
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    const string = try uString.init(allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
    defer string.deinit(allocator);
    ```


    > Basic usage
    ```zig
    const parts = try string.splitAll(allocator, "👨‍🏭", true);
    defer allocator.free(parts);
    // 👉 { "", "a", "b", "" }
    ```

    > With include_empty = false
    ```zig
    const parts = try string.splitAll(allocator, "👨‍🏭", false);
    defer allocator.free(parts);
    // 👉 { "a", "b" }
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.split`](./splitAll.md)

  > [`uString.splitTouString`](./splitTouString.md)

  > [`uString.splitAllTouStrings`](./splitAllTouStrings.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>