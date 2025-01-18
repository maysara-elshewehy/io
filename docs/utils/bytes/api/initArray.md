# [←](../bytes.md) `bytes`.`initArray`

> Initializes an array of bytes of a given `size`, filled with null bytes.

```zig
pub fn initArray(comptime array_size: usize) initArrayError![array_size]u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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

    > Produces an array of bytes of the specified size, initialized with null bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const bytes = @import("io").utils.bytes;
    ```

    - ##### 🟢 Success Cases

        > **_Non-Zero size._**

        ```zig
        _ = try bytes.initArray(1);   // 👉 { 0 }
        _ = try bytes.initArray(2);   // 👉 { 0, 0 }
        ```

    - ##### 🔴 Failure Cases
        
        > **_ZeroSize._**

        ```zig
        _ = try bytes.initArray(0);   // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`bytes.initArrayWith`](./initArrayWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>