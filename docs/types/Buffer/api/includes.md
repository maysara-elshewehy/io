# [←](../Buffer.md) `Buffer`.`includes`

> Returns `true` **if contains `target`**.

```zig
pub fn includes(self: Self, target: []const u8) bool
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `Buffer` instance.   |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `bool`

    > Returns `true` **if the `Buffer` instance contains `target`**.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.includes("H");   // 👉 true
    _ = buffer.includes("👨‍🏭");  // 👉 true
    _ = buffer.includes("@");   // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.startsWith`](./startsWith.md)

  > [`Buffer.endsWith`](./endsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>