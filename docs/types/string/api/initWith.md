# [←](../readme.md) `io`.`types`.`string`.`init`

> Initialize a string with an allocator and a given substring.

```zig
pub fn initWith(_it: anytype) anyerror!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `types.cstr` or `types.char` or `Self`

        > The initial value to be used for creating the string.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Self` or `anyerror`

    > An initialized string structure or error if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").utils.string;
    ```

    > using array of characters.

    ```zig
    var str = try string.initWith("Hello 🌍!");     👉 "Hello 🌍!"
    defer str.deinit();
    ```

    > using character.

    ```zig
    var str = try string.initWith('!');             👉 "!"
    defer str.deinit();
    ```

    > using another string structure.

    ```zig
    var str1 = try string.initWith("Hello 🌍!");    👉 "Hello 🌍!"
    defer str.deinit();

    var str2 = try string.initWith(str1);           👉 "Hello 🌍!"
    defer str.deinit();
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.init`](./init.md)

  > [`io.types.string.deinit`](./deinit.md)

  > [`io.types.string.allocate`](./allocate.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>