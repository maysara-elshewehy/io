# [←](../Bytes.md) `Bytes`.`copy`

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

    ```zig
    var str = Bytes.init(64);
    Bytes.copy(&str, "Hello  🌍!"); // 👉 "Hello 🌍!"

    _ = str.len;                    // 👉 64 (Size of array)
    _ = Bytes.count(&str);          // 👉 11 (Length of bytes written to array)
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.instant`](./instant.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>