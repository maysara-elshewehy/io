# [←](../Buffer.md) `Buffer`.`removeRange`

> Removes a `range` of bytes from the `Buffer` instance.

```zig
pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `Buffer` instance.              |
    | `pos`     | `usize` | The position of the byte to remove. |
    | `len`     | `usize` | The length to remove.               |

- #### 🚫 Errors

    | Error        | Reason                                              |
    | ------------ | --------------------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `Buffer` instance length. |

- #### ✨ Returns : `void`

    > Modifies `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(7, "Hello !");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try buffer.removeRange(0, 1); // 👉 "ello !"
        try buffer.removeRange(5, 1); // 👉 "ello "
        try buffer.removeRange(3, 1); // 👉 "ell "
        try buffer.removeRange(1, 1); // 👉 "el "
        try buffer.removeRange(0, 1); // 👉 "l "
        try buffer.removeRange(0, 1); // 👉 " "
        try buffer.removeRange(0, 1); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        try buffer.removeRange(1, 1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.remove`](./remove.md)

  > [`Buffer.removeVisual`](./removeVisual.md)

  > [`Buffer.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>