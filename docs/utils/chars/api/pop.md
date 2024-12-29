# [←](../readme.md) `io`.`utils`.`chars`.`pop`

>  Removes a _(`N` bytes)_ from the end of the string _(using `/0`)_.

```zig
pub inline fn pop(_from: types.str, _len: types.len, _bytes: types.len) types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_from` : `types.str`

        > The string to remove from.


    - `_len` : `types.len`

        > The length of string to remove from.

    - `_bytes` : `types.len`

        > The number of bytes to remove from the end of the string.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `types.len`

    > The number of bytes removed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var str = chars.make(64, "=🌍🌟!");

    const r1 = chars.pop(str[0..], 10, 1);  // 👉 r1 = 1, "=🌍🌟"
    const r2 = chars.pop(str[0..], 9,  1);  // 👉 r2 = 4, "=🌍"
    const r3 = chars.pop(str[0..], 5,  1);  // 👉 r3 = 4, "="
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.shift`](./shift.md)

  > [`io.utils.chars.remove`](./remove.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>