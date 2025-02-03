# [←](../Bytes.md) `Bytes`.`replaceAllSlices`

> Replaces all occurrences of a slice with another.

```zig
pub inline fn replaceAllSlices(dest: [] u8, match: []const u8, replacement: []const u8) replaceError!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type   | Description                |
    | ------------- | ------ | -------------------------- |
    | `dest`        | `[]u8` | The destination to handle. |
    | `match`       | `[]u8` | The slice to match.        |
    | `replacement` | `[]u8` | The slice to replace with. |

- #### 🚫 Errors

    | Error        | Reason                                                      |
    | ------------ | ----------------------------------------------------------- |
    | `OutOfRange` | The destination size is not enough to hold the replacement. |

- #### ✨ Returns : `usize`

    > Modifies `dest` in place and returns the number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        const res = try Bytes.replaceAllSlices(&array, "👨‍🏭", "World");
        // res          👉 1
        // array[0..12] 👉 "Hello World!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        var array = try Bytes.init(3, "aXb");
        _ = Bytes.replaceAllSlices(&array, "X", "YYY"); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.replaceAllChars`](./replaceAllChars.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>