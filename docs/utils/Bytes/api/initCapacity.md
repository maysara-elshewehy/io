# [←](../Bytes.md) `Bytes`.`initCapacity`

> Initializes an array of bytes of a given `size`, filled with null Bytes.

```zig
pub fn initCapacity(comptime array_size: usize) initCapacityError![array_size]u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter    | Type             | Description            |
    | ------------ | ---------------- | ---------------------- |
    | `array_size` | `comptime usize` | The size of the array. |

- #### 🚫 Errors

    | Error      | Reason             |
    | ---------- | ------------------ |
    | `ZeroSize` | The `size` is `0`. |

- #### ✨ Returns : `[array_size]u8`

    > Produces an array of bytes of the specified size, initialized with null Bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    ```

    - ##### 🟢 Success Cases

        > **_Non-Zero size._**

        ```zig
        _ = try Bytes.initCapacity(1);   // 👉 { 0 }
        _ = try Bytes.initCapacity(2);   // 👉 { 0, 0 }
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = Bytes.initCapacity(0);   // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>