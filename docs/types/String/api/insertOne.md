# [←](../String.md) `String`.`insertOne`

> Inserts a `byte` into the `String` instance at the specified `position` by **real position**.

```zig
pub fn insertOne(self: *Self, byte: u8, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description                |
    | --------- | ------- | -------------------------- |
    | `self`    | `*Self` | The `String` instance.     |
    | `byte`    | `u8`    | The byte to insert.        |
    | `pos`     | `usize` | The position to insert at. |

- #### 🚫 Errors
    
    | Error             | Reason                                     |
    | ----------------- | ------------------------------------------ |
    | `AllocatorError` | The allocator returned an error.           |
    | `InvalidValue`    | The `byte` is not valid UTF-8.             |
    | `OutOfRange`      | The `pos` is greater than `String` length. |

- #### ✨ Returns : `void`

    > Modifies the `String` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.initCapacity(allocator, 7);
    defer string.deinit();
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try string.insertOne('H', 0); // 👉 "H"
        _ = try string.insertOne('!', 1); // 👉 "H!"
        _ = try string.insertOne('o', 1); // 👉 "Ho!"
        _ = try string.insertOne('l', 1); // 👉 "Hello!"
        _ = try string.insertOne('e', 1); // 👉 "Hello!"
        _ = try string.insertOne('l', 2); // 👉 "Hello!"
        _ = try string.insertOne(' ', 5); // 👉 "Hello !"
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try string.insertOne('\x80', 0); // 👉 error.InvalidValue
        ```
        
        > **_OutOfRange._**

        ```zig
        _ = try String.insertOne('@', 99); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>