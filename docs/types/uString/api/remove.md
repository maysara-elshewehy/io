# [←](../uString.md) `uString`.`remove`

> Removes a byte from the `uString` instance.

```zig
pub fn remove(self: *Self, pos: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `uString` instance.             |
    | `pos`     | `usize` | The position of the byte to remove. |

- #### 🚫 Errors

    | Error        | Reason                                               |
    | ------------ | ---------------------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `uString` instance length. |

- #### ✨ Returns : `void`

    > Modifies `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello !");
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.remove(0); // 👉 "ello !"
        try string.remove(5); // 👉 "ello "
        try string.remove(3); // 👉 "ell "
        try string.remove(1); // 👉 "el "
        try string.remove(0); // 👉 "l "
        try string.remove(0); // 👉 " "
        try string.remove(0); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.remove(1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.removeRange`](./removeRange.md)

  > [`uString.removeVisual`](./removeVisual.md)

  > [`uString.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>