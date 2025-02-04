# [←](../String.md) `String`.`remove`

> Removes a byte from the `String` instance.

```zig
pub fn remove(self: *Self, pos: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                         |
    | --------- | ------- | ----------------------------------- |
    | `self`    | `*Self` | The `String` instance.              |
    | `pos`     | `usize` | The position of the byte to remove. |

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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.removeRange`](./removeRange.md)

  > [`String.removeVisual`](./removeVisual.md)

  > [`String.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>