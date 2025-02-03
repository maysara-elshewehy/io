# [←](../String.md) `String`.`init`

> Initializes a new `String` instance with the given `allocator` and `value`.

```zig
pub fn init(allocator: Allocator, value: []const u8) initError!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                           |
    | ----------- | ------------------- | ------------------------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use.                 |
    | `value`     | `[]const u8`        | The unicode encoded bytes to be viewed. |

- #### 🚫 Errors

    | Error                     | Reason                           |
    | ------------------------- | -------------------------------- |
    | `ZeroSize`                | The `size` is 0.                 |
    | `std.mem.Allocator.Error` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Produces a `String` instance initialized with the given size.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const myString = try String.init(allocator, "Hello World!");
        defer myString.deinit();

        _ = myString.length;   // 👉 12
        _ = myString.capacity; // 👉 24
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = String.init(allocator, ""); // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initAlloc`](./initAlloc.md)

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.deinit`](./deinit.md)

  > [`String.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>