# [←](../String.md) `String`.`initAlloc`

> Initializes a new `String` instance with the given `allocator`.

```zig
pub fn initAlloc(allocator: Allocator) Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description           |
    | ----------- | ------------------- | --------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use. |

- #### 🚫 Errors

    | Error                     | Reason                           |
    | ------------------------- | -------------------------------- |
    | `std.mem.Allocator.Error` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Produces an empty `String` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const string = try String.initAlloc(allocator);
        defer string.deinit();

        _ = string.length();   // 👉 0
        _ = string.capacity; // 👉 0
        ```

    - ##### 🔴 Failure Cases

        > if the allocation failed (e.g. due to OOM): **_std.mem.Allocator.Error.errorName._**

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.initCapacity`](./initCapacity.md)

  > [`String.deinit`](./deinit.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>