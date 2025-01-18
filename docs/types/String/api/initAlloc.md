# [←](../String.md) `String`.`initAlloc`

> Initializes a new `String` instance with the given `allocator`.

```zig
pub fn initAlloc(allocator: Allocator) Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type                | Description                      |
    | ----------- | ------------------- | -------------------------------- |
    | `allocator` | `std.mem.Allocator` | The allocator to use.            |

- #### 🚫 Errors
    
    | Error                     | Reason                           |
    | ------------------------- | -------------------------------- |
    | `std.mem.Allocator.Error` | The allocator returned an error. |

- #### ✨ Returns : `Self`

    > Produces an empty `String` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const myString = try String.initAlloc(allocator);
        defer myString.deinit();

        _ = myString.length;   // 👉 0
        _ = myString.capacity; // 👉 0
        ```

    - ##### 🔴 Failure Cases
        
        > if the allocation failed (e.g. due to OOM): **_std.mem.Allocator.Error.errorName._**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.initCapacity`](./initCapacity.md)
  
  > [`String.deinit`](./deinit.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>