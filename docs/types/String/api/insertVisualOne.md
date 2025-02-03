# [←](../String.md) `String`.`insertVisualOne`

> Inserts a `byte` into the `String` instance at the specified `visual position`.

```zig
pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                       |
    | --------- | ------- | --------------------------------- |
    | `self`    | `*Self` | The `String` instance.            |
    | `byte`    | `u8`    | The byte to insert.               |
    | `pos`     | `usize` | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                     |
    | ----------------- | ------------------------------------------ |
    | `AllocatorError`  | The allocator returned an error.           |
    | `InvalidPosition` | The position is invalid.                   |
    | `OutOfRange`      | The `pos` is greater than `String` length. |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "👨‍🏭");
    defer string.deinit();
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.insertVisualOne('H', 1); // 👉 "👨‍🏭H"
        try string.insertVisualOne('!', 2); // 👉 "👨‍🏭H!"
        try string.insertVisualOne('o', 2); // 👉 "👨‍🏭Ho!"
        try string.insertVisualOne('l', 2); // 👉 "👨‍🏭Hlo!"
        try string.insertVisualOne('e', 2); // 👉 "👨‍🏭Helo!"
        try string.insertVisualOne('l', 3); // 👉 "👨‍🏭Hello!"
        try string.insertVisualOne(' ', 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insertVisualOne('@', 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.insert`](./insert.md)

  > [`String.insertOne`](./insertOne.md)

  > [`String.insertVisual`](./insertVisual.md)

  > [`String.append`](./append.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>