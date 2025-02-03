# [←](../Bytes.md) `Bytes`.`toTitle`

> Converts all (ASCII) letters to titlecase.

```zig
pub fn toTitle(value: []u8) void
```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description           |
    | --------- | ------ | --------------------- |
    | `value`   | `[]u8` | The value to convert. |

- #### ✨ Returns : `void`

    > Modifies the `value` in place.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(18, "heLLo 👨‍🏭!");
    ```

    ```zig
    Bytes.toTitle(&array); // 👉 "Hello 👨‍🏭!"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.toLower`](./toLower.md)

  > [`Bytes.toUpper`](./toUpper.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>