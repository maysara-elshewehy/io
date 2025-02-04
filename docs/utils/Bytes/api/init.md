# [←](../Bytes.md) `Bytes`.`init`

> Initializes an array of bytes of a given `size` and `value`,
> terminated with a null byte **if the `size` is greater than the length of `value`**.

```zig
pub fn init(comptime size: usize, value: []const u8)initError![size]u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type             | Description                     |
    | --------- | ---------------- | ------------------------------- |
    | `size`    | `comptime usize` | The size of the array.          |
    | `value`   | `[]const u8`     | The initial value of the array. |

- #### 🚫 Errors

    | Error        | Reason                                |
    | ------------ | ------------------------------------- |
    | `ZeroSize`   | The `size` is `0`.                    |
    | `OutOfRange` | The length of `value` exceeds `size`. |

- #### ✨ Returns : `[size]u8`

    > Produces an array of bytes of the specified size, initialized with the given value and terminated with a null byte, _**if the `size` is greater than the length of `value`**_.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Bytes.init(1, "A"); // 👉 { 'A' }
        _ = try Bytes.init(2, "A"); // 👉 { 'A', 0 }
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = Bytes.init(0, "");      // 👉 error.ZeroSize
        ```

        > **_OutOfRange._**

        ```zig
        _ = Bytes.init(1, "AB");    // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>