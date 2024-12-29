# [←](../readme.md) `io`.`utils`.`chars`.`append`

> Inserts a _(`string` or `char`)_ into the `end` of the string.

```zig
pub inline fn append(_to: types.str, _len: types.len, _it: anytype) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_to` : `types.str`

        > The string to insert into.


    - `_len` : `types.len`

        > The length of string to insert into.


    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to be inserted into the string.


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
    var str = chars.make(64, null);
    ```

    > Append using a `character`.

    ```zig
    chars.append(str[0..], 0, '=');     // 👉 "="
    ```

    > Append using a `unicode`.

    ```zig
    chars.append(str[0..], 1, "🌍");    // 👉 "=🌍"
    chars.append(str[0..], 5, "🌟");    // 👉 "=🌍🌟"
    ```

    > Append using a `string`.

    ```zig
    chars.append(str[0..], 9, "!!");    // 👉 "=🌍🌟!!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.prepend`](./prepend.md)

  > [`io.utils.chars.insert`](./insert.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>