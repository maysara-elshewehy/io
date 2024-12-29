# [←](../readme.md) `io`.`types`.`buffer`.`split`

> Returns a slice of the string split by the separator _(`string` or `char`)_ at the specified position, or null if failed.

```zig
pub inline fn split(_self: Self, _sep: anytype, _pos: types.len) ?types.cstr
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string structure to be used.

    - `_sep` : `types.cstr` or `types.char` or `Self`

        > The separator to split with.

    - `_pos` : `types.len`

        > The position to split at.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `null` or `types.cstr`

    > The resulting slice of the string split by the separator _(`string` or `char`)_ at the specified position, or `null` if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example


    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var buf = chars.make(64, "🌍1🌍🌍2🌍🌍3🌍");
    var str = buffer(&buf);

    str.split("🌍", 0).?; // 👉 ""
    str.split("🌍", 1).?; // 👉 "1"
    str.split("🌍", 2).?; // 👉 ""
    str.split("🌍", 3).?; // 👉 "2"
    str.split("🌍", 5).?; // 👉 "3"
    str.split("🌍", 6).?; // 👉 ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.splitAll`](./splitAll.md)

  > [`io.types.buffer.splitToString`](./splitToString.md)

  > [`io.types.buffer.splitAllToStrings`](./splitAllToStrings.md)

  > [`io.types.buffer.lines`](./lines.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>