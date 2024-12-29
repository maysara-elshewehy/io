# [←](../readme.md) `io`.`types`.`string`.`splitAllToStrings`

> Returns an array of slices of the `io.types.string` split by the separator _(`string` or `char`)_.

```zig
pub inline fn splitAllToStrings(_self: Self, _sep: anytype) Error![]Self
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string structure to be used.

    - `_sep` : `types.cstr` or `types.char` or `Self`

        > The separator to split with.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Error` or `[]Self`

    > An array of slices of the _(`string` type)_ split by the separator, or `Error` if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example


    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(alloc, ",1,,2,,3,");
    defer str.deinit();

    const res = try str.splitAllToStrings(',');

    res.len;        // 👉 7
    res[0].src();   // 👉 ""
    res[1].src();   // 👉 "1"
    res[2].src();   // 👉 ""
    res[3].src();   // 👉 "2"
    res[4].src();   // 👉 ""
    res[5].src();   // 👉 "3"
    res[6].src();   // 👉 ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.splitToString`](./splitToString.md)

  > [`io.types.string.split`](./split.md)

  > [`io.types.string.splitAll`](./splitAll.md)

  > [`io.types.string.lines`](./lines.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>