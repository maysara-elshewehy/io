# [←](../Buffer.md) `Buffer`.`instant`

> Creates a buffer and copies the bytes into it.

```zig
pub fn instant(comptime _it: Types.cbytes) Buffer(Types.byte, _it.len)
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime _it` : `Types.cbytes`

        > The input to instant.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Buffer(Types.byte, _it.len)`

    > A new `Buffer` with `_it.len` as the size, initialized with the contents of `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    > Empty value

    ```zig
    _ = Buffer.instant("");            // 👉 "", size: 0
    ```

    > Non-Empty value

    ```zig
    _ = Buffer.instant("Hello 🌍!");   // 👉 "Hello 🌍!", size: 11
    ```

    > Constant array of bytes.

    ```zig
    const src = "Hello 🌍!";
    _ = Buffer.instant(src);           // 👉 "Hello 🌍!", size: 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.initWith`](./initWith.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>