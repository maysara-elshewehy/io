# [←](../readme.md) `io`.`utils`.`chars`.`remove`

> Removes a _(`range` or `position`)_ from the string.

```zig
pub inline fn remove(_from: types.str, _it: anytype) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_from` : `types.str`

        > The string to remove from.


    - `_it` : `types.range` or `types.len`

        > The _(`range` or `position`)_ to be remove.


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
    var str = chars.make(64, "=🌍🌟!");
    ```

    > Remove using a `position`.

    ```zig
    chars.remove(str[0..], 0);              // 👉 "🌍🌟!"
    ```

    > Remove using a `range`.

    ```zig
    chars.remove(str[0..], .{ 1, 2 });      // 👉 "🌍!"
    chars.remove(str[0..], .{ 0, 1 });      // 👉 "!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.removeReal`](./removeReal.md)

  > [`io.utils.chars.pop`](./pop.md)

  > [`io.utils.chars.shift`](./shift.md)

  > [`io.utils.chars.zeros`](./zeros.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>