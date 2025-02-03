# [←](../String.md) `String`.`insert`

> Inserts a `slice` into the `String` instance at the specified `position` by **real position**.

```zig
pub fn insert(self: *Self, slice: []const u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                |
    | --------- | ------------ | -------------------------- |
    | `self`    | `*Self`      | The `String` instance.     |
    | `slice`   | `[]const u8` | The slice to insert.       |
    | `pos`     | `usize`      | The position to insert at. |

- #### 🚫 Errors

    | Error            | Reason                                     |
    | ---------------- | ------------------------------------------ |
    | `AllocatorError` | The allocator returned an error.           |
    | `OutOfRange`     | The `pos` is greater than `String` length. |

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
        try string.insert("H",   0); // 👉 "H"
        try string.insert("!",   1); // 👉 "H!"
        try string.insert("o",   1); // 👉 "Ho!"
        try string.insert("ell", 1); // 👉 "Hello!"
        try string.insert(" ",   5); // 👉 "Hello !"
        try string.insert("👨‍🏭",  6); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insert("@", 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.insertOne`](./insertOne.md)

  > [`String.insertVisual`](./insertVisual.md)

  > [`String.insertVisualOne`](./insertVisualOne.md)

  > [`String.append`](./append.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>