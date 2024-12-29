# [←](../readme.md) `io`.`types`.`buffer`.`rfind`

> Returns the last occurrence of a _(`string` or `char`)_ in a string.

```zig
pub inline fn rfind(_self: *Self, _it: anytype) ?types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.cstr` or `types.char` or `Self`

        > The value to search for inside the string.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len` or `null`

    > The position of the last occurrence of `_it` in the string `_in`, or `null` if not found.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var str = try string.initWith(<yourAllocator>, "==🌍🌟!!");
    defer str.deinit();
    ```

    > Find using a `character`.

    ```zig
    str.rfind('=');    // 👉 1   ("=")
    ```

    > Find using a `unicode`.

    ```zig
    str.rfind("🌍");   // 👉 2   (beg of "🌍")
    str.rfind("🌟");   // 👉 6   (beg of "🌟")
    ```

    > Find using a `string`.

    ```zig
    str.rfind("!!");   // 👉 10  ("!!")
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.find`](./find.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>