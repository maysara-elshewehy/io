# [←](../Viewer.md) `Viewer`.`equals`

> Returns true if the `Viewer` instance equals the given `target`.

```zig
pub fn equals(self: Self, target: []const u8) bool
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                 |
    | --------- | ------------ | --------------------------- |
    | `self`    | `Self`       | The `Viewer` instance.      |
    | `target`  | `[]const u8` | The string to compare with. |

- #### ✨ Returns : `bool`

    > Returns true if the `Viewer` instance is equal to `target`.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Viewer = @import("io").types.Viewer;
    const viewerA = Viewer.init("A");
    const viewerB = Viewer.init("B");
    ```

    ```zig
    _ = viewerA.equals(viewerA.slice());    // 👉 true
    _ = viewerA.equals(viewerB.slice());    // 👉 false
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Viewer.init`](./init.md)

  > [`Viewer.isEmpty`](./isEmpty.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>