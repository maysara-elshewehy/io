# [←](../readme.md) `io`.`types`.`buffer`.`writeAt`

> Inserts a _(`formatted string`)_ into a `specific position` in the string.

```zig
pub fn writeAt(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) anyerror!void
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

        > The position in the string to insert at.

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
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var buf = chars.make(64, null);
    var str = buffer(&buf);

    try str.writeAt( "{c}", .{ '='  }, 0 );     // 👉 "="
    try str.writeAt( "{s}", .{ "🌍" }, 0 );     // 👉 "🌍="
    try str.writeAt( "{s}", .{ "🌟" }, 1 );     // 👉 "🌍🌟="
    try str.writeAt( "{d}", .{ 99 }  , 0 );     // 👉 "99🌍🌟="
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.write`](./write.md)

  > [`io.types.buffer.writeStart`](./writeStart.md)

  > [`io.types.buffer.writer`](./writer.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>