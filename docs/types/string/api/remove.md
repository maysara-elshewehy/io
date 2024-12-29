# [←](../readme.md) `io`.`types`.`string`.`remove`

> Removes a _(`range` or `position`)_ from the string.

```zig
pub inline fn remove(_self: *Self, _it: anytype) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.range` or `types.len` or `Self`

        > The _(`range` or `position`)_ to be remove.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Error` or `void`

    > Modifies the string in place, returns an error if the memory allocation fails.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init();
    defer str.deinit();
    ```

    > Remove using a `position`.

    ```zig
    str.remove(0);              // 👉 "🌍🌟!"
    ```

    > Remove using a `range`.

    ```zig
    str.remove(.{ 1, 2 });      // 👉 "🌍!"
    str.remove(.{ 0, 1 });      // 👉 "!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.removeReal`](./removeReal.md)

  > [`io.types.string.pop`](./pop.md)

  > [`io.types.string.shift`](./shift.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>