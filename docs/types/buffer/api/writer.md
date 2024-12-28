# [←](../readme.md) `io`.`types`.`buffer`.`writer`

> Returns a writer for the string.

```zig
pub fn writer(_self: *Self) writer
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : [`Writer`](./Writer_t.md)

    > A writer for the string.

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

    var writer = str.writer();
    try writer.print("Hello {s}!", .{"🌍"});  // 👉 "Hello 🌍!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

    > [`io.types.buffer.writer (Type)`](./Writer_t.md)

    > [`io.types.buffer.write`](./write.md)

    > [`io.types.buffer.writeStart`](./writeStart.md)

    > [`io.types.buffer.writeAt`](./writeAt.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>