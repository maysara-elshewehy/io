# [←](../uString.md) `uString`.`allocatedSlice`

> Returns a slice representing the entire allocated memory range.

```zig
pub fn allocatedSlice(self: Self) []const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description             |
    | --------- | ------ | ----------------------- |
    | `self`    | `Self` | The `uString` instance. |

- #### ✨ Returns : `[]const u8`

    > Returns a slice representing the entire allocated memory range.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, &[_]u8{ '1', 0, 0 });
    defer string.deinit(allocator);
    ```

    ```zig
    _ = string.slice();          // 👉 { '1' }
    _ = string.allocatedSlice(); // 👉 { '1', 0, 0, 0xAA, 0xAA, 0xAA }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.slice`](./slice.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>