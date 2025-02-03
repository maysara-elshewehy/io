# [←](../Buffer.md) `Buffer`.`insertOne`

> Inserts a `byte` into the `Buffer` instance at the specified `position` by **real position**.

```zig
pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                |
    | --------- | ------- | -------------------------- |
    | `self`    | `*Self` | The `Buffer` instance.     |
    | `byte`    | `u8`    | The byte to insert.        |
    | `pos`     | `usize` | The position to insert at. |

- #### 🚫 Errors

    | Error          | Reason                                                     |
    | -------------- | ---------------------------------------------------------- |
    | `OutOfRange`   | The insertion exceeds the bounds of the `Buffer` instance. |
    | `OutOfRange`   | The `pos` is greater than `Buffer` length.                 |

- #### ✨ Returns : `void`

    > Modifies the `Buffer` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.initCapacity(7);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try buffer.insertOne('H', 0); // 👉 "H"
        try buffer.insertOne('!', 1); // 👉 "H!"
        try buffer.insertOne('o', 1); // 👉 "Ho!"
        try buffer.insertOne('l', 1); // 👉 "Hello!"
        try buffer.insertOne('e', 1); // 👉 "Hello!"
        try buffer.insertOne('l', 2); // 👉 "Hello!"
        try buffer.insertOne(' ', 5); // 👉 "Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Buffer.insertOne('@', 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.initCapacity`](./initCapacity.md)

  > [`Buffer.insert`](./insert.md)

  > [`Buffer.insertVisual`](./insertVisual.md)

  > [`Buffer.insertVisualOne`](./insertVisualOne.md)

  > [`Buffer.append`](./append.md)

  > [`Buffer.appendOne`](./appendOne.md)

  > [`Buffer.prepend`](./prepend.md)

  > [`Buffer.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>