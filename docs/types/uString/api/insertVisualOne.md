# [←](../uString.md) `uString`.`insertVisualOne`

> Inserts a `byte` into the `uString` instance at the specified `visual position`.

```zig
pub fn insertVisualOne(self: *Self, allocator: Allocator, byte: u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "👨‍🏭");
    defer string.deinit(allocator);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.insertVisualOne(allocator, 'H', 1); // 👉 "👨‍🏭H"
        try string.insertVisualOne(allocator, '!', 2); // 👉 "👨‍🏭H!"
        try string.insertVisualOne(allocator, 'o', 2); // 👉 "👨‍🏭Ho!"
        try string.insertVisualOne(allocator, 'l', 2); // 👉 "👨‍🏭Hlo!"
        try string.insertVisualOne(allocator, 'e', 2); // 👉 "👨‍🏭Helo!"
        try string.insertVisualOne(allocator, 'l', 3); // 👉 "👨‍🏭Hello!"
        try string.insertVisualOne(allocator, ' ', 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insertVisualOne(allocator, '@', 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>