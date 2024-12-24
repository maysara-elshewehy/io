# [←](../readme.md) `io`.`types`.`string`.`appendf`

> Inserts a _(`formatted string`)_ into the `end` of the string.

```zig
pub fn appendf(_self: *Self, comptime _fmt: types.cstr, _args: anytype) anyerror!void
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

    try str.appendf( "{c}", .{ '=' } );     // 👉 "="
    try str.appendf( "{s}", .{ "🌍" } );    // 👉 "=🌍"
    try str.appendf( "{s}", .{ "🌟" } );    // 👉 "=🌍🌟"
    try str.appendf( "{d}", .{ 99 } );      // 👉 "=🌍🌟99"
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.append`](./append.md)

  > [`io.types.string.prependf`](./prependf.md)

  > [`io.types.string.insertf`](./insertf.md)

  > [`io.types.string.writer`](./writer.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>