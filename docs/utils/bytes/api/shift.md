# [←](../bytes.md) `bytes`.`shift`

> Removes the first grapheme cluster at the `dest`, Returns the number of removed bytes.

```zig
pub fn shift(dest: []u8) usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type   | Description                     |
    | --------- | ------ | ------------------------------- |
    | `dest`    | `[]u8` | The destination to remove from. |

- #### ✨ Returns : `usize`

    > Returns the number of removed bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    var array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = Bytes.shift(array[0..18]);  // 👉 (1  for 'H' ), "ello 👨‍🏭!"
    _ = Bytes.shift(array[0..17]);  // 👉 (1  for 'e' ), "llo 👨‍🏭!"
    _ = Bytes.shift(array[0..16]);  // 👉 (1  for 'l' ), "lo 👨‍🏭!"
    _ = Bytes.shift(array[0..15]);  // 👉 (1  for 'l' ), "o 👨‍🏭!"
    _ = Bytes.shift(array[0..14]);  // 👉 (1  for 'o' ), " 👨‍🏭!"
    _ = Bytes.shift(array[0..13]);  // 👉 (1  for ' ' ), "👨‍🏭!"
    _ = Bytes.shift(array[0..12]);  // 👉 (11 for '👨‍🏭'), "!"
    _ = Bytes.shift(array[0..1]);   // 👉 (1  for '!' ), ""
    _ = Bytes.shift(array[0..0]);   // 👉 (0  for ''  ), ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.pop`](./pop.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>