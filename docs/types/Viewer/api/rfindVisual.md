# [←](../Viewer.md) `Viewer`.`rfindVisual`

> Finds the `visual position` of the **last** occurrence of `target`.

```zig
pub fn rfindVisual(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `Viewer` instance.   |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **last occurrence** of `target` in the `Viewer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewer = Viewer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = viewer.rfindVisual("H");  // 👉 0
    _ = viewer.rfindVisual("e");  // 👉 1
    _ = viewer.rfindVisual("l");  // 👉 3 (last occurrence)
    _ = viewer.rfindVisual("o");  // 👉 4
    _ = viewer.rfindVisual(" ");  // 👉 5
    _ = viewer.rfindVisual("👨‍🏭"); // 👉 6
    _ = viewer.rfindVisual("!");  // 👉 7
    _ = viewer.rfindVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.find`](./find.md)

  > [`Viewer.rfind`](./rfind.md)

  > [`Viewer.findVisual`](./findVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>