# [←](../readme.md) `io`.`utils`.`chars`.`size`

> Returns the size of a _(`string` or `char`)_.

```zig
pub inline fn size(_it: anytype) types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to be processed for size calculation.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    > The size of `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    const str = chars.make(64, "=🌍🌟!");

    // size of array.
    _ = chars.size(str[0..]);   // 👉 64

    // size of single characters.
    _ = chars.size(str[0]);     // 👉 1

    // size of unicode.
    _ = chars.size(str[1]);     // 👉 4 'beg  of 🌍'
    _ = chars.size(str[2]);     // 👉 1 'part of 🌍'
    _ = chars.size(str[3]);     // 👉 1 'part of 🌍'
    _ = chars.size(str[4]);     // 👉 1 'end  of 🌍'

    _ = chars.size(str[5]);     // 👉 4 'beg  of 🌟'
    _ = chars.size(str[6]);     // 👉 1 'part of 🌟'
    _ = chars.size(str[7]);     // 👉 1 'part of 🌟'
    _ = chars.size(str[8]);     // 👉 1 'end  of 🌟'

    // size of single character.
    _ = chars.size(str[9]);     // 👉 1 '!'
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.bytes`](./bytes.md)

  > [`io.utils.chars.make`](./make.md)

  > [`io.utils.chars.get`](./get.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>