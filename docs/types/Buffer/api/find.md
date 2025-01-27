# [←](../Buffer.md) `Buffer`.`find`

> Finds the `position` of the **first** occurrence of `target`.

```zig
pub fn find(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `Buffer` instance.   |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the position of the **first occurrence** of `target` in the `Buffer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.find("H");  // 👉 0
    _ = buffer.find("e");  // 👉 1
    _ = buffer.find("l");  // 👉 2 (first occurrence)
    _ = buffer.find("o");  // 👉 4
    _ = buffer.find(" ");  // 👉 5
    _ = buffer.find("👨‍🏭"); // 👉 6
    _ = buffer.find("!");  // 👉 17
    _ = buffer.find("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.rfind`](./rfind.md)

  > [`Buffer.findVisual`](./findVisual.md)

  > [`Buffer.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>