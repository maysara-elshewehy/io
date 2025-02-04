# [←](../Buffer.md) `Buffer`.`equals`

> Returns true if the `Buffer` instance equals the given `target`.

```zig
pub fn equals(self: Self, target: []const u8) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                 |
    | --------- | ------------ | --------------------------- |
    | `self`    | `Self`       | The `Buffer` instance.      |
    | `target`  | `[]const u8` | The string to compare with. |

- #### ✨ Returns : `bool`

    > Returns true if the `Buffer` instance is equal to `target`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const bufferA = try Buffer.init(64, "A");
    const bufferB = try Buffer.init(32, "B");
    ```

    ```zig
    _ = bufferA.equals(bufferA.m_source[0..bufferA.m_length]);  // 👉 true
    _ = bufferA.equals(bufferB.m_source[0..bufferB.m_length]);  // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.isEmpty`](./isEmpty.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>