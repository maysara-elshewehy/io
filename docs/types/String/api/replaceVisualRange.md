# [←](../String.md) `String`.`replaceVisualRange`

> Replaces a visual range of bytes with another.

```zig
pub fn replaceVisualRange(self: anytype, start: usize, len: usize, replacement: []const u8) Allocator.Error!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                                                 |
    | ------------- | ------- | ----------------------------------------------------------- |
    | `self`        | `*Self` | The `String` instance.                                      |
    | `start`       | `usize` | The start index.                                            |
    | `len`         | `usize` | The length to replace (any unicode character equals **1**). |
    | `replacement` | `[]u8`  | The slice to replace with.                                  |

- #### 🚫 Errors

    | Error             | Reason                 |
    | ----------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `void`

    > Modifies `String` instance in place.

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
    try string.replaceVisualRange(6, 1, "World"); // 👉 "Hello World!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.replaceAllChars`](./replaceAllChars.md)

  > [`String.replaceAllSlices`](./replaceAllSlices.md)

  > [`String.replaceRange`](./replaceRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>