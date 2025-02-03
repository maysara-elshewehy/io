# [←](../String.md) `String`.`insertVisual`

> Inserts a `slice` into the `String` instance at the specified `visual position`.

```zig
pub fn insertVisual(self: *Self, slice: []const u8, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                       |
    | --------- | ------------ | --------------------------------- |
    | `self`    | `*Self`      | The `String` instance.            |
    | `slice`   | `[]const u8` | The slice to insert.              |
    | `pos`     | `usize`      | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                     |
    | ----------------- | ------------------------------------------ |
    | `AllocatorError`  | The allocator returned an error.           |
    | `InvalidPosition` | The position is invalid.                   |
    | `OutOfRange`      | The `pos` is greater than `String` length. |

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

    - ##### 🟢 Success Cases

        ```zig
        try string.insertVisual("H",   0); // 👉 "H"
        try string.insertVisual("👨‍🏭",  1); // 👉 "H👨‍🏭"
        try string.insertVisual("o",   1); // 👉 "Ho👨‍🏭"
        try string.insertVisual("ell", 1); // 👉 "Hello👨‍🏭"
        try string.insertVisual(" ",   5); // 👉 "Hello 👨‍🏭"
        try string.insertVisual("!",   7); // 👉 "Hello 👨‍🏭!"
        ```
    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insertVisual("@", 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.insert`](./insert.md)

  > [`String.insertOne`](./insertOne.md)

  > [`String.insertVisualOne`](./insertVisualOne.md)

  > [`String.append`](./append.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>