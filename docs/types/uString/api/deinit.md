# [←](../uString.md) `uString`.`deinit`

> Release all allocated memory.

```zig
pub fn deinit(self: *Self, allocator: Allocator) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description             |
    | ----------- | ------------------- | ----------------------- |
    | `self`      | `*Self`             | The `uString` instance. |
    | `allocator` | `std.mem.Allocator` | The allocator to use.   |

- #### ✨ Returns : `void`

    > Deallocates the allocated memory.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.uString;
    ```

    - ##### 🟢 Success Cases

        ```zig
        var myString = try uString.init(allocator, "..");   // allocate
        defer myString.deinit(allocator);                   // deallocate
        ```

    - ##### 🔴 Failure Cases

        > **_Common misuse of `deinit`._**

        ```zig
        const myString = try uString.initCapacity(allocator, 64);
        defer myString.deinit(allocator); // `myString` should be mutable `var`.
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.initCapacity`](./initCapacity.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>