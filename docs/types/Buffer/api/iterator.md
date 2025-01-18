# [←](../Buffer.md) `Buffer`.`iterator`

> Creates an iterator for traversing the UTF-8 bytes.

```zig
pub fn iterator(self: Self) utf8.Iterator.Error!utf8.Iterator
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description            |
    | --------- | ------ | ---------------------- |
    | `self`    | `Self` | The `Buffer` instance. |

- #### 🚫 Errors
    
    | Error                 | Reason                       |
    | --------------------- | ---------------------------- |
    | `utf8.Iterator.Error` | if the initialization failed |

- #### ✨ Returns : [`utf8.Iterator`](../../../utils/utf8/api/Iterator.md)

    > Returns an iterator for traversing the UTF-8 bytes of the `Buffer` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    ```

    - ##### 🟢 Success Cases

        ```zig
        const myBuffer = try Buffer.init(64, "..");
        _ = try myBuffer.iterator();
        ```

    - ##### 🔴 Failure Cases
        
        > if the initilization failed, returns `utf8.Iterator.Error`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)
  
  > [`io.utils.utf8.Iterator`](../../../utils/utf8/api/Iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>