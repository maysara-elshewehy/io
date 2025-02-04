# [←](../String.md) `String`.`prepend`

> Prepends a `slice` into the `String` instance.

```zig
pub fn prepend(self: *Self, slice: []const u8) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 18);
    defer string.deinit();
    ```

    ```zig
    _ = try string.prepend("H");   // 👉 "H"
    _ = try string.prepend("e");   // 👉 "eH"
    _ = try string.prepend("oll"); // 👉 "olleH"
    _ = try string.prepend(" ");   // 👉 " olleH"
    _ = try string.prepend("👨‍🏭");  // 👉 "👨‍🏭 olleH"
    _ = try string.prepend("!");   // 👉 "!👨‍🏭 olleH"
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.insert`](./insert.md)

  > [`String.insertOne`](./insertOne.md)

  > [`String.insertVisual`](./insertVisual.md)

  > [`String.insertVisualOne`](./insertVisualOne.md)

  > [`String.append`](./append.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>