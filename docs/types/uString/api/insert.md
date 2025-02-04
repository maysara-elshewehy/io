# [←](../uString.md) `uString`.`insert`

> Inserts a `slice` into the `uString` instance at the specified `position` by **real position**.

```zig
pub fn insert(self: *Self, allocator: Allocator, slice: []const u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                |
    | ----------- | ------------------- | -------------------------- |
    | `self`      | `*Self`             | The `uString` instance.    |
    | `allocator` | `std.mem.Allocator` | The allocator to use.      |
    | `slice`     | `[]const u8`        | The slice to insert.       |
    | `pos`       | `usize`             | The position to insert at. |

- #### 🚫 Errors

    | Error            | Reason                                         |
    | ---------------- | ---------------------------------------------- |
    | `AllocatorError` | The allocator returned an error.               |
    | `OutOfRange`     | The `pos` is greater than `uString` length.    |

- #### ✨ Returns : `void`

    > Modifies the `uString` instance in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.initCapacity(allocator, 18);
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.insert(allocator, "H",   0); // 👉 "H"
        try string.insert(allocator, "!",   1); // 👉 "H!"
        try string.insert(allocator, "o",   1); // 👉 "Ho!"
        try string.insert(allocator, "ell", 1); // 👉 "Hello!"
        try string.insert(allocator, " ",   5); // 👉 "Hello !"
        try string.insert(allocator, "👨‍🏭",  6); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insert(allocator, "@", 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.initCapacity`](./initCapacity.md)

  > [`uString.insertOne`](./insertOne.md)

  > [`uString.insertVisual`](./insertVisual.md)

  > [`uString.insertVisualOne`](./insertVisualOne.md)

  > [`uString.append`](./append.md)

  > [`uString.appendOne`](./appendOne.md)

  > [`uString.prepend`](./prepend.md)

  > [`uString.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>