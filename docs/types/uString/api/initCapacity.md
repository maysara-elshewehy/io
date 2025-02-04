# [←](../uString.md) `uString`.`initCapacity`

> Initializes a new `uString` instance using `allocator` and `size`.

```zig
pub fn initCapacity(allocator: Allocator, size: usize) initCapacityError!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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

    > Produces a `uString` instance initialized using the given size.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    ```

    - ##### 🟢 Success Cases

        ```zig
        var string = try uString.initCapacity(allocator, 64);
        defer string.deinit(allocator);

        _ = string.length();   // 👉 0
        _ = string.capacity; // 👉 64
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = uString.initCapacity(allocator, 0); // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.deinit`](./deinit.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>