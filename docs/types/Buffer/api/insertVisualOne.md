# [←](../Buffer.md) `Buffer`.`insertVisualOne`

> Inserts a `byte` into the `Buffer` instance at the specified `visual position`.

```zig
pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                       |
    | --------- | ------- | --------------------------------- |
    | `self`    | `*Self` | The `Buffer` instance.            |
    | `byte`    | `u8`    | The byte to insert.               |
    | `pos`     | `usize` | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                                     |
    | ----------------- | ---------------------------------------------------------- |
    | `InvalidPosition` | The position is invalid.                                   |
    | `OutOfRange`      | The insertion exceeds the bounds of the `Buffer` instance. |
    | `OutOfRange`      | The `pos` is greater than `Buffer` length.                 |

- #### ✨ Returns : `void`

    > Modifies the `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(18, "👨‍🏭");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try buffer.insertVisualOne('H', 1); // 👉 "👨‍🏭H"
        try buffer.insertVisualOne('!', 2); // 👉 "👨‍🏭H!"
        try buffer.insertVisualOne('o', 2); // 👉 "👨‍🏭Ho!"
        try buffer.insertVisualOne('l', 2); // 👉 "👨‍🏭Hlo!"
        try buffer.insertVisualOne('e', 2); // 👉 "👨‍🏭Helo!"
        try buffer.insertVisualOne('l', 3); // 👉 "👨‍🏭Hello!"
        try buffer.insertVisualOne(' ', 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = buffer.insertVisualOne('@', 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.insert`](./insert.md)

  > [`Buffer.insertOne`](./insertOne.md)

  > [`Buffer.insertVisual`](./insertVisual.md)

  > [`Buffer.append`](./append.md)

  > [`Buffer.appendOne`](./appendOne.md)

  > [`Buffer.prepend`](./prepend.md)

  > [`Buffer.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>