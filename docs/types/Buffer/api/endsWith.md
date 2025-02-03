# [←](../Buffer.md) `Buffer`.`endsWith`

> Returns `true` **if ends with `target`**.

```zig
pub fn endsWith(self: Self, target: []const u8) bool
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

    > Returns `true` **if the `Buffer` instance ends with `target`**.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    const buffer = try Buffer.init("Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.endsWith("!");   // 👉 true
    _ = buffer.endsWith("👨‍🏭");  // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.includes`](./includes.md)

  > [`Buffer.startsWith`](./startsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>