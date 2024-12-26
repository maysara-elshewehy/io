# [←](../readme.md) `io`.`utils`.`chars`.`find`

> Returns the first occurrence of a _(`string` or `char`)_ in a string.

```zig
pub inline fn find(_in: types.cstr, _it: anytype) ?types.unsigned
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.str`

        > The string to search inside.

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to search for inside the string.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.unsigned` or `null`

    > The position of the first occurrence of `_it` in the string `_in`, or `null` if not found.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "==🌍🌟!!);
    ```

    > Find using a `character`.

    ```zig
    chars.find(str[0..12], '=');    // 👉 0   ("=")
    ```

    > Find using a `unicode`.

    ```zig
    chars.find(str[0..12], "🌍");   // 👉 2   (beg of "🌍")
    chars.find(str[0..12], "🌟");   // 👉 6   (beg of "🌟")
    ```

    > Find using a `string`.

    ```zig
    chars.find(str[0..12], "!!");   // 👉 10  ("!!")
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.rfind`](./rfind.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>