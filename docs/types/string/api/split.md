# [←](../readme.md) `io`.`types`.`string`.`split`

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
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(alloc, "🌍1🌍🌍2🌍🌍3🌍");
    defer str.deinit()

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

  > [`io.types.string.splitAll`](./splitAll.md)

  > [`io.types.string.splitToString`](./splitToString.md)

  > [`io.types.string.splitAllToStrings`](./splitAllToStrings.md)

  > [`io.types.string.lines`](./lines.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>