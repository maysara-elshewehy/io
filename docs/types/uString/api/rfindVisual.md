# [←](../uString.md) `uString`.`rfindVisual`

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
    | `self`    | `Self`       | The `uString` instance.  |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **last occurrence** of `target` in the `uString` instance, If not found, returns `null`.

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
    _ = string.rfindVisual("H");  // 👉 0
    _ = string.rfindVisual("e");  // 👉 1
    _ = string.rfindVisual("l");  // 👉 3 (last occurrence)
    _ = string.rfindVisual("o");  // 👉 4
    _ = string.rfindVisual(" ");  // 👉 5
    _ = string.rfindVisual("👨‍🏭"); // 👉 6
    _ = string.rfindVisual("!");  // 👉 7
    _ = string.rfindVisual("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.find`](./find.md)

  > [`uString.rfind`](./rfind.md)

  > [`uString.findVisual`](./findVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>