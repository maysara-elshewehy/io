# [←](../Buffer.md) `Buffer`.`insert`

> Inserts a `slice` into the `Buffer` instance at the specified `position` by **real position**.

```zig
pub fn insert(self: *Self, slice: []const u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                |
    | --------- | ------------ | -------------------------- |
    | `self`    | `*Self`      | The `Buffer` instance.     |
    | `slice`   | `[]const u8` | The slice to insert.       |
    | `pos`     | `usize`      | The position to insert at. |

- #### 🚫 Errors

    | Error          | Reason                                                     |
    | -------------- | ---------------------------------------------------------- |
    | `OutOfRange`   | The insertion exceeds the bounds of the `Buffer` instance. |
    | `OutOfRange`   | The `pos` is greater than `Buffer` length.                 |

- #### ✨ Returns : `void`

    > Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.initCapacity(18);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try buffer.insert("H",   0); // 👉 "H"
        try buffer.insert("!",   1); // 👉 "H!"
        try buffer.insert("o",   1); // 👉 "Ho!"
        try buffer.insert("ell", 1); // 👉 "Hello!"
        try buffer.insert(" ",   5); // 👉 "Hello !"
        try buffer.insert("👨‍🏭",  6); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = buffer.insert("@", 17); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.initCapacity`](./initCapacity.md)

  > [`Buffer.insertOne`](./insertOne.md)

  > [`Buffer.insertVisual`](./insertVisual.md)

  > [`Buffer.insertVisualOne`](./insertVisualOne.md)

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