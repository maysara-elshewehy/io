# [←](../uString.md) `uString`.`shift`

> Removes the first grapheme cluster at the `uString` instance, Returns the number of removed Bytes.

```zig
pub fn shift(self: *Self) usize
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `uString` instance. |

- #### ✨ Returns : `usize`

    > Returns the number of removed Bytes.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    ```zig
    _ = string.shift();  // 👉 (1  for 'H' ), "ello 👨‍🏭!"
    _ = string.shift();  // 👉 (1  for 'e' ), "llo 👨‍🏭!"
    _ = string.shift();  // 👉 (1  for 'l' ), "lo 👨‍🏭!"
    _ = string.shift();  // 👉 (1  for 'l' ), "o 👨‍🏭!"
    _ = string.shift();  // 👉 (1  for 'o' ), " 👨‍🏭!"
    _ = string.shift();  // 👉 (1  for ' ' ), "👨‍🏭!"
    _ = string.shift();  // 👉 (11 for '👨‍🏭'), "!"
    _ = string.shift();  // 👉 (1  for '!' ), ""
    _ = string.shift();  // 👉 (0  for ''  ), ""
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.pop`](./pop.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>