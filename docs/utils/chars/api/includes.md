# [←](../readme.md) `io`.`utils`.`chars`.`includes`

> Returns true if the string contains a _(`string` or `char`)_.

```zig
pub inline fn includes(_in: types.cstr, _it: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.cstr`

        > The string to search inside.


    - `_it` : `types.cstr` or `types.char`

        > The value to search for.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if `_in` includes `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    const str = chars.make(64, "=🌍🌟!");

    chars.includes(str[0..10], '=');    // 👉 true
    chars.includes(str[0..10], "🌍");   // 👉 true
    chars.includes(str[0..10], "🌟");   // 👉 true
    chars.includes(str[0..10], "!");    // 👉 true
    chars.includes(str[0..10], '@');    // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.eql`](./eql.md)

  > [`io.utils.chars.startsWith`](./startsWith.md)

  > [`io.utils.chars.endsWith`](./endsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>