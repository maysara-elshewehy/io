# [←](../uString.md) `uString`.`splitAllToStrings`

>  Splits the written portion of the string into all substrings separated by the delimiter, returning an array of new `uString` instances. Caller must free the returned memory.

```zig
pub fn splitAllToStrings(self: anytype, allocator: Allocator, delimiters: []const u8) Allocator.Error![]Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                 |
    | ------------ | ------------ | --------------------------- |
    | `self`       | `Self`       | The `uString` instance.     |
    | `allocator`  | `Allocator`  | The allocator to use.       |
    | `delimiters` | `[]const u8` | The delimiters to split by. |

- #### 🚫 Errors

    | Error            | Reason                 |
    | ---------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `[]Self`

    > Returns an array of new `uString` instances.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    const string = try uString.init(allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
    defer string.deinit(allocator);
    ```

    ```zig
    const parts = try string.splitAllToStrings(allocator, "👨‍🏭");
    defer allocator.free(parts);
    try expectStrings("", parts[0].slice());
    try expectStrings("a", parts[1].slice());
    try expectStrings("b", parts[2].slice());
    try expectStrings("", parts[3].slice());
    for(0..parts.len) |i| { defer parts[i].deinit(allocator); }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.split`](./splitAll.md)

  > [`uString.splitAll`](./splitAll.md)

  > [`uString.splitTouString`](./splitTouString.md)

  > [`uString.splitAllTouStrings`](./splitAllTouStrings.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>