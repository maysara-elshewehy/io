# [←](../readme.md) `io`.`types`.`string`.`replace`

> Replaces the first `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements.

```zig
pub inline fn replace(_self: *Self, _it: anytype, _with: anytype, _count: types.unsigned) !types.unsigned
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.cstr` or `types.char` or `Self`

        > The value to replace.

    - `_with` : `types.cstr` or `types.char` or `Self`

        > The value to replace with.

    - `_count` : `types.unsigned`

        > The number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.unsigned`

    > The number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith("==🌍🌟!!");
    defer str.deinit();
    ```

    > Replace a `character` with `character`.

    ```zig
    str.replace('=', '@', 1);       // 👉 "@=🌍🌟!!"
    ```

    > Replace a `character` with `string`.

    ```zig
    str.replace('!', "text", 1);    // 👉 "@=🌍🌟text!"
    ```

    > Replace a `string` with `character`.

    ```zig
    str.replace("text", '!', 1);    // 👉 "@=🌍🌟!!"
    ```

    > Replace a `string` with `string`.

    ```zig
    str.replace("🌍🌟", "text", 1); // 👉 "@=text!!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.rreplace`](./rreplace.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>