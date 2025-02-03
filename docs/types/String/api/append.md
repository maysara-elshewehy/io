# [←](../String.md) `String`.`append`

> Appends a `slice` into the `String` instance.

```zig
pub fn append(self: *Self, slice: []const u8) insertError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description            |
    | --------- | ------------ | ---------------------- |
    | `self`    | `*Self`      | The `String` instance. |
    | `slice`   | `[]const u8` | The slice to insert.   |

- #### 🚫 Errors

    | Error            | Reason                                         |
    | ---------------- | ---------------------------------------------- |
    | `AllocatorError` | The allocator returned an error.               |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 18);
    defer string.deinit();
    ```

    ```zig
    _ = try string.append("H");   // 👉 "H"
    _ = try string.append("e");   // 👉 "He"
    _ = try string.append("llo"); // 👉 "Hello"
    _ = try string.append(" ");   // 👉 "Hello "
    _ = try string.append("👨‍🏭");  // 👉 "Hello 👨‍🏭"
    _ = try string.append("!");   // 👉 "Hello 👨‍🏭!"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.insert`](./insert.md)

  > [`String.insertOne`](./insertOne.md)

  > [`String.insertVisual`](./insertVisual.md)

  > [`String.insertVisualOne`](./insertVisualOne.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>