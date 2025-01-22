# [←](../String.md) `String`.`prependOne`

> Prepends a `byte` into the `String` instance.

```zig
pub fn prependOne(self: *Self, byte: u8) prependError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `String` instance. |
    | `byte`    | `u8`    | The byte to insert.    |

- #### 🚫 Errors
    
    | Error             | Reason                           |
    | ----------------- | -------------------------------- |
    | `AllocatorError` | The allocator returned an error. |
    | `InvalidValue`    | The `byte` is not valid UTF-8.   |

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
        _ = try string.prependOne('H'); // 👉 "H"
        _ = try string.prependOne('e'); // 👉 "eH"
        _ = try string.prependOne('l'); // 👉 "leH"
        _ = try string.prependOne('l'); // 👉 "lleH"
        _ = try string.prependOne('o'); // 👉 "olleH"
        _ = try string.prependOne(' '); // 👉 " olleH"
        _ = try string.prependOne('!'); // 👉 "! olleH"
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try string.prependOne('\x80'); // 👉 error.InvalidValue
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

  > [`String.prepend`](./prepend.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>