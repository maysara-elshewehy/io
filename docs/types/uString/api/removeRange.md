# [←](../uString.md) `uString`.`removeRange`

> Removes a `range` of bytes from the `uString` instance.

```zig
pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `uString` instance.             |
    | `pos`     | `usize` | The position of the byte to remove. |
    | `len`     | `usize` | The length to remove.               |

- #### 🚫 Errors

    | Error        | Reason                                               |
    | ------------ | ---------------------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `uString` instance length. |

- #### ✨ Returns : `void`

    > Modifies `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello !");
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.removeRange(0, 1); // 👉 "ello !"
        try string.removeRange(5, 1); // 👉 "ello "
        try string.removeRange(3, 1); // 👉 "ell "
        try string.removeRange(1, 1); // 👉 "el "
        try string.removeRange(0, 1); // 👉 "l "
        try string.removeRange(0, 1); // 👉 " "
        try string.removeRange(0, 1); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.removeRange(1, 1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.remove`](./remove.md)

  > [`uString.removeVisual`](./removeVisual.md)

  > [`uString.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>