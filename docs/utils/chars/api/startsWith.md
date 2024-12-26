# [←](../readme.md) `io`.`utils`.`chars`.`startsWith`

> Returns true if the string starts with the given _(`string` or `char`)_.

```zig
pub inline fn startsWith(_it: types.cstr, _with: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.cstr`

        > The string to search inside.


    - `_with` : `types.cstr` or `types.char`

        > The value to search for.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if `_it` starts with `_with`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    const str = chars.make(64, "=🌍🌟!");

    chars.startsWith(str[0..10], "🌍");  // 👉 false
    chars.startsWith(str[0..10], '=');   // 👉 true

    // 👉 error, length must be > 0
    // chars.startsWith(str[0..10], "");
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.endsWith`](./endsWith.md)

  > [`io.utils.chars.eql`](./eql.md)

  > [`io.utils.chars.includes`](./includes.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>