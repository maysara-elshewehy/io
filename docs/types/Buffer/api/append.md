# [←](../Buffer.md) `Buffer`.`append`

> Appends a `slice` into the `Buffer` instance.

```zig
pub fn append(self: *Self, slice: []const u8) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description            |
    | --------- | ------------ | ---------------------- |
    | `self`    | `*Self`      | The `Buffer` instance. |
    | `slice`   | `[]const u8` | The slice to insert.   |

- #### 🚫 Errors

    | Error        | Reason                                                     |
    | ------------ | ---------------------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of the `Buffer` instance. |

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
        try buffer.append("H");   // 👉 "H"
        try buffer.append("e");   // 👉 "He"
        try buffer.append("llo"); // 👉 "Hello"
        try buffer.append(" ");   // 👉 "Hello "
        try buffer.append("👨‍🏭");  // 👉 "Hello 👨‍🏭"
        try buffer.append("!");   // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = buffer.append("@"); // 👉 error.OutOfRange
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

  > [`Buffer.appendOne`](./appendOne.md)

  > [`Buffer.prepend`](./prepend.md)

  > [`Buffer.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>