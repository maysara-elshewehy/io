# [←](../String.md) `String`.`init`

> Initializes a new `String` instance with the given `allocator` and `value`.

```zig
pub fn init(allocator: Allocator, value: []const u8) initError!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                           |
    | ----------- | ------------------- | ------------------------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use.                 |
    | `value`     | `[]const u8`        | The unicode encoded bytes to be viewed. |

- #### 🚫 Errors

    | Error                     | Reason                           |
    | ------------------------- | -------------------------------- |
    | `std.mem.Allocator.Error` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Produces a `String` instance initialized with the given size.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

    - ##### 🟢 Success Cases

        > nonEmpty.

        ```zig
        var string = try String.init(allocator, "Hello World!");
        defer string.deinit();

        _ = string.length();   // 👉 12
        _ = string.capacity; // 👉 24
        ```

        > Empty

        ```zig
        var string = try String.init(allocator, "");
        defer string.deinit();

        _ = string.length();   // 👉 0
        _ = string.capacity; // 👉 0
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.initAlloc`](./initAlloc.md)

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.deinit`](./deinit.md)

  > [`String.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>