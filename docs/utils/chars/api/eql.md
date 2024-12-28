# [←](../readme.md) `io`.`utils`.`chars`.`eql`

> Returns true if the given _(`string` or `char`)_ are equal to the given _(`string` or `char`)_.

```zig
pub inline fn eql(_it: anytype, _with: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.cstr` or `types.char`

        > The first value to compare.


    - `_with` : `types.cstr` or `types.char`

        > The second value to compare.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if both input values are exactly the same.

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

    // two characters
    chars.eql('@', '@');            // 👉 true

    // string and character
    chars.eql("@", '@');            // 👉 true

    // character and string
    chars.eql('@', "@");            // 👉 true
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