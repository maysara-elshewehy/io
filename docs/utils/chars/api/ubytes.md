# [←](../readme.md) `io`.`utils`.`chars`.`ubytes`

> Returns the number of characters in the string (Unicode characters are counted as regular characters).

```zig
pub inline fn ubytes(_it: anytype) types.unsigned
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `anytype`

        > The _(`string` or `char`)_ to be processed for length calculation.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `?types.cstr`

    > The length of `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var src = chars.make(64, null);

    // non-terminated string.
    chars.ubytes(src[0..]);   // 👉 64

    // append some string.
    chars.append(src[0..], 0, "=🌍🌟!");

    // terminate the string
    src[11] = 0;

    // try again
    chars.ubytes(src[0..]);   // 👉 4
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.bytes`](./bytes.md)

  > [`io.utils.chars.size`](./size.md)

  > [`io.utils.chars.make`](./make.md)

  > [`io.utils.chars.get`](./get.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>