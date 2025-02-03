# [←](../Bytes.md) `Bytes`.`rfindVisual`

> Finds the `visual position` of the **last** occurrence of `target`.

```zig
pub fn rfindVisual(dest: []const u8, target: []const u8) ?usize
```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                                    |
    | --------- | ------------ | ---------------------------------------------- |
    | `dest`    | `[]const u8` | The destination slice where the search occurs. |
    | `target`  | `[]const u8` | The value to search for.                       |

- #### ✨ Returns : `?usize`

    > Returns the visual position of the **last occurrence** of `target` in `dest`. If not found, returns `null`.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = Bytes.rfindVisual(&array, "H");  // 👉 0
    _ = Bytes.rfindVisual(&array, "e");  // 👉 1
    _ = Bytes.rfindVisual(&array, "l");  // 👉 3 (last occurrence)
    _ = Bytes.rfindVisual(&array, "o");  // 👉 4
    _ = Bytes.rfindVisual(&array, " ");  // 👉 5
    _ = Bytes.rfindVisual(&array, "👨‍🏭"); // 👉 6
    _ = Bytes.rfindVisual(&array, "!");  // 👉 7 (rfind(..) returns 17 instead)
    _ = Bytes.rfindVisual(&array, "@");  // 👉 null
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.find`](./find.md)

  > [`Bytes.rfind`](./rfind.md)

  > [`Bytes.findVisual`](./findVisual.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>