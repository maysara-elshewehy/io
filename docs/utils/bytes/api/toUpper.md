# [←](../bytes.md) `Bytes`.`toUpper`

> Converts all (ASCII) letters to uppercase.

```zig
pub fn toUpper(value: []u8) void
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description           |
    | --------- | ------ | --------------------- |
    | `value`   | `[]u8` | The value to convert. |

- #### ✨ Returns : `void`

    > Modifies the `value` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    var array = try Bytes.init(18, "HeLLo 👨‍🏭!");
    ```

    ```zig
    Bytes.toUpper(&array); // 👉 "HELLO 👨‍🏭!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.toLower`](./toLower.md)

  > [`Bytes.toTitle`](./toTitle.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>