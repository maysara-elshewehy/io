# [←](../Buffer.md) `Buffer`.`initWith`

> Creates a buffer of the specified size and copies the value into it.

```zig
pub fn initWith(comptime _size: Types.len, _it: anytype) !Buffer(Types.byte, _size)
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime _size` : `Types.len`

        > The specified size of the Buffer.

    - `_it` : `Types.cbytes` or `Types.byte` or `Buffer`

        > The input to copy.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!Buffer(Types.byte, _size)`

    > **[`Bytes.initWith`](../../Bytes/api/initWith.md) is used internally, check it out for more information about errors.**

    > A new `Buffer` with specified size, initialized with the contents of `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    > Empty Buffer

    ```zig
    _ = try Buffer.initWith(64, "");           // 👉 error.ZeroValue
    ```

    > Non-Empty Buffer

    ```zig
    _ = try Buffer.initWith(64, "Hello 🌍!");  // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Constant Buffer.

    ```zig
    const src = "Hello 🌍!";
    _ = try Buffer.initWith(64, src);          // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Mutable Buffer.

    ```zig
    var src = "Hello 🌍!";
    _ = try Buffer.initWith(64, src[0..]);     // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Length exceeds size.

    ```zig
    _ = try Buffer.initWith(1, "122");         // 👉 error.OutOfRange
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.instant`](./instant.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>