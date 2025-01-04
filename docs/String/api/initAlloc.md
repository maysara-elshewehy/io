# [←](../String.md) `String`.`initAlloc`

> Initializes a new string with a `specific allocator`.

```zig
pub fn initAlloc(_alloc: std.mem.Allocator) String
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_alloc` : `std.mem.Allocator`

        > The allocator to use.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `String`

    > A new `String` initialized with `0`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const std = @import("std");
    const String = @import("io").String;
    ```

    ```zig
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    ```

    ```zig
    var str = String.initAlloc(gpa.allocator());    // 👉 "", size: 0, len: 0
    defer str.deinit();
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.init`](./init.md)

  > [`String.initWith`](./initWith.md)

  > [`String.initAllocWith`](./initAllocWith.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>