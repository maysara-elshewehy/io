# [←](../Buffer.md) `Buffer`.`removeVisual`

> Removes a byte from the `Buffer` instance by the `visual position`.

```zig
pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                                     |
    | --------- | ------- | ----------------------------------------------- |
    | `self`    | `*Self` | The `Buffer` instance.                          |
    | `pos`     | `usize` | The visual position of the character to remove. |

- #### 🚫 Errors

    | Error             | Reason                                              |
    | ----------------- | --------------------------------------------------- |
    | `InvalidPosition` | The `pos` is invalid.                               |
    | `OutOfRange`      | The `pos` is greater than `Buffer` instance length. |

- #### ✨ Returns : `[]const u8`

    > Returns the removed slice.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try buffer.removeVisual(6); // 👉 (👨‍🏭), "Hello !"
        _ = try buffer.removeVisual(0); // 👉 (H), "ello !"
        _ = try buffer.removeVisual(5); // 👉 (!), "ello "
        _ = try buffer.removeVisual(3); // 👉 (o), "ell "
        _ = try buffer.removeVisual(1); // 👉 (l), "el "
        _ = try buffer.removeVisual(0); // 👉 (e), "l "
        _ = try buffer.removeVisual(0); // 👉 (l), " "
        _ = try buffer.removeVisual(0); // 👉 ( ), ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = buffer.removeVisual(1); // 👉 error.OutOfRange
        ```

        > **_InvalidPosition._**

        ```zig
        var buffer = try Buffer.init(11, "👨‍🏭");
        _ = buffer.removeVisual(2); // 👉 error.InvalidPosition
        ```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.remove`](./remove.md)

  > [`Buffer.removeRange`](./removeRange.md)

  > [`Buffer.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>