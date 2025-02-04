# [←](../Buffer.md) `Buffer`.`initCapacity`

> Initializes a `Buffer` of a pre-specified `size`.

```zig
pub fn initCapacity(comptime size: usize) initCapacityError!Buffer(size)
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type             | Description                            |
    | --------- | ---------------- | -------------------------------------- |
    | `size`    | `comptime usize` | The total size of the buffer in Bytes. |

- #### 🚫 Errors

    | Error          | Reason                                |
    | -------------- | ------------------------------------- |
    | `ZeroSize`     | The `value` length is 0.              |

- #### ✨ Returns : `Self`

    > Produces a `Buffer` instance initialized with the given size.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Buffer.initCapacity(64);
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = Buffer.initCapacity(0); // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>