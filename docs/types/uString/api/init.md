# [←](../uString.md) `uString`.`init`

> Initializes a new `uString` instance using `allocator` and `value`.

```zig
pub fn init(alloator: Allocator, value: []const u8) initError!Self 
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                           |
    | ----------- | ------------------- | ------------------------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use.                 |
    | `value`     | `[]const u8`        | The UTF-8 encoded bytes to be viewed. |

- #### 🚫 Errors
    
    | Error                     | Reason                           |
    | ------------------------- | -------------------------------- |
    | `ZeroSize`                | The `size` is 0.                 |
    | `InvalidValue`            | The `value` is not valid UTF-8.  |
    | `std.mem.Allocator.Error` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Produces a `uString` instance initialized using the given size.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    ```

    - ##### 🟢 Success Cases

        ```zig
        var myString = try uString.init(allocator, "Hello World!");
        defer myString.deinit(allocator);

        _ = myString.length;   // 👉 12
        _ = myString.capacity; // 👉 24
        ```

    - ##### 🔴 Failure Cases
        
        > **_ZeroSize._**

        ```zig
        _ = try uString.init(allocator, ""); // 👉 error.ZeroSize
        ```

        > **_InvalidValue._**

        ```zig
        const invalidUtf8 = &[_]u8{0x80, 0x81, 0x82};
        _ = try uString.init(allocator, invalidUtf8); // 👉 error.InvalidValue
        ```

        > if the allocation failed (e.g. due to OOM): **_std.mem.Allocator.Error.errorName._**
        
<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.initCapacity`](./initCapacity.md)

  > [`uString.deinit`](./deinit.md)

  > [`uString.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>