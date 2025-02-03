# [←](../String.md) `String`.`appendOne`

> Appends a `byte` into the `String` instance.

```zig
pub fn appendOne(self: *Self, byte: u8) insertError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `String` instance. |
    | `byte`    | `u8`    | The byte to insert.    |

- #### 🚫 Errors

    | Error            | Reason                           |
    | ---------------- | -------------------------------- |
    | `AllocatorError` | The allocator returned an error. |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 7);
    defer string.deinit();
    ```

    ```zig
    _ = try string.appendOne('H'); // 👉 "H"
    _ = try string.appendOne('e'); // 👉 "He"
    _ = try string.appendOne('l'); // 👉 "Hel"
    _ = try string.appendOne('l'); // 👉 "Hell"
    _ = try string.appendOne('o'); // 👉 "Hello"
    _ = try string.appendOne(' '); // 👉 "Hello "
    _ = try string.appendOne('!'); // 👉 "Hello !"
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

  > [`String.append`](./append.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>