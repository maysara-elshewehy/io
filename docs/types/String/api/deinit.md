# [←](../String.md) `String`.`deinit`

> Release all allocated memory.

```zig
pub fn deinit(self: Self) void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description            |
    | --------- | ------ | ---------------------- |
    | `self`    | `Self` | The `String` instance. |

- #### ✨ Returns : `void`

    > Deallocates the allocated memory.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

        ```zig
        const string = try String.init(allocator, "..");  // allocate
        defer string.deinit();                            // deallocate
        ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.initAlloc`](./initAlloc.md)

  > [`String.initCapacity`](./initCapacity.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>