# [←](../Bytes.md) `Bytes`.`countVisual`

> Returns the total number of visual characters.

```zig
pub fn countVisual(value: []const u8) countVisualError!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const myArray = try Bytes.init(64, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = myArray.len;                     // 👉 64 (Size of array)
        _ = Bytes.countWritten(&myArray);    // 👉 18 (Number of written bytes)
        _ = try Bytes.countVisual(&myArray); // 👉 8  (Number of Visual characters)
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
        _ = Bytes.countVisual(invalidUtf8); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.countWritten`](./countWritten.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>