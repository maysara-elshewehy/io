# [←](../Buffer.md) `Buffer`.`insertVisualOne`

> Inserts a `byte` into the `Buffer` instance at the specified `visual position`.

```zig
pub fn insertVisualOne(self: *Self, byte: u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(18, "👨‍🏭");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try buffer.insertVisualOne('H', 1); // 👉 "👨‍🏭H"
        _ = try buffer.insertVisualOne('!', 2); // 👉 "👨‍🏭H!"
        _ = try buffer.insertVisualOne('o', 2); // 👉 "👨‍🏭Ho!"
        _ = try buffer.insertVisualOne('l', 2); // 👉 "👨‍🏭Hlo!"
        _ = try buffer.insertVisualOne('e', 2); // 👉 "👨‍🏭Helo!"
        _ = try buffer.insertVisualOne('l', 3); // 👉 "👨‍🏭Hello!"
        _ = try buffer.insertVisualOne(' ', 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = try buffer.insertVisualOne('@', 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>