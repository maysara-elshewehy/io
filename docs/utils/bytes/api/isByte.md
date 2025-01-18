# [←](../bytes.md) `bytes`.`isByte`

> Returns `true` **if the value is a valid byte**.

```zig
pub inline fn isByte(value: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type      | Description         |
    | --------- | --------- | ------------------- |
    | `value`   | `anytype` | The value to check. |

- #### ✨ Returns : `bool`

    > `true` is returned **if the value is a valid byte**, otherwise `false` is returned.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const bytes = @import("io").utils.bytes;
    ```

    - ##### 🟢 True Cases

        ```zig
        _ = bytes.isByte(0);            // 👉 true (`0`   is within the valid byte range)
        _ = bytes.isByte(255);          // 👉 true (`255` is the maximum valid byte value)
        _ = bytes.isByte(@as(u8, 0));   // 👉 true (`u8`  is a valid byte type)
        ```

    - ##### 🔴 False Cases

        ```zig
        _ = bytes.isByte(-1);           // 👉 false (`-1`  is below the minimum byte value of `0`)
        _ = bytes.isByte(256);          // 👉 false (`256` is exceed the maximum byte value of `255`)
        _ = bytes.isByte(@as(u7, 0));   // 👉 false (`u7`  is not a full `8-bit` byte type)
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`bytes.isBytes`](./isbytes.md)

  > [`bytes.toBytes`](./tobytes.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>