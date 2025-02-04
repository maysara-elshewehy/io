# [←](../uString.md) `uString`.`findVisual`

> Finds the `visual position` of the **first** occurrence of `target`.

```zig
pub fn findVisual(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `uString` instance.  |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **first occurrence** of `target` in the `uString` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    ```zig
    _ = string.findVisual("H");  // 👉 0
    _ = string.findVisual("e");  // 👉 1
    _ = string.findVisual("l");  // 👉 2 (first occurrence)
    _ = string.findVisual("o");  // 👉 4
    _ = string.findVisual(" ");  // 👉 5
    _ = string.findVisual("👨‍🏭"); // 👉 6
    _ = string.findVisual("!");  // 👉 7
    _ = string.findVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.find`](./find.md)

  > [`uString.rfind`](./rfind.md)

  > [`uString.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>