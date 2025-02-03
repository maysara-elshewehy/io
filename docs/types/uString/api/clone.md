# [←](../uString.md) `uString`.`clone`

> Returns a copy of the `uString` instance.

```zig
pub fn clone(self: Self, allocator: Allocator) AllocatorError!Self
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description             |
    | ----------- | ------------------- | ----------------------- |
    | `self`      | `Self`              | The `uString` instance. |
    | `allocator` | `std.mem.Allocator` | The allocator to use.   |

- #### 🚫 Errors

    | Error            | Reason                           |
    | ---------------- | -------------------------------- |
    | `AllocatorError` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Creates and returns a new `uString` instance that is a copy of the current `uString` instance.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    ```

    ```zig
    const string_one = try uString.init(allocator, ".."); // 👉 size: 4, length: 2, written bytes: ".."
    defer string_one.deinit(allocator);

    const string_two = try string_one.clone(allocator);   // 👉 size: 4, length: 2, written bytes: ".."
    defer string_two.deinit(allocator);
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>