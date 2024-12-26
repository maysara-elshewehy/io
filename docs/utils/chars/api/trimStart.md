# [←](../readme.md) `io`.`utils`.`chars`.`trimStart`

> Removes all matching characters at the `beg` of the string.

```zig
pub inline fn trimStart(_it: types.str, _char: types.char) types.unsigned
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

- #### Returns : `types.unsigned`

    - #### Returns : `types.unsigned`

    > The number of characters removed from the `start` of the string.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "  =🌍🌟!");

    const r = chars.trimStart(str[0..12], ' '); // 👉 (r = 2), "=🌍🌟!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.trimEnd`](./trimEnd.md)

  > [`io.utils.chars.trim`](./trim.md)

  > [`io.utils.chars.pop`](./pop.md)

  > [`io.utils.chars.shift`](./shift.md)

  > [`io.utils.chars.remove`](./remove.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>