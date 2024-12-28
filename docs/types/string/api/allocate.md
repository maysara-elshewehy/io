# [←](../readme.md) `io`.`types`.`string`.`allocate`

> Allocate or reallocate the string buffer to a new size.

```zig
pub fn allocate(_self: *Self, _bytes: types.unsigned) !void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_bytes` : `types.unsigned`

        > The number of bytes to allocate for the string buffer.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void` or `anyerror`

    > If allocation fails, an error is returned. Otherwise, the string buffer is deallocated and reallocated to the new size.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").utils.string;
    ```

    > using array of characters.

    ```zig
    var str = string.init(");
    defer str.deinit();

    str.size(); // 👉 0
    try str.allocate(10);
    str.size(); // 👉 10
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.init`](./init.md)

  > [`io.types.string.initWith`](./initWith.md)

  > [`io.types.string.deinit`](./deinit.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>