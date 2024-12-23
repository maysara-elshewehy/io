# [←](../readme.md) `io`.`utils`.`chars`.`make`

> Returns a _(`fixed-string`)_ with specified size and content.

```zig
pub inline fn make(comptime _size: comptime_int, comptime _with :?types.cstr) [_size]types.char
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime` `_size` : `comptime_int`

        > The size of the array.

    - `comptime` `_with` : `?types.cstr`

        > The `string` to initialize with or `null` for an undefined value.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `[_size]types.char`

    > An array of characters with the specified size, initialized with the provided string or left undefined if `null` is passed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    // init with undefined.
    var src = chars.make(64, null);

    // equals to
    // var src : [64]u8 = undefined;
    ```

    ```zig
    // init with value.
    var src = chars.make(64, "=🌍🌟!");

    // equals to
    // var src : [64]u8 = undefined;
    // chars.append(src[0..], 0, "=🌍🌟!");
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.size`](./size.md)

  > [`io.utils.chars.calc`](./calc.md)

  > [`io.utils.chars.get`](./get.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>