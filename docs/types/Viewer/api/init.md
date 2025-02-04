# [←](../Viewer.md) `Viewer`.`init`

> Initializes a new Viewer instance with the given unicode bytes.

```zig
pub fn init(value: []const u8) Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                           |
    | --------- | ------------ | ------------------------------------- |
    | `value`   | `[]const u8` | The unicode encoded bytes to be viewed. |

- #### ✨ Returns : `Self`

    > Produces a `Viewer` instance initialized with the given unicode bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    ```

    - ##### 🟢 Success Cases

        > nonEmpty.

        ```zig
        var viewer = try Viewer.init("Hello World!");

        _ = viewer.length(); // 👉 12
        ```

        > Empty

        ```zig
        var viewer = try Viewer.init("");

        _ = viewer.length(); // 👉 0
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>