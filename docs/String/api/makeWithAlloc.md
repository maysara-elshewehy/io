# [←](../String.md) `String`.`makeWithAlloc`

> Creates a new string with a `specific allocator` and copies the bytes into it.

```zig
pub fn makeWithAlloc(_it: Types.cbytes, _alloc: std.mem.Allocator) !String
```


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `Types.cbytes`

        > The input to copy.

    - `_alloc` : `std.mem.Allocator`

        > The allocator to use.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!String`

    > Returns `error.AllocationFailed` _if the allocation fails._

    > Returns `error.InvalidUTF8` _if the `_it` is not valid UTF-8._.

    > A new `String` initialized with the contents of `_it`.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
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
    const str = try String.makeWithAlloc("", gpa.allocator());          // 👉 "", size: 0, length: 0
    defer str.free();
    ```

    > Non-Empty String

    ```zig
    const str = try String.makeWithAlloc("Hello 🌍!", gpa.allocator()); // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.free();
    ```

    > Constant String.

    ```zig
    const src = "Hello 🌍!";
    const str = try String.makeWithAlloc(src, gpa.allocator());         // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.free();
    ```

    > Mutable String.

    ```zig
    var src = "Hello 🌍!";
    const str = try String.makeWithAlloc(src[0..], gpa.allocator());    // 👉 "Hello 🌍!", size: 22, length: 11
    defer str.free();
    ```

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.makeWith`](./makeWith.md)

  > [`String.makeAlloc`](./makeAlloc.md)

  > [`String.src`](./src.md)

  > [`String.clone`](./clone.md)


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>