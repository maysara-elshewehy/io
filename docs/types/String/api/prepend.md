# [←](../String.md) `String`.`prepend`

> Prepends a `slice` into the `String` instance.

```zig
pub fn prepend(self: *Self, slice: []const u8) prependError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description            |
    | --------- | ------------ | ---------------------- |
    | `self`    | `*Self`      | The `String` instance. |
    | `slice`   | `[]const u8` | The slice to insert.   |

- #### 🚫 Errors
    
    | Error             | Reason                                         |
    | ----------------- | ---------------------------------------------- |
    | `AllocatorError` | The allocator returned an error.               |
    | `InvalidValue`    | The `slice` contains invalid UTF-8 characters. |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 18);
    defer string.deinit();
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try string.prepend("H");   // 👉 "H"
        _ = try string.prepend("e");   // 👉 "eH"
        _ = try string.prepend("oll"); // 👉 "olleH"
        _ = try string.prepend(" ");   // 👉 " olleH"
        _ = try string.prepend("👨‍🏭");  // 👉 "👨‍🏭 olleH"
        _ = try string.prepend("!");   // 👉 "!👨‍🏭 olleH"
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try string.prepend("\x80"); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>