# [←](../Buffer.md) `Buffer`.`shift`

> Removes the first grapheme cluster at the `Buffer` instance, Returns the number of removed Bytes.

```zig
pub fn shift(self: *Self) usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `Buffer` instance. |

- #### ✨ Returns : `usize`

    > Returns the number of removed Bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.shift();  // 👉 (1  for 'H' ), "ello 👨‍🏭!"
    _ = buffer.shift();  // 👉 (1  for 'e' ), "llo 👨‍🏭!"
    _ = buffer.shift();  // 👉 (1  for 'l' ), "lo 👨‍🏭!"
    _ = buffer.shift();  // 👉 (1  for 'l' ), "o 👨‍🏭!"
    _ = buffer.shift();  // 👉 (1  for 'o' ), " 👨‍🏭!"
    _ = buffer.shift();  // 👉 (1  for ' ' ), "👨‍🏭!"
    _ = buffer.shift();  // 👉 (11 for '👨‍🏭'), "!"
    _ = buffer.shift();  // 👉 (1  for '!' ), ""
    _ = buffer.shift();  // 👉 (0  for ''  ), ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.pop`](./pop.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>