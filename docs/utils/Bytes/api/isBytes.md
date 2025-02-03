# [←](../Bytes.md) `Bytes`.`isBytes`

> Returns `true` **if the value is a valid array of bytes**.

```zig
pub fn isBytes(value: anytype) bool
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type      | Description         |
    | --------- | --------- | ------------------- |
    | `value`   | `anytype` | The value to check. |

- #### ✨ Returns : `bool`

    > `true` is returned **if the value is a valid array of bytes**, otherwise `false` is returned.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    ```

    - ##### 🟢 True Cases

        ```zig
        _ = Bytes.isBytes("");          // 👉 true (empty array)
        _ = Bytes.isBytes("#");         // 👉 true (non empty array)
        ```

    - ##### 🔴 False Cases

        ```zig
        _ = Bytes.isBytes('#');         // 👉 false (`#` is a single byte not an array of bytes)
        _ = Bytes.isBytes([_]u7{0});    // 👉 false (An array of `u7` which is invalid byte type)
        ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.isByte`](./isByte.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>