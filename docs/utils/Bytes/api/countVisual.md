# [←](../Bytes.md) `Bytes`.`countVisual`

> Returns the total number of visual characters.

```zig
pub fn countVisual(value: []const u8) countVisualError!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description         |
    | --------- | ------------ | ------------------- |
    | `value`   | `[]const u8` | The value to count. |

- #### 🚫 Errors

    | Error          | Reason                               |
    | -------------- | ------------------------------------ |
    | `InvalidValue` | The value is not valid unicode foramt. |

- #### ✨ Returns : `usize`

    > Returns the number of the visual characters, stopping at the first null byte.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const array = try Bytes.init(64, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = array.len;                     // 👉 64 (Size of array)
        _ = Bytes.countWritten(&array);    // 👉 18 (Number of written bytes)
        _ = try Bytes.countVisual(&array); // 👉 8  (Number of Visual characters)
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        const invalidUnicode = &[_]u8{0x80, 0x81, 0x82};
        _ = Bytes.countVisual(invalidUnicode); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.countWritten`](./countWritten.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>