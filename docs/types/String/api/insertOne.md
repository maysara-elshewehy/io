# [←](../String.md) `String`.`insertOne`

> Inserts a `byte` into the `String` instance at the specified `position` by **real position**.

```zig
pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                |
    | --------- | ------- | -------------------------- |
    | `self`    | `*Self` | The `String` instance.     |
    | `byte`    | `u8`    | The byte to insert.        |
    | `pos`     | `usize` | The position to insert at. |

- #### 🚫 Errors

    | Error            | Reason                                     |
    | ---------------- | ------------------------------------------ |
    | `AllocatorError` | The allocator returned an error.           |
    | `OutOfRange`     | The `pos` is greater than `String` length. |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 7);
    defer string.deinit();
    ```

    - ##### 🟢 Success Cases

        ```zig
        try string.insertOne('H', 0); // 👉 "H"
        try string.insertOne('!', 1); // 👉 "H!"
        try string.insertOne('o', 1); // 👉 "Ho!"
        try string.insertOne('l', 1); // 👉 "Hello!"
        try string.insertOne('e', 1); // 👉 "Hello!"
        try string.insertOne('l', 2); // 👉 "Hello!"
        try string.insertOne(' ', 5); // 👉 "Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = string.insertOne('@', 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.insert`](./insert.md)

  > [`String.insertVisual`](./insertVisual.md)

  > [`String.insertVisualOne`](./insertVisualOne.md)

  > [`String.append`](./append.md)

  > [`String.appendOne`](./appendOne.md)

  > [`String.prepend`](./prepend.md)

  > [`String.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>