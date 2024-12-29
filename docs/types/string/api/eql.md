# [←](../readme.md) `io`.`types`.`string`.`eql`

> Returns true if the string are equal to the given _(`string` or `char`)_.

```zig
pub inline fn eql(_self: Self, _with: anytype) bool
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The source string to be used.

    - `_with` : `types.cstr` or `types.char` or `Self`

        > The value to compare with.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `bool`

    > Returns true if both values are exactly the same.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(<yourAllocator>, "=🌍🌟!");
    defer str.deinit();

    str.eql("");        // 👉 false
    str.eql("=====");   // 👉 false
    str.eql("=🌍🌟!");  // 👉 true
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.includes`](./includes.md)

  > [`io.types.string.startsWith`](./startsWith.md)

  > [`io.types.string.endsWith`](./endsWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>