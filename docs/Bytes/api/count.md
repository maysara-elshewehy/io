# [←](../Bytes.md) `Bytes`.`count`

> Returns the number of bytes in the `input` array, stops at the first 0 byte, or at the size.

```zig
pub fn count(_it: Types.cbytes) Types.len
```


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `Types.cbytes`

        > The input to count.


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Types.len`

    > Returns the number of bytes in the `_it` array.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    ```zig
    _ = Bytes.count("");            // 👉 0
    _ = Bytes.count("Hello 🌍!");   // 👉 11
    ```

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.clone`](./clone.md)

  > [`Bytes.make`](./make.md)

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>