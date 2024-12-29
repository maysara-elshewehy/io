# [←](../readme.md) `io`.`utils`.`chars`.`replace`

> Replaces the first `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements.

```zig
pub inline fn replace(_in: types.str, _len: types.len, _it: anytype, _with: anytype, _count: types.len) types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.str`

        > The string to used.

    - `_len` : `types.len`

        > The length of `_in` in bytes.

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to replace.

    - `_with` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to replace with.

    - `_count` : `types.len`

        > The number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    > The number of replacements.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "==🌍🌟!!");
    ```

    > Replace a `character` with `character`.

    ```zig
    chars.replace(str[0..], 12, '=', '@', 1);       // 👉 "@=🌍🌟!!"
    ```

    > Replace a `character` with `string`.

    ```zig
    chars.replace(str[0..], 12, '!', "text", 1);    // 👉 "@=🌍🌟text!"
    ```

    > Replace a `string` with `character`.

    ```zig
    chars.replace(str[0..], 15, "text", '!', 1);    // 👉 "@=🌍🌟!!"
    ```

    > Replace a `string` with `string`.

    ```zig
    chars.replace(str[0..], 12, "🌍🌟", "text", 1); // 👉 "@=text!!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.rreplace`](./rreplace.md)

  > [`io.utils.chars.replacementSize`](./replacementSize.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>