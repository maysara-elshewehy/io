# [←](../Buffer.md) `Buffer`.`len`

> Returns the number of _(`bytes` / `characters`)_ in the buffer.

```zig
pub fn len(_self: Self) Types.len
```


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The `Buffer` structure to handle.


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Types.len`

    > Returns the number of bytes in the buffer.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    ```zig
    _ = Buffer.clone("Hello 🌍!").len();            // 👉 11

    _ = try Buffer.makeWith(64, "Hello 🌍!").len();   // 👉 11
    ```

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Buffer.size`](./size.md)

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>