# [←](../Bytes.md) `Bytes`.`startsWith`

> Returns `true` **if `dest` starts with `target`**.

```zig
pub fn startsWith(dest: []const u8, target: []const u8) bool
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                             |
    | --------- | ------------ | --------------------------------------- |
    | `dest`    | `[]const u8` | The destination slice where the search occurs. |
    | `target`  | `[]const u8` | The value to search for.      |

- #### ✨ Returns : `bool`

    > Returns `true` **if `dest` starts with `target`**.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = Bytes.startsWith(&array, "H");   // 👉 true
    _ = Bytes.startsWith(&array, "👨‍🏭");  // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.includes`](./includes.md)

  > [`Bytes.endsWith`](./endsWith.md)


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>