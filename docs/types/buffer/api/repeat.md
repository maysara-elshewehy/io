# [←](../readme.md) `io`.`types`.`buffer`.`repeat`

> Repeats the _(`string` or `char`)_ `N` times.

```zig
pub inline fn repeat(_self: *Self, _it: anytype, _count: types.len) Error!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to repeat.

    - `_count` : `types.len`

        > The number of repeats.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Error` or `void`

    > Modifies the string in place, returns an error if out of memory.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var buf = chars.make(64, null);
    var str = buffer(&buf);
    ```

    > Repeat a `character`.

    ```zig
    try str.repeat('0', 1);  // 👉 "0"
    try str.repeat('0', 2);  // 👉 "000"
    ```

    > Repeat a `string`.

    ```zig
    try str.repeat("@#", 2); // 👉 "000@#@#"
    ```

    > Repeat a `unicode`.

    ```zig
    try str.repeat("🌍", 2); // 👉 "000@#@#🌍🌍"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.reverse`](./reverse.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>