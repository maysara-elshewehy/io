# [←](../readme.md) `io`.`utils`.`chars`.`split`

> Returns a slice of the string split by the separator _(`string` or `char`)_ at the specified position, or null if failed.

```zig
pub inline fn split(_it: types.cstr, _sep: anytype, _pos: types.len) ?types.cstr
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.cstr`

        > The string to used.

    - `_sep` : `types.cstr` or `types.char`

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
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "🌍1🌍🌍2🌍🌍3🌍");

    chars.split(res[0..27], "🌍", 0).?; // 👉 ""
    chars.split(res[0..27], "🌍", 1).?; // 👉 "1"
    chars.split(res[0..27], "🌍", 2).?; // 👉 ""
    chars.split(res[0..27], "🌍", 3).?; // 👉 "2"
    chars.split(res[0..27], "🌍", 5).?; // 👉 "3"
    chars.split(res[0..27], "🌍", 6).?; // 👉 ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.repeat`](./repeat.md)

  > [`io.utils.chars.reverse`](./reverse.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>