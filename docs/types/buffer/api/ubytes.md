# [←](../readme.md) `io`.`types`.`buffer`.`ubytes`

> Returns the number of characters in the string (Unicode characters are counted as regular characters).

```zig
pub fn ubytes(_self: Self) types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string structure to be used.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    > The number of characters in the string (Unicode characters are counted as regular characters).

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").utils.string;
    ```

    ```zig
    var buf = chars.make(64, null);
    var str = buffer(&buf);

    _ = str.ubytes(); // 👉 0

    str.append("Hello 🌍!");

    _ = str.ubytes(); // 👉 8
    ```



<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.bytes`](./bytes.md)

  > [`io.types.buffer.size`](./size.md)

  > [`io.types.buffer.src`](./src.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>