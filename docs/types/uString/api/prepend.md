# [←](../uString.md) `uString`.`prepend`

> Prepends a `slice` into the `uString` instance.

```zig
pub fn prepend(self: *Self, allocator: Allocator, slice: []const u8) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description             |
    | ----------- | ------------------- | ----------------------- |
    | `self`      | `*Self`             | The `uString` instance. |
    | `allocator` | `std.mem.Allocator` | The allocator to use.   |
    | `slice`     | `[]const u8`        | The slice to insert.    |

- #### 🚫 Errors

    | Error            | Reason                                         |
    | ---------------- | ---------------------------------------------- |
    | `AllocatorError` | The allocator returned an error.               |

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

    ```zig
    _ = try string.prepend(allocator, "H");   // 👉 "H"
    _ = try string.prepend(allocator, "e");   // 👉 "eH"
    _ = try string.prepend(allocator, "oll"); // 👉 "olleH"
    _ = try string.prepend(allocator, " ");   // 👉 " olleH"
    _ = try string.prepend(allocator, "👨‍🏭");  // 👉 "👨‍🏭 olleH"
    _ = try string.prepend(allocator, "!");   // 👉 "!👨‍🏭 olleH"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.initCapacity`](./initCapacity.md)

  > [`uString.insert`](./insert.md)

  > [`uString.insertOne`](./insertOne.md)

  > [`uString.insertVisual`](./insertVisual.md)

  > [`uString.insertVisualOne`](./insertVisualOne.md)

  > [`uString.append`](./append.md)

  > [`uString.appendOne`](./appendOne.md)

  > [`uString.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>