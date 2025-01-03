# [←](../Bytes.md) `Bytes`.`toByte`

> Safely casts the `input` value to a [`byte`](../#types).

```zig
pub fn toByte(_input: anytype) !Types.byte
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_input` : `anytype`

        > The input to check.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!Types.byte`

    > Returns `error.OutOfRange` _if the value is out of range_.

    > Returns `error.InvalidType` _if the type is invalid_.

    > Returns the value casted to `Types.byte`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    ```zig
    _ = try Bytes.toByte(0);    // 👉 0
    _ = try Bytes.toByte(255);  // 👉 255

    _ = try Bytes.toByte(256);  // 👉 error.OutOfRange
    _ = try Bytes.toByte(-1);   // 👉 error.OutOfRange

    _ = try Bytes.toByte(true); // 👉 error.InvalidType
    _ = try Bytes.toByte(".."); // 👉 error.InvalidType
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.isByte`](./isByte.md)

  > [`Bytes.isBytes`](./isBytes.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>