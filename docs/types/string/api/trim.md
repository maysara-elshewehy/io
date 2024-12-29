# [←](../readme.md) `io`.`types`.`string`.`trim`

> Removes all matching characters fromt both `beg` and `end` of the string.


```zig
pub inline fn trim(_self: *Self, _char: types.char) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_char` : `types.char`

        > The _(`character`)_ to remove with.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void`

    > Modifies the string in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").utils.string;
    ```

    ```zig
    var str = try string.initWith(<yourAllocator>, "  =🌍🌟!  ");
    defer str.deinit();

    str.trim(' '); // 👉 "=🌍🌟!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.trimStart`](./trimStart.md)

  > [`io.types.string.trimEnd`](./trimEnd.md)

  > [`io.types.string.pop`](./pop.md)

  > [`io.types.string.shift`](./shift.md)

  > [`io.types.string.remove`](./remove.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>