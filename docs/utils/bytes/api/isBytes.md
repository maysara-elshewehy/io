# [←](../bytes.md) `bytes`.`isBytes`

> Returns `true` **if the value is a valid array of bytes**.

```zig
pub inline fn isBytes(value: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type      | Description         |
    | --------- | --------- | ------------------- |
    | `value`   | `anytype` | The value to check. |

- #### ✨ Returns : `bool`

    > `true` is returned **if the value is a valid array of bytes**, otherwise `false` is returned.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const bytes = @import("io").utils.bytes;
    ```

    - ##### 🟢 True Cases

        ```zig
        _ = bytes.isBytes("");          // 👉 true (empty array)
        _ = bytes.isBytes("#");         // 👉 true (non empty array)
        ```

    - ##### 🔴 False Cases

        ```zig
        _ = bytes.isBytes('#');         // 👉 false (`#` is a single byte not an array of bytes)
        _ = bytes.isBytes([_]u7{0});    // 👉 false (An array of `u7` which is invalid byte type)
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`bytes.isByte`](./isByte.md)

  > [`bytes.toBytes`](./tobytes.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>