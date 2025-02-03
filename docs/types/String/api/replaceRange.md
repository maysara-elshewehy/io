# [←](../String.md) `String`.`replaceRange`

> Replaces a range of bytes with another.

```zig
pub fn replaceRange(self: anytype, start: usize, len: usize, replacement: []const u8) Allocator.Error!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                |
    | ------------- | ------- | -------------------------- |
    | `self`        | `*Self` | The `String` instance.     |
    | `start`       | `usize` | The start index.           |
    | `len`         | `usize` | The length to replace.     |
    | `replacement` | `[]u8`  | The slice to replace with. |

- #### 🚫 Errors

    | Error             | Reason                 |
    | ----------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `void`

    > Modifies `String` instance in place.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    ```zig
    try string.replaceRange(6, 11, "World"); // 👉 "Hello World!"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.replaceAllChars`](./replaceAllChars.md)

  > [`String.replaceAllSlices`](./replaceAllSlices.md)

  > [`String.replaceRange`](./replaceRange.md)

  > [`String.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>