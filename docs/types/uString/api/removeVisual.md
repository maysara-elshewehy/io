# [←](../uString.md) `uString`.`removeVisual`

> Removes a byte from the `uString` instance by the `visual position`.

```zig
pub fn removeVisual(self: *Self, pos: usize) removeVisualError![]const u8
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                                     |
    | --------- | ------- | ----------------------------------------------- |
    | `self`    | `*Self` | The `uString` instance.                         |
    | `pos`     | `usize` | The visual position of the character to remove. |

- #### 🚫 Errors

    | Error             | Reason                                               |
    | ----------------- | ---------------------------------------------------- |
    | `InvalidPosition` | The `pos` is invalid.                                |
    | `OutOfRange`      | The `pos` is greater than `uString` instance length. |

- #### ✨ Returns : `[]const u8`

    > Returns the removed slice.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try string.removeVisual(6); // 👉 (👨‍🏭), "Hello !"
        _ = try string.removeVisual(0); // 👉 (H), "ello !"
        _ = try string.removeVisual(5); // 👉 (!), "ello "
        _ = try string.removeVisual(3); // 👉 (o), "ell "
        _ = try string.removeVisual(1); // 👉 (l), "el "
        _ = try string.removeVisual(0); // 👉 (e), "l "
        _ = try string.removeVisual(0); // 👉 (l), " "
        _ = try string.removeVisual(0); // 👉 ( ), ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.removeVisual(1); // 👉 error.OutOfRange
        ```

        > **_InvalidPosition._**

        ```zig
        var string = try uString.init(allocator, "👨‍🏭");
        defer string.deinit(allocator);

        _ = string.removeVisual(2); // 👉 error.InvalidPosition
        ```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.remove`](./remove.md)

  > [`uString.removeRange`](./removeRange.md)

  > [`uString.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>