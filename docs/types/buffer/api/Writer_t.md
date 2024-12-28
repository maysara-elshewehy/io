# [←](../readme.md) `io`.`types`.`buffer`.`Writer`

> The underlying type of the Writer returned by `writer()`.

```zig
pub const Writer = std.io.Writer(*Self, anyerror, write);
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `self` : `*Self`

        > The string structure to be used.
    - `anyerror` : `anyerror`

        > The error type of the Writer.

    - `write` : `write`

        > The write function of the Writer.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var buf = chars.make(64, null);
    var str = buffer(&buf);

    var writer : str.Writer = str.writer();
    try writer.print("Hello {s}!", .{"🌍"});  // 👉 "Hello 🌍!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

    > [`io.types.buffer.writer`](./writer.md)

    > [`io.types.buffer.write`](./write.md)

    > [`io.types.buffer.writeStart`](./writeStart.md)

    > [`io.types.buffer.writeAt`](./writeAt.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>