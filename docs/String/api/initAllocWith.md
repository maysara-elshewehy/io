# [←](../String.md) `String`.`initAllocWith`

> Initializes a new string with a `specific allocator` and copies the value into it.

```zig
pub fn initAllocWith(_it: anytype, _alloc: std.mem.Allocator) !String
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_alloc` : `std.mem.Allocator`

        > The allocator to use.

    - `_it` : `Types.cbytes` or `Types.byte` or `String`

        > The input to copy.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!String`

    > Returns `error.InvalidType` _if the `_it` type is invalid._

    > Returns `error.InvalidUTF8` _if the `_it` is not valid UTF-8._.

    > Returns `error.AllocationFailed` _if the allocation fails._

    > A new `String` initialized with the contents of `_it`.

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

    > Empty String

    ```zig
    const str = try String.initAllocWith(gpa.allocator(), "");          // 👉 "", size: 0, length: 0
    defer str.deinit();
    ```

    > Non-Empty String

    ```zig
    const str = try String.initAllocWith(gpa.allocator(), "Hello 🌍!"); // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.deinit();
    ```

    > Constant String.

    ```zig
    const src = "Hello 🌍!";
    const str = try String.initAllocWith(gpa.allocator(), src);         // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.deinit();
    ```

    > Mutable String.

    ```zig
    var src = "Hello 🌍!";
    const str = try String.initAllocWith(gpa.allocator(), src[0..]);    // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.deinit();
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.init`](./init.md)

  > [`String.initWith`](./initWith.md)

  > [`String.initAlloc`](./initAlloc.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>