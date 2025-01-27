# [←](../uString.md) `uString`.`insertVisualOne`

> Inserts a `byte` into the `uString` instance at the specified `visual position`.

```zig
pub fn insertVisualOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                       |
    | ----------- | ------------------- | --------------------------------- |
    | `self`      | `*Self`             | The `uString` instance.           |
    | `allocator` | `std.mem.Allocator` | The allocator to use.             |
    | `byte`      | `u8`                | The byte to insert.               |
    | `pos`       | `usize`             | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                      |
    | ----------------- | ------------------------------------------- |
    | `AllocatorError`  | The allocator returned an error.            |
    | `InvalidPosition` | The position is invalid.                    |
    | `OutOfRange`      | The `pos` is greater than `uString` length. |

- #### ✨ Returns : `void`

    > Modifies the `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "👨‍🏭");
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try string.insertVisualOne(allocator, 'H', 1); // 👉 "👨‍🏭H"
        _ = try string.insertVisualOne(allocator, '!', 2); // 👉 "👨‍🏭H!"
        _ = try string.insertVisualOne(allocator, 'o', 2); // 👉 "👨‍🏭Ho!"
        _ = try string.insertVisualOne(allocator, 'l', 2); // 👉 "👨‍🏭Hlo!"
        _ = try string.insertVisualOne(allocator, 'e', 2); // 👉 "👨‍🏭Helo!"
        _ = try string.insertVisualOne(allocator, 'l', 3); // 👉 "👨‍🏭Hello!"
        _ = try string.insertVisualOne(allocator, ' ', 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = try string.insertVisualOne(allocator, '@', 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.insert`](./insert.md)

  > [`uString.insertOne`](./insertOne.md)

  > [`uString.insertVisual`](./insertVisual.md)

  > [`uString.append`](./append.md)

  > [`uString.appendOne`](./appendOne.md)

  > [`uString.prepend`](./prepend.md)

  > [`uString.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>