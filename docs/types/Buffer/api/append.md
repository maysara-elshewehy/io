# [←](../Buffer.md) `Buffer`.`append`

> Appends a `slice` into the `Buffer` instance.

```zig
pub fn append(self: *Self, slice: []const u8) appendError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description            |
    | --------- | ------------ | ---------------------- |
    | `self`    | `*Self`      | The `Buffer` instance. |
    | `slice`   | `[]const u8` | The slice to insert.   |

- #### 🚫 Errors
    
    | Error          | Reason                                                     |
    | -------------- | ---------------------------------------------------------- |
    | `InvalidValue` | The `slice` contains invalid UTF-8 characters.             |
    | `OutOfRange`   | The insertion exceeds the bounds of the `Buffer` instance. |

- #### ✨ Returns : `void`

    > Modifies the `Buffer` instance in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.initCapacity(18);
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try buffer.append("H");   // 👉 "H"
        _ = try buffer.append("e");   // 👉 "He"
        _ = try buffer.append("llo"); // 👉 "Hello"
        _ = try buffer.append(" ");   // 👉 "Hello "
        _ = try buffer.append("👨‍🏭");  // 👉 "Hello 👨‍🏭"
        _ = try buffer.append("!");   // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try buffer.append("\x80"); // 👉 error.InvalidValue
        ```

        > **_OutOfRange._**

        ```zig
        _ = try buffer.append("@"); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>