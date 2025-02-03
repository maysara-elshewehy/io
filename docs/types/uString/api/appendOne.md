# [←](../uString.md) `uString`.`appendOne`

> Appends a `byte` into the `uString` instance.

```zig
pub fn appendOne(self: *Self, allocator: Allocator, byte: u8) insertError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description             |
    | ----------- | ------------------- | ----------------------- |
    | `self`      | `*Self`             | The `uString` instance. |
    | `allocator` | `std.mem.Allocator` | The allocator to use.   |
    | `byte`      | `u8`                | The byte to insert.     |

- #### 🚫 Errors

    | Error            | Reason                           |
    | ---------------- | -------------------------------- |
    | `AllocatorError` | The allocator returned an error. |

- #### ✨ Returns : `void`

    > Modifies the `uString` instance in place.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.initCapacity(allocator, 7);
    defer string.deinit(allocator);
    ```

    ```zig
    _ = try string.appendOne(allocator, 'H'); // 👉 "H"
    _ = try string.appendOne(allocator, 'e'); // 👉 "He"
    _ = try string.appendOne(allocator, 'l'); // 👉 "Hel"
    _ = try string.appendOne(allocator, 'l'); // 👉 "Hell"
    _ = try string.appendOne(allocator, 'o'); // 👉 "Hello"
    _ = try string.appendOne(allocator, ' '); // 👉 "Hello "
    _ = try string.appendOne(allocator, '!'); // 👉 "Hello !"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.initCapacity`](./initCapacity.md)

  > [`uString.insert`](./insert.md)

  > [`uString.insertOne`](./insertOne.md)

  > [`uString.insertVisual`](./insertVisual.md)

  > [`uString.insertVisualOne`](./insertVisualOne.md)

  > [`uString.append`](./append.md)

  > [`uString.prepend`](./prepend.md)

  > [`uString.prependOne`](./prependOne.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>