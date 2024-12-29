# [←](../readme.md) `io`.`types`.`buffer`.`insertReal`

> Inserts a _(`string` or `char`)_ into a `specific real  position` in the string.

```zig
pub fn insertReal(_self: *Self, _it: anytype, _pos: types.len) Error!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.cstr` or `types.char` or `Self`

        > The value to be inserted into the string.

    - `_pos` : `types.len`

        > The real position in the string to insert at.

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

    > Insert using a `character`.

    ```zig
    try str.insertReal('=', 0);     // 👉 "="
    ```

    > Insert using a `unicode`.

    ```zig
    try str.insertReal("🌍", 1);    // 👉 "=🌍"
    try str.insertReal("🌟", 5);    // 👉 "=🌍🌟"
    ```

    > Insert using a `string`.

    ```zig
    var other = try string.initWith(<yourAllocator>, "!!");
    defer other.deinit();

    try str.insertReal(other, 9);   // 👉 "=🌍🌟!!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.insert`](./insert.md)

  > [`io.types.buffer.append`](./append.md)

  > [`io.types.buffer.prepend`](./prepend.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>