# [←](../readme.md) `io`.`types`.`string`.`find`

> Returns the first occurrence of a _(`string` or `char`)_ in a string.

```zig
pub inline fn find(_self: *Self, _it: anytype) ?types.len
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

    > The position of the first occurrence of `_it` in the string `_in`, or `null` if not found.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(alloc, "==🌍🌟!!");
    defer str.deinit();
    ```

    > Find using a `character`.

    ```zig
    str.find('=');    // 👉 0   ("=")
    ```

    > Find using a `unicode`.

    ```zig
    str.find("🌍");   // 👉 2   (beg of "🌍")
    str.find("🌟");   // 👉 6   (beg of "🌟")
    ```

    > Find using a `string`.

    ```zig
    str.find("!!");   // 👉 10  ("!!")
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.rfind`](./rfind.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>