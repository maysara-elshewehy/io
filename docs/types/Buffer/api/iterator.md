# [←](../Buffer.md) `Buffer`.`iterator`

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
    | `self`    | `Self` | The `Buffer` instance. |

- #### 🚫 Errors

    | Error                    | Reason                       |
    | ------------------------ | ---------------------------- |
    | `Unicode.Iterator.Error` | if the initialization failed |

- #### ✨ Returns : [`Unicode.Iterator`](../../../utils/Unicode/api/Iterator.md)

    > Returns an iterator for traversing the unicode bytes of the `Buffer` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const buffer = try Buffer.init(64, "..");
        _ = try buffer.iterator();
        ```

    - ##### 🔴 Failure Cases

        > if the initilization failed, returns `Unicode.Iterator.Error`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`io.utils.Unicode.Iterator`](../../../utils/Unicode/api/Iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>