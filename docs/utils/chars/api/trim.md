# [←](../readme.md) `io`.`utils`.`chars`.`trim`

> Removes all matching characters fromt both `start` and `end` of the string.

```zig
pub inline fn trim(_it: types.str, _char: types.char) types.len
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.str`

        > The string to remove from.


    - `_char` : `types.char`

        > The _(`character`)_ to remove with.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    - #### Returns : `types.len`

    > The number of characters removed from the string.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "  =🌍🌟!  ");

    const r = chars.trim(str[0..14], ' '); // 👉 (r = 4), "=🌍🌟!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.trimStart`](./trimStart.md)

  > [`io.utils.chars.trimEnd`](./trimEnd.md)

  > [`io.utils.chars.pop`](./pop.md)

  > [`io.utils.chars.shift`](./shift.md)

  > [`io.utils.chars.remove`](./remove.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>