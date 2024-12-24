# [←](../readme.md) `io`.`types`.`string`.`insertfReal`

> Inserts a _(`formatted string`)_ into a `specific position` _(The real position)_ in the string.

```zig
pub fn insertfReal(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) anyerror!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_fmt` : `types.cstr`

        > A [fmt string](https://ziglang.org/documentation/master/std/#std.fmt) used to format the string.

    - `_args` : `.{..}`

        > The arguments used to format the string

    - `_pos` : `types.unsigned`

        > The real position in the string to insert at.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `anyerror` or `void`

    > Modifies the string in place, returns an error if the memory allocation fails.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init();
    defer str.deinit();

    try str.insertfReal( "{c}", .{ '='  }, 0 );     // 👉 "="
    try str.insertfReal( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
    try str.insertfReal( "{s}", .{ "🌟" }, 4 );     // 👉 "🌍🌟="
    try str.insertfReal( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.insertReal`](./insertReal.md)

  > [`io.types.string.insertf`](./insertf.md)

  > [`io.types.string.appendf`](./appendf.md)

  > [`io.types.string.prependf`](./prependf.md)

  > [`io.types.string.writer`](./writer.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>