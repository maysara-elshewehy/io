# [←](../readme.md) `io`.`utils`.`chars`.`replacementSize`

> Calculates how much bytes will be removed.

```zig
pub inline fn replacementSize(_in: types.str, _it: anytype, _count: types.len) types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.str`

        > The string to used.

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to replace.

    - `_count` : `types.len`

        > The number of replacements to calculate the size for.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    > The number of bytes that will be removed.

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

    > Calculate the number of bytes that will be removed.

    ```zig
    const bytesRemoved = chars.replacementSize(str[0..], '=', 1);  // 👉 1
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.replace`](./replace.md)

  > [`io.utils.chars.rreplace`](./rreplace.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>