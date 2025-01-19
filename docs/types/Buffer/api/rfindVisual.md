# [←](../Buffer.md) `Buffer`.`rfindVisual`

> Finds the **visual position** of the **last** occurrence of `value`.

```zig
pub fn rfindVisual(self: Self, target: []const u8) ?usize
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

    > Returns the visual position of the **last occurrence** of `target` in the `Buffer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.rfindVisual("H");  // 👉 0
    _ = buffer.rfindVisual("e");  // 👉 1
    _ = buffer.rfindVisual("l");  // 👉 3 (last occurrence)
    _ = buffer.rfindVisual("o");  // 👉 4
    _ = buffer.rfindVisual(" ");  // 👉 5
    _ = buffer.rfindVisual("👨‍🏭"); // 👉 6
    _ = buffer.rfindVisual("!");  // 👉 7
    _ = buffer.rfindVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.find`](./find.md)

  > [`Buffer.rfind`](./rfind.md)

  > [`Buffer.findVisual`](./findVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>