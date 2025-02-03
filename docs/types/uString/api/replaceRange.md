# [←](../uString.md) `uString`.`replaceRange`

> Replaces a range of bytes with another.

```zig
pub fn replaceRange(self: anytype, allocator: Allocator, start: usize, len: usize, replacement: []const u8) Allocator.Error!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type        | Description                |
    | ------------- | ----------- | -------------------------- |
    | `self`        | `*Self`     | The `uString` instance.    |
    | `allocator`   | `Allocator` | The allocator to use.      |
    | `start`       | `usize`     | The start index.           |
    | `len`         | `usize`     | The length to replace.     |
    | `replacement` | `[]u8`      | The slice to replace with. |

- #### 🚫 Errors

    | Error             | Reason                 |
    | ----------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `void`

    > Modifies `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    ```zig
    try string.replaceRange(allocator, 6, 11, "World"); // 👉 "Hello World!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.replaceAllChars`](./replaceAllChars.md)

  > [`uString.replaceRange`](./replaceRange.md)

  > [`uString.replaceVisualRange`](./replaceVisualRange.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>