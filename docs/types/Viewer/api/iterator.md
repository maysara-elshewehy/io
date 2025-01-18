# [←](../Viewer.md) `Viewer`.`iterator`

> Creates an iterator for traversing the UTF-8 bytes.

```zig
pub fn iterator(self: Self) utf8.Iterator
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description            |
    | --------- | ------ | ---------------------- |
    | `self`    | `Self` | The `Viewer` instance. |

- #### ✨ Returns : [`utf8.Iterator`](../../../utils/utf8/api/Iterator.md)

    > Returns an iterator for traversing the UTF-8 bytes of the `Viewer` instance.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    ```

    ```zig
    const myViewer = try Viewer.init("..");
    _ = myViewer.iterator(); 
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)
  
  > [`io.utils.utf8.Iterator`](../../../utils/utf8/api/Iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>