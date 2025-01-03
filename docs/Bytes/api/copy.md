# [←](../Bytes.md) `Bytes`.`clone`

> Copies the `input` bytes into `another` array.

```zig
pub fn copy(_to: Types.bytes, _from: Types.cbytes) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_to` : `Types.bytes`

        > An array that will be filled with the bytes of `_from`.

    - `_from` : `Types.cbytes`

        > The array whose bytes are copied.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void`

    > Modifies `_to` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    > Empty value

    ```zig
    _ = Bytes.clone("");            // 👉 "", size: 0
    ```

    > Non-Empty value

    ```zig
    _ = Bytes.clone("Hello 🌍!");   // 👉 "Hello 🌍!", size: 11
    ```

    > Constant array of bytes.

    ```zig
    const src = "Hello 🌍!";
    _ = Bytes.clone(src);           // 👉 "Hello 🌍!", size: 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.clone`](./clone.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>