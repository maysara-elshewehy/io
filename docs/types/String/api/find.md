# [←](../String.md) `String`.`find`

> Finds the **real position** of the **first** occurrence of `value`.

```zig
pub fn find(self: Self, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                        |
    | --------- | ------------ | ---------------------------------- |
    | `self`    | `Self`       | The `String` instance.             |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `?usize`

    > Returns the position of the **first occurrence** of `target` in the `String` instance, If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    const string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    ```zig
    _ = string.find("H");  // 👉 0
    _ = string.find("e");  // 👉 1
    _ = string.find("l");  // 👉 2 (first occurrence)
    _ = string.find("o");  // 👉 4
    _ = string.find(" ");  // 👉 5
    _ = string.find("👨‍🏭"); // 👉 6
    _ = string.find("!");  // 👉 17
    _ = string.find("@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.rfind`](./rfind.md)

  > [`String.findVisual`](./findVisual.md)

  > [`String.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>