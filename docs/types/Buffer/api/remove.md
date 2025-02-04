# [←](../Buffer.md) `Buffer`.`remove`

> Removes a byte from the `Buffer` instance.

```zig
pub fn remove(self: *Self, pos: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `Buffer` instance.              |
    | `pos`     | `usize` | The position of the byte to remove. |

- #### 🚫 Errors

    | Error        | Reason                                              |
    | ------------ | --------------------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `Buffer` instance length. |

- #### ✨ Returns : `void`

    > Modifies `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(7, "Hello !");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try buffer.remove(0); // 👉 "ello !"
        try buffer.remove(5); // 👉 "ello "
        try buffer.remove(3); // 👉 "ell "
        try buffer.remove(1); // 👉 "el "
        try buffer.remove(0); // 👉 "l "
        try buffer.remove(0); // 👉 " "
        try buffer.remove(0); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = buffer.remove(1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.removeRange`](./removeRange.md)

  > [`Buffer.removeVisual`](./removeVisual.md)

  > [`Buffer.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>