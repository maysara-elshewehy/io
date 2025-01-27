# [←](../Viewer.md) `Viewer`.`init`

> Initializes a new Viewer instance with the given UTF-8 bytes.

```zig
pub fn init(value: []const u8) initError!Self
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                           |
    | --------- | ------------ | ------------------------------------- |
    | `value`   | `[]const u8` | The UTF-8 encoded bytes to be viewed. |

- #### 🚫 Errors

    | Error          | Reason                          |
    | -------------- | ------------------------------- |
    | `ZeroSize`     | The `value` length is 0.        |

- #### ✨ Returns : `Self`

    > Produces a `Viewer` instance initialized with the given UTF-8 bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Viewer.init("..");
        ```

    - ##### 🔴 Failure Cases

        > **_ZeroSize._**

        ```zig
        _ = try Viewer.init("");            // 👉 error.ZeroSize
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.iterator`](./iterator.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>