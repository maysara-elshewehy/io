# [←](../readme.md) `io`.`types`.`string`.`init`

> Initialize an empty string.

```zig
pub fn init(_alloc: std.mem.Allocator) Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_alloc` : `std.mem.Allocator`

        > The allocator to be used for allocating the string's buffer.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Self`

    > An empty string structure.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").utils.string;
    ```

    ```zig
    var str = string.init(alloc);    // Creates a new string structure.
    defer str.deinit();         // Cleans up the allocated memory (if allocated) when the scope ends.
    str.size();                 // 👉 0
    str.bytes();                // 👉 0
    str.src();                  // 👉 ""
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.initWith`](./initWith.md)

  > [`io.types.string.deinit`](./deinit.md)

  > [`io.types.string.allocate`](./allocate.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>