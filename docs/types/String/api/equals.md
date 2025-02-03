# [←](../String.md) `String`.`equals`

> Returns true if the `String` instance equals the given `target`.

```zig
pub fn equals(self: Self, target: []const u8) bool
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                 |
    | --------- | ------------ | --------------------------- |
    | `self`    | `Self`       | The `String` instance.      |
    | `target`  | `[]const u8` | The string to compare with. |

- #### ✨ Returns : `bool`

    > Returns true if the `String` instance is equal to `target`.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;

    const stringA = try String.init(allocator, "A");
    defer stringA.deinit();

    const stringB = try String.init(allocator, "B");
    defer stringB.deinit();
    ```

    ```zig
    _ = stringA.equals(stringA.slice());  // 👉 true
    _ = stringA.equals(stringB.slice());  // 👉 false
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.isEmpty`](./isEmpty.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>