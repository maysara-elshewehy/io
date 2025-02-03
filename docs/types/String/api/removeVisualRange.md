# [←](../String.md) `String`.`removeVisualRange`

> Removes a `range` of bytes from the `String` instance by the `visual position`.

```zig
pub fn removeVisualRange(self: *Self, pos: usize, len: usize) removeVisualError![]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                                     |
    | --------- | ------- | ----------------------------------------------- |
    | `self`    | `*Self` | The `String` instance.                          |
    | `pos`     | `usize` | The visual position of the character to remove. |
    | `len`     | `usize` | The length to remove.                           |

- #### 🚫 Errors

    | Error             | Reason                                              |
    | ----------------- | --------------------------------------------------- |
    | `InvalidPosition` | The `pos` is invalid.                               |
    | `OutOfRange`      | The `pos` is greater than `String` instance length. |

- #### ✨ Returns : `[]const u8`

    > Returns the removed slice.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try string.removeVisualRange(6, 1); // 👉 (👨‍🏭), "Hello !"
        _ = try string.removeVisualRange(0, 1); // 👉 (H), "ello !"
        _ = try string.removeVisualRange(5, 1); // 👉 (!), "ello "
        _ = try string.removeVisualRange(3, 1); // 👉 (o), "ell "
        _ = try string.removeVisualRange(1, 1); // 👉 (l), "el "
        _ = try string.removeVisualRange(0, 1); // 👉 (e), "l "
        _ = try string.removeVisualRange(0, 1); // 👉 (l), " "
        _ = try string.removeVisualRange(0, 1); // 👉 ( ), ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.removeVisualRange(1, 1); // 👉 error.OutOfRange
        ```

        > **_InvalidPosition._**

        ```zig
        var string = try String.init(allocator, "👨‍🏭");
        defer string.deinit();

        _ = string.removeVisualRange(2, 1); // 👉 error.InvalidPosition
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.remove`](./remove.md)

  > [`String.removeRange`](./removeRange.md)

  > [`String.removeVisual`](./removeVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>