# [←](../Buffer.md) `Buffer`.`init`

> Creates a buffer of the specified size.

```zig
pub fn init(comptime _size: Types.len) !Buffer(Types.byte, _size)
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime _size` : `Types.len`

        > The specified size of the buffer.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!Buffer(Types.byte, _size)`

    > **[`Bytes.init`](../../Bytes/api/init.md) is used internally, check it out for more information about errors.**

    > A new `Buffer` with specified size, initialized with `0`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    ```zig
    _ = try Buffer.init(0);  // 👉 error.ZeroValue
    ```

    ```zig
    _ = try Buffer.init(64); // 👉 "", size: 64, len: 0
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Buffer.initWith`](./initWith.md)

  > [`Buffer.instant`](./instant.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>