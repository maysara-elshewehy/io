# [←](../Bytes.md) `Bytes`.`countWritten`

> Returns the total number of written bytes, stopping at the first null byte.

```zig
pub fn countWritten(value: []const u8) usize
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description          |
    | --------- | ------------ | -------------------- |
    | `value`   | `[]const u8` | The value to count. |

- #### ✨ Returns : `usize`

    > Returns the number of the bytes written, stopping at the first null byte.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const array = try Bytes.init(64, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = array.len;                     // 👉 64 (Size of array)
    _ = Bytes.countWritten(&array);    // 👉 18 (Number of written bytes)
    _ = try Bytes.countVisual(&array); // 👉 8  (Number of Visual characters)

    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.countVisual`](./countVisual.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>