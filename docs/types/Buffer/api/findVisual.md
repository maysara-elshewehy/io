# [←](../Buffer.md) `Buffer`.`findVisual`

> Finds the **visual position** of the **first** occurrence of `value`.

```zig
pub fn findVisual(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                        |
    | --------- | ------------ | ---------------------------------- |
    | `self`    | `Self`       | The `Buffer` instance.             |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **first occurrence** of `target` in the `Buffer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.findVisual("H");  // 👉 0
    _ = buffer.findVisual("e");  // 👉 1
    _ = buffer.findVisual("l");  // 👉 2 (first occurrence)
    _ = buffer.findVisual("o");  // 👉 4
    _ = buffer.findVisual(" ");  // 👉 5
    _ = buffer.findVisual("👨‍🏭"); // 👉 6
    _ = buffer.findVisual("!");  // 👉 7
    _ = buffer.findVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.find`](./find.md)

  > [`Buffer.rfind`](./rfind.md)

  > [`Buffer.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>