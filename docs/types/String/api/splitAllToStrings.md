# [←](../String.md) `String`.`splitAllToStrings`

>  Splits the written portion of the string into all substrings separated by the delimiter, returning an array of new `String` instances. Caller must free the returned memory.

```zig
pub fn splitAllToStrings(self: anytype, delimiters: []const u8) Allocator.Error![]Self
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type         | Description                 |
    | ------------ | ------------ | --------------------------- |
    | `self`       | `Self`       | The `String` instance.     |
    | `delimiters` | `[]const u8` | The delimiters to split by. |

- #### 🚫 Errors

    | Error            | Reason                 |
    | ---------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `[]Self`

    > Returns an array of new `String` instances.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    const string = try String.init(allocator, "👨‍🏭a👨‍🏭b👨‍🏭");
    defer string.deinit();
    ```

    ```zig
    const parts = try string.splitAllToStrings("👨‍🏭");
    defer allocator.free(parts);
    try expectStrings("", parts[0].slice());
    try expectStrings("a", parts[1].slice());
    try expectStrings("b", parts[2].slice());
    try expectStrings("", parts[3].slice());
    for(0..parts.len) |i| { defer parts[i].deinit(); }
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.split`](./splitAll.md)

  > [`String.splitAll`](./splitAll.md)

  > [`String.splitToString`](./splitToString.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>