# [←](../String.md) `String`.`replaceAllSlices`

> Replaces all occurrences of a slice with another.

```zig
pub fn replaceAllSlices(self: *Self, match: []const u8, replacement: []const u8) Allocator.Error!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                |
    | ------------- | ------- | -------------------------- |
    | `self`        | `*Self` | The `String` instance.     |
    | `match`       | `[]u8`  | The slice to match.        |
    | `replacement` | `[]u8`  | The slice to replace with. |

- #### 🚫 Errors

    | Error             | Reason                 |
    | ----------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `usize`

    > Modifies `String` instance in place and returns the number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    ```zig
    const res = try string.replaceAllSlices(allocator, "👨‍🏭", "World");
    // res    👉 1
    // string 👉 "Hello World!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.replaceAllChars`](./replaceAllChars.md)

  > [`String.replaceRange`](./replaceRange.md)

  > [`String.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>