# [←](../readme.md) `types`.`utils`.`string`.`includes`

> Returns true if the string contains a _(`string` or `char`)_.

```zig
pub inline fn includes(_self: Self, _it: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string to search inside.


    - `_it` : `types.cstr` or `types.char` or `Self`

        > The value to search for.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if string includes `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(<yourAllocator>, "=🌍🌟!");
    defer str.deinit();

    str.includes('=');    // 👉 true
    str.includes("🌍");   // 👉 true
    str.includes("🌟");   // 👉 true
    str.includes("!");    // 👉 true
    str.includes('@');    // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.eql`](./eql.md)

  > [`io.types.string.startsWith`](./startsWith.md)

  > [`io.types.string.endsWith`](./endsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>