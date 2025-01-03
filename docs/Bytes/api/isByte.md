# [←](../Bytes.md) `Bytes`.`isByte`

> Returns `true` if the type of `input` is a [`byte`](../#types).

```zig
pub fn isByte(_input: anytype) bool
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

- #### Returns : `bool`

    > Returns `true` if `_input` is a type [`byte`](../#types).

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    ```zig
    _ = Bytes.isByte(0);        // 👉 true
    _ = Bytes.isByte(255);      // 👉 true

    _ = Bytes.isByte(256);      // 👉 false
    _ = Bytes.isByte(-1);       // 👉 false
    ```

    ```zig
    const _u8   : u8            = 0;
    const _comp : comptime_int  = 0;
    const _rest : u7            = 0;

    _ = Bytes.isByte(_u8);      // 👉 true
    _ = Bytes.isByte(_comp);    // 👉 true (must be >= 0 and <= 255)
    _ = Bytes.isByte(_rest);    // 👉 false
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.isBytes`](./isBytes.md)

  > [`Bytes.toByte`](./toByte.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>