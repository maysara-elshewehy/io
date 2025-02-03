# [←](../String.md) `String`.`initCapacity`

> Initializes a new `String` instance with `allocator` and `size`.

```zig
pub fn initCapacity(allocator: Allocator, size: usize) initError!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                      |
    | ----------- | ------------------- | -------------------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use.            |
    | `size`      | `usize`             | The number of bytes to allocate. |

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
        const myString = try String.initCapacity(allocator, 64);
        defer myString.deinit();

        _ = myString.length;   // 👉 0
        _ = myString.capacity; // 👉 64
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = String.initCapacity(allocator, 0); // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.initAlloc`](./initAlloc.md)

  > [`String.deinit`](./deinit.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>