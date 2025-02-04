# [←](../Bytes.md) `Bytes`.`equals`

> Checks if two arrays are equal.

```zig
pub fn equals(a: []const u8, b: []const u8) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                  |
    | --------- | ------------ | ---------------------------- |
    | `a`       | `[]const u8` | The first value to compare.  |
    | `b`       | `[]const u8` | The second value to compare. |

- #### ✨ Returns : `bool`

    > Returns true if the `a` is equal to `b`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    ```

    ```zig
    _ = Bytes.equals("", "");   // 👉 true
    _ = Bytes.equals("", "b");  // 👉 false
    _ = Bytes.equals("a", "b"); // 👉 false
    _ = Bytes.equals("a", "a"); // 👉 true
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.isEmpty`](./isEmpty.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>