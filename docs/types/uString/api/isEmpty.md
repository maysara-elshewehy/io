# [←](../uString.md) `uString`.`isEmpty`

> Returns true if the `uString` instance is empty.

```zig
pub fn isEmpty(self: Self) bool
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description            |
    | --------- | ------ | ---------------------- |
    | `self`    | `Self` | The `uString` instance. |

- #### ✨ Returns : `bool`

    > Returns true if the `uString` instance is empty.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;

    const empty    = try uString.init(allocator, "");
    defer empty.deinit(allocator);

    const nonEmpty = try uString.init(allocator, "Hello, World!");
    defer nonEmpty.deinit(allocator);
    ```

    ```zig
    _ = empty.isEmpty();    // 👉 true
    _ = nonEmpty.isEmpty(); // 👉 false
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.equals`](./equals.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>