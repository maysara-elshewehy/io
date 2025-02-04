# [←](../Viewer.md) `Viewer`.`find`

> Finds the `position` of the **first** occurrence of `target`.

```zig
pub fn find(self: Self, target: []const u8) ?usize
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

    > Returns the position of the **first occurrence** of `target` in the `Viewer` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewer = Viewer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = viewer.find("H");  // 👉 0
    _ = viewer.find("e");  // 👉 1
    _ = viewer.find("l");  // 👉 2 (first occurrence)
    _ = viewer.find("o");  // 👉 4
    _ = viewer.find(" ");  // 👉 5
    _ = viewer.find("👨‍🏭"); // 👉 6
    _ = viewer.find("!");  // 👉 17
    _ = viewer.find("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.rfind`](./rfind.md)

  > [`Viewer.findVisual`](./findVisual.md)

  > [`Viewer.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>