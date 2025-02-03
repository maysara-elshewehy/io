# [←](../Viewer.md) `Viewer`.`findVisual`

> Finds the `visual position` of the **first** occurrence of `target`.

```zig
pub fn findVisual(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `Viewer` instance.   |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **first occurrence** of `target` in the `Viewer` instance, If not found, returns `null`.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewer = Viewer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = viewer.findVisual("H");  // 👉 0
    _ = viewer.findVisual("e");  // 👉 1
    _ = viewer.findVisual("l");  // 👉 2 (first occurrence)
    _ = viewer.findVisual("o");  // 👉 4
    _ = viewer.findVisual(" ");  // 👉 5
    _ = viewer.findVisual("👨‍🏭"); // 👉 6
    _ = viewer.findVisual("!");  // 👉 7
    _ = viewer.findVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.find`](./find.md)

  > [`Viewer.rfind`](./rfind.md)

  > [`Viewer.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>