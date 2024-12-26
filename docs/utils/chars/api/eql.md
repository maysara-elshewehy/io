# [←](../readme.md) `io`.`utils`.`chars`.`eql`

> Returns true if the given strings are equivalent.

```zig
pub inline fn eql(_str1: types.cstr, _str2: types.cstr) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_str1` : `types.cstr`

        > The first string to compare.


    - `_str2` : `types.cstr`

        > The second string to compare.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if both input strings are exactly the same.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    chars.eql("", "");              // 👉 true
    chars.eql("=🌍🌟!", "=🌍🌟!");  // 👉 true
    chars.eql("=🌍🌟!", "=====");   // 👉 false
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.includes`](./includes.md)

  > [`io.utils.chars.startsWith`](./startsWith.md)

  > [`io.utils.chars.endsWith`](./endsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>