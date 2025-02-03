# [←](../String.md) `String`.`iterator`

> Creates an iterator for traversing the unicode bytes.

```zig
pub fn iterator(self: Self) Unicode.Iterator.Error!Unicode.Iterator
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description            |
    | --------- | ------ | ---------------------- |
    | `self`    | `Self` | The `String` instance. |

- #### 🚫 Errors

    | Error                 | Reason                       |
    | --------------------- | ---------------------------- |
    | `Unicode.Iterator.Error` | if the initialization failed |

- #### ✨ Returns : [`Unicode.Iterator`](../../../utils/Unicode/api/Iterator.md)

    > Returns an iterator for traversing the unicode bytes of the `String` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const string = try String.init(allocator, "..");
        defer string.deinit();

        _ = try string.iterator();
        ```

    - ##### 🔴 Failure Cases

        > if the initilization failed, returns `Unicode.Iterator.Error`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.deinit`](./deinit.md)

  > [`io.utils.Unicode.Iterator`](../../../utils/Unicode/api/Iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>