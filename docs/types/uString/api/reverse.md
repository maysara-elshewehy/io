# [←](../uString.md) `uString`.`reverse`

> Reverses the order of the characters **_(considering unicode)_**.

```zig
pub fn reverse(self: *Self, allocator: Allocator) AllocatorError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description             |
    | ----------- | ------------------- | ----------------------- |
    | `self`      | `*Self`             | The `uString` instance. |
    | `allocator` | `std.mem.Allocator` | The allocator to use.   |

- #### 🚫 Errors

    | Error            | Reason                           |
    | ---------------- | -------------------------------- |
    | `AllocatorError` | The allocator returned an error. |

- #### ✨ Returns : `void`

    > Modifies the `uString` instance in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    ```zig
    try string.reverse(allocator); // 👉 "ّ!👨‍🏭 olleH"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>