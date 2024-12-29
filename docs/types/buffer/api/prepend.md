# [←](../readme.md) `io`.`types`.`buffer`.`prepend`

> Inserts a _(`string` or `char`)_ into the `beginning` of the string.

```zig
pub fn prepend(_self: *Self, _it: anytype) Error!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.cstr` or `types.char` or `Self`

        > The value to be inserted into the string.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Error` or `void`

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
    ```

    > Prepend using a `character`.

    ```zig
    try str.prepend('=');    // 👉 "="
    ```

    > Prepend using a `unicode`.

    ```zig
    try str.prepend("🌍");   // 👉 "🌍="
    try str.prepend("🌟");   // 👉 "🌟🌍="
    ```

    > Prepend using a `string`.

    ```zig
    var other = try string.initWith(alloc, "!!");
    defer other.deinit();

    try str.prepend(other);   // 👉 "!!🌍🌟="
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.writeStart`](./writeStart.md)

  > [`io.types.buffer.append`](./append.md)

  > [`io.types.buffer.insert`](./insert.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>