# [←](../String.md) `String`.`includes`

> Returns `true` **if contains `target`**.

```zig
pub fn includes(self: Self, target: []const u8) bool
```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description              |
    | --------- | ------------ | ------------------------ |
    | `self`    | `Self`       | The `String` instance.   |
    | `target`  | `[]const u8` | The value to search for. |

- #### ✨ Returns : `bool`

    > Returns `true` **if the `String` instance contains `target`**.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    const string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    ```zig
    _ = string.includes("H");   // 👉 true
    _ = string.includes("👨‍🏭");  // 👉 true
    _ = string.includes("@");   // 👉 false
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.startsWith`](./startsWith.md)

  > [`String.endsWith`](./endsWith.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>