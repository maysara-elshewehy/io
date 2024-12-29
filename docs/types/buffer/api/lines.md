# [←](../readme.md) `io`.`types`.`buffer`.`lines`

> Returns an array of slices of the string split by the separator (`\r\n` or `\n`).

```zig
pub inline fn lines(_self: Self) Error![]Self
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

- #### Returns : `Error` or `[]Self`

    > An array of slices of the string split by the (`\r\n` or `\n`), or `Error` if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example


    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var str = try string.initWith("\n1\n\n2\n\n3\n");
    defer str.deinit();

    const res = try str.lines();
    res.len;        // 👉 7
    res[0].src();   // 👉 ""
    res[1].src();   // 👉 "1"
    res[2].src();   // 👉 ""
    res[3].src();   // 👉 "2"
    res[4].src();   // 👉 ""
    res[5].src();   // 👉 "3"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.split`](./split.md)

  > [`io.types.buffer.splitAll`](./splitAll.md)

  > [`io.types.buffer.splitToString`](./splitToString.md)

  > [`io.types.buffer.splitAllToStrings`](./splitAllToStrings.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>