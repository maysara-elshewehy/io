# [←](../Bytes.md) `Bytes`.`endsWith`

> Returns `true` **if `dest` ends with `target`**.

```zig
pub fn endsWith(dest: []const u8, target: []const u8) bool
```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                             |
    | --------- | ------------ | --------------------------------------- |
    | `dest`    | `[]const u8` | The destination slice where the search occurs. |
    | `target`  | `[]const u8` | The value to search for.      |

- #### ✨ Returns : `bool`

    > Returns `true` **if `dest` ends with `target`**.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    const array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = Bytes.endsWith(&array, "!");   // 👉 true
    _ = Bytes.endsWith(&array, "👨‍🏭");  // 👉 false
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.includes`](./includes.md)

  > [`Bytes.startsWith`](./startsWith.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>