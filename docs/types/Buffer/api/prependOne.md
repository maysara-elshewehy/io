# [←](../Buffer.md) `Buffer`.`prependOne`

> Prepends a `byte` into the `Buffer` instance.

```zig
pub fn prependOne(self: *Self, byte: u8) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `Buffer` instance. |
    | `byte`    | `u8`    | The byte to insert.    |

- #### 🚫 Errors

    | Error          | Reason                                                     |
    | -------------- | ---------------------------------------------------------- |
    | `OutOfRange`   | The insertion exceeds the bounds of the `Buffer` instance. |

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
        try buffer.prependOne('H'); // 👉 "H"
        try buffer.prependOne('e'); // 👉 "eH"
        try buffer.prependOne('l'); // 👉 "leH"
        try buffer.prependOne('l'); // 👉 "lleH"
        try buffer.prependOne('o'); // 👉 "olleH"
        try buffer.prependOne(' '); // 👉 " olleH"
        try buffer.prependOne('!'); // 👉 "! olleH"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Buffer.prependOne('@'); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.initCapacity`](./initCapacity.md)

  > [`Buffer.insert`](./insert.md)

  > [`Buffer.insertOne`](./insertOne.md)

  > [`Buffer.insertVisual`](./insertVisual.md)

  > [`Buffer.insertVisualOne`](./insertVisualOne.md)

  > [`Buffer.append`](./append.md)

  > [`Buffer.appendOne`](./appendOne.md)

  > [`Buffer.prepend`](./prepend.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>