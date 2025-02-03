# [←](../Bytes.md) `Bytes`.`removeVisualRange`

> Removes a `range` of bytes from the `dest` by the `visual position`.

```zig
pub fn removeVisualRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeVisualError![]const u8
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
    | `len`       | `usize` | The length to remove.                           |

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
        _ = try Bytes.removeVisualRange(&array, 18, 6, 1); // 👉 (👨‍🏭), "Hello !"
        _ = try Bytes.removeVisualRange(&array,  7, 0, 1); // 👉 (H), "ello !"
        _ = try Bytes.removeVisualRange(&array,  6, 5, 1); // 👉 (!), "ello "
        _ = try Bytes.removeVisualRange(&array,  5, 3, 1); // 👉 (o), "ell "
        _ = try Bytes.removeVisualRange(&array,  4, 1, 1); // 👉 (l), "el "
        _ = try Bytes.removeVisualRange(&array,  3, 0, 1); // 👉 (e), "l "
        _ = try Bytes.removeVisualRange(&array,  2, 0, 1); // 👉 (l), " "
        _ = try Bytes.removeVisualRange(&array,  1, 0, 1); // 👉 ( ), ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.removeVisualRange(&array, 0, 1, 1); // 👉 error.OutOfRange
        ```

        > **_InvalidPosition._**

        ```zig
        var array = try Bytes.init(11, "👨‍🏭");
        _ = Bytes.removeVisualRange(&array, 11, 2, 1); // 👉 error.InvalidPosition
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.remove`](./remove.md)

  > [`Bytes.removeRange`](./removeRange.md)

  > [`Bytes.removeVisual`](./removeVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>