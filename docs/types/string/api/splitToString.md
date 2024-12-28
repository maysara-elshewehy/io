# [←](../readme.md) `io`.`types`.`string`.`splitToString`

> Returns a slice of the `io.types.string` split by the separator _(`string` or `char`)_ at the specified position, or null if failed.

```zig
pub inline fn splitToString(_self: Self, _sep: anytype, index: usize) !?Self
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string structure to be used.

    - `_sep` : `types.cstr` or `types.char` or `Self`

        > The separator to split with.

    - `_pos` : `types.unsigned`

        > The position to split at.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `anyerror` or `null` or `Self`

    > The resulting slice of the string split by the separator at the specified position as a `string`, or `null` or `anyerror` if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example


    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(",1,,2,,3,");
    defer str.deinit();

    const r1 = try str.splitToString(',', 0).?;  // r1.src() 👉 ""
    const .. = try str.splitToString(',', 1).?;  // ...src() 👉 "1"
    const .. = try str.splitToString(',', 2).?;  // ...src() 👉 ""
    const .. = try str.splitToString(',', 3).?;  // ...src() 👉 "2"
    const .. = try str.splitToString(',', 5).?;  // ...src() 👉 "3"
    const .. = try str.splitToString(',', 6).?;  // ...src() 👉 ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.splitAllToStrings`](./splitAllToStrings.md)

  > [`io.types.string.split`](./split.md)

  > [`io.types.string.splitAll`](./splitAll.md)

  > [`io.types.string.lines`](./lines.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>