# [←](../String.md) `String`.`removeRange`

> Removes a `range` of bytes from the `String` instance.

```zig
pub fn removeRange(self: *Self, pos: usize, len: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `String` instance.              |
    | `pos`     | `usize` | The position of the byte to remove. |
    | `len`     | `usize` | The length to remove.               |

- #### 🚫 Errors

    | Error        | Reason                                              |
    | ------------ | --------------------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `String` instance length. |

- #### ✨ Returns : `void`

    > Modifies `String` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "Hello !");
    defer string.deinit();
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

  > [`String.init`](./init.md)

  > [`String.remove`](./remove.md)

  > [`String.removeVisual`](./removeVisual.md)

  > [`String.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>