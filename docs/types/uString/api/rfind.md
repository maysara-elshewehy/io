# [←](../uString.md) `uString`.`rfind`

> Finds the `position` of the **last** occurrence of `target`.

```zig
pub fn rfind(self: Self, target: []const u8) ?usize
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

    > Returns the position of the **last occurrence** of `target` in the `uString` instance, If not found, returns `null`.

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
    _ = string.rfind("H");  // 👉 0
    _ = string.rfind("e");  // 👉 1
    _ = string.rfind("l");  // 👉 3 (last occurrence)
    _ = string.rfind("o");  // 👉 4
    _ = string.rfind(" ");  // 👉 5
    _ = string.rfind("👨‍🏭"); // 👉 6
    _ = string.rfind("!");  // 👉 17
    _ = string.rfind("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.find`](./find.md)

  > [`uString.findVisual`](./findVisual.md)

  > [`uString.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>