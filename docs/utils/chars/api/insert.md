# [←](../readme.md) `io`.`utils`.`chars`.`insert`

> Inserts a _(`string` or `char`)_ into a `specific position` in the string.

```zig
pub inline fn insert(_to: types.str, _len: types.unsigned, _it: anytype, _pos: types.unsigned) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_to` : `types.str`

        > The string to insert into.


    - `_len` : `types.unsigned`

        > The length of string to insert into.


    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to be inserted into the string.


    - `_pos` : `types.unsigned`

        > The position in the string to insert at.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void`

    > Modifies the string in place, does not return a value.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    var src = chars.make(64, null);
    ```

    > Insert using a `character`.

    ```zig
    chars.insert(res[0..], 0, '=', 0);      // 👉 "="
    ```

    > Insert using a `unicode`.

    ```zig
    chars.insert(res[0..], 1, "🌍", 1);     // 👉 "=🌍"
    chars.insert(res[0..], 5, "🌟", 1);     // 👉 "=🌟🌍"
    ```

    > Insert using a `string`.

    ```zig
    chars.insert(res[0..], 9, "!!", 3);     // 👉 "=🌟🌍!!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.writeAtReal`](./writeAtReal.md)

  > [`io.utils.chars.append`](./append.md)

  > [`io.utils.chars.prepend`](./prepend.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>