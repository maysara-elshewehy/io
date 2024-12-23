# [←](../readme.md) `io`.`utils`.`chars`.`get`

> Returns the (`unicode` or `char`) at the specified position_(`non-real`)_ in the string.

```zig
pub inline fn get(_in: types.cstr, _pos: types.unsigned) ?types.cstr
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_in` : `types.cstr`

        > desc.

    - `_pos` : `types.unsigned`

        > desc.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `?types.cstr`

    > Optional _`constant string`_ or _`null`_ if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    const src = chars.make(64, "=🌍🌟!");

    _ = chars.get(res[0..], 0).?; // 👉 "="
    _ = chars.get(res[0..], 1).?; // 👉 "🌍"
    _ = chars.get(res[0..], 2).?; // 👉 "🌟"
    _ = chars.get(res[0..], 3).?; // 👉 "!"
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.make`](./make.md)

  > [`io.utils.chars.bytes`](./bytes.md)

  > [`io.utils.chars.size`](./size.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>