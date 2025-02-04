# [←](../Bytes.md) `Bytes`.`replaceRange`

> Replaces a range of bytes with another.

```zig
pub inline fn replaceRange(dest: []u8, dest_wlen: usize, start: usize, len: usize, replacement: []const u8) replaceError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type    | Description                |
    | ------------- | ------- | -------------------------- |
    | `dest`        | `[]u8`  | The destination to handle. |
    | `dest_wlen`   | `usize` | The destination length.    |
    | `start`       | `usize` | The start index.           |
    | `len`         | `usize` | The length to replace.     |
    | `replacement` | `[]u8`  | The slice to replace with. |

- #### 🚫 Errors

    | Error        | Reason                                                      |
    | ------------ | ----------------------------------------------------------- |
    | `OutOfRange` | The destination size is not enough to hold the replacement. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(64, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.replaceRange(&array, 18, 6, 11, "World"); // 👉 "Hello World!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        var array = try Bytes.init(3, "aXb");
        _ = Bytes.replaceRange(&array, 3, 0, 3, "YYYY"); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.replaceAllChars`](./replaceAllChars.md)

  > [`Bytes.replaceAllSlices`](./replaceAllSlices.md)

  > [`Bytes.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>