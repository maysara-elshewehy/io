# [←](../Bytes.md) `Bytes`.`removeVisual`

> Removes a byte from the `dest` by the `visual position`.

```zig
pub fn removeVisual(dest: []u8, dest_wlen: usize, pos: usize) removeVisualError![]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                                     |
    | ----------- | ------- | ----------------------------------------------- |
    | `dest`      | `[]u8`  | The destination to remove from.                 |
    | `dest_wlen` | `usize` | The write length of `dest`.                     |
    | `pos`       | `usize` | The visual position of the character to remove. |

- #### 🚫 Errors

    | Error             | Reason                                 |
    | ----------------- | -------------------------------------- |
    | `InvalidPosition` | The `pos` is invalid.                  |
    | `OutOfRange`      | The `pos` is greater than `dest_wlen`. |

- #### ✨ Returns : `[]const u8`

    > Returns the removed slice.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Bytes.removeVisual(&array, 18, 6); // 👉 (👨‍🏭), "Hello !"
        _ = try Bytes.removeVisual(&array,  7, 0); // 👉 (H), "ello !"
        _ = try Bytes.removeVisual(&array,  6, 5); // 👉 (!), "ello "
        _ = try Bytes.removeVisual(&array,  5, 3); // 👉 (o), "ell "
        _ = try Bytes.removeVisual(&array,  4, 1); // 👉 (l), "el "
        _ = try Bytes.removeVisual(&array,  3, 0); // 👉 (e), "l "
        _ = try Bytes.removeVisual(&array,  2, 0); // 👉 (l), " "
        _ = try Bytes.removeVisual(&array,  1, 0); // 👉 ( ), ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.removeVisual(&array, 0, 1); // 👉 error.OutOfRange
        ```

        > **_InvalidPosition._**

        ```zig
        var array = try Bytes.init(11, "👨‍🏭");
        _ = Bytes.removeVisual(&array, 11, 2); // 👉 error.InvalidPosition
        ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.remove`](./remove.md)

  > [`Bytes.removeRange`](./removeRange.md)

  > [`Bytes.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>