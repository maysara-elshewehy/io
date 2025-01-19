# [←](../bytes.md) `Bytes`.`find`

> Finds the **real position** of the **first** occurrence of `value`.

```zig
pub fn find(dest: []const u8, target: []const u8) ?usize
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                             |
    | --------- | ------------ | --------------------------------------- |
    | `dest`    | `[]const u8` | The destination slice where the search occurs. |
    | `target`  | `[]const u8` | The value to search for.      |

- #### ✨ Returns : `?usize`

    > Returns the position of the **first occurrence** of `target` in `dest`. If not found, returns `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    const array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = Bytes.find(&array, "H");  // 👉 0
    _ = Bytes.find(&array, "e");  // 👉 1
    _ = Bytes.find(&array, "l");  // 👉 2 (first occurrence)
    _ = Bytes.find(&array, "o");  // 👉 4
    _ = Bytes.find(&array, " ");  // 👉 5
    _ = Bytes.find(&array, "👨‍🏭"); // 👉 6
    _ = Bytes.find(&array, "!");  // 👉 17
    _ = Bytes.find(&array, "@");  // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.rfind`](./rfind.md)

  > [`Bytes.findVisual`](./findVisual.md)

  > [`Bytes.rfindVisual`](./rfindVisual.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>