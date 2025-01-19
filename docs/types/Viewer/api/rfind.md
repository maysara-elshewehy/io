# [←](../Viewer.md) `Viewer`.`rfind`

> Finds the **real position** of the **last** occurrence of `value`.

```zig
pub fn rfind(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                        |
    | --------- | ------------ | ---------------------------------- |
    | `self`    | `Self`       | The `Viewer` instance.             |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the position of the **last occurrence** of `target` in the `Viewer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewer = try Viewer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = viewer.rfind("H");  // 👉 0
    _ = viewer.rfind("e");  // 👉 1
    _ = viewer.rfind("l");  // 👉 3 (last occurrence)
    _ = viewer.rfind("o");  // 👉 4
    _ = viewer.rfind(" ");  // 👉 5
    _ = viewer.rfind("👨‍🏭"); // 👉 6
    _ = viewer.rfind("!");  // 👉 17
    _ = viewer.rfind("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.find`](./find.md)

  > [`Viewer.findVisual`](./findVisual.md)

  > [`Viewer.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>