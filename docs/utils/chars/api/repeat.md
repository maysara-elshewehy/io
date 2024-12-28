# [←](../readme.md) `io`.`utils`.`chars`.`repeat`

> Repeats the _(`string` or `char`)_ `N` times.

```zig
pub inline fn repeat(_in: types.str, _len: types.unsigned, _it: anytype, _count: types.unsigned) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.str`

        > The string to used.

    - `_len` : `types.unsigned`

        > The length of `_in` in bytes.

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to repeat.

    - `_count` : `types.unsigned`

        > The number of repeats.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void`

    > Modifies `_in` in place, does not return a value.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, null);
    ```

    > Repeat a `character`.

    ```zig
    chars.repeat(str[0..], 0, '0', 1);  // 👉 "0"
    chars.repeat(str[0..], 1, '0', 2);  // 👉 "000"
    ```

    > Repeat a `string`.

    ```zig
    chars.repeat(str[0..], 3, "@#", 2); // 👉 "000@#@#"
    ```

    > Repeat a `unicode`.

    ```zig
    chars.repeat(str[0..], 7, "🌍", 2); // 👉 "000@#@#🌍🌍"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.reverse`](./reverse.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>