# [←](../readme.md) `io`.`types`.`string`.`Writer`

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
    - `Error` : `Error`

        > The error type of the Writer.

    - `write` : `write`

        > The write function of the Writer.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init(alloc);
    defer str.deinit();

    var writer : str.Writer = str.writer();
    try writer.print("Hello {s}!", .{"🌍"});  // 👉 "Hello 🌍!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

    > [`io.types.string.writer`](./writer.md)

    > [`io.types.string.write`](./write.md)

    > [`io.types.string.writeStart`](./writeStart.md)

    > [`io.types.string.writeAt`](./writeAt.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>