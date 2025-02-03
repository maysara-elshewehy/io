# [←](../Bytes.md) `Bytes`.`replaceVisualRange`

> Replaces a visual range of bytes with another.

```zig
pub inline fn replaceVisualRange(dest: []u8, dest_wlen: usize, start: usize, len: usize, replacement: []const u8) replaceError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                                                 |
    | ------------- | ------- | ----------------------------------------------------------- |
    | `dest`        | `[]u8`  | The destination to handle.                                  |
    | `dest_wlen`   | `usize` | The destination length.                                     |
    | `start`       | `usize` | The start index.                                            |
    | `len`         | `usize` | The length to replace (any unicode character equals **1**). |
    | `replacement` | `[]u8`  | The slice to replace with.                                  |

- #### 🚫 Errors

    | Error        | Reason                                                      |
    | ------------ | ----------------------------------------------------------- |
    | `OutOfRange` | The destination size is not enough to hold the replacement. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.replaceVisualRange(&array, 18, 6, 1, "World"); // 👉 "Hello World!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        var array = try Bytes.init(3, "aXb");
        _ = Bytes.replaceVisualRange(&array, 3, 0, 3, "YYYY"); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.replaceAllChars`](./replaceAllChars.md)

  > [`Bytes.replaceAllSlices`](./replaceAllSlices.md)

  > [`Bytes.replaceRange`](./replaceRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>