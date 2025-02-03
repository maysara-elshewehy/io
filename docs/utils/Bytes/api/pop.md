# [←](../Bytes.md) `Bytes`.`pop`

> Returns the length of the last grapheme cluster at the `dest`.

```zig
pub fn pop(dest: []const u8) usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description                |
    | --------- | ------------ | -------------------------- |
    | `dest`    | `[]const u8` | The destination to handle. |

- #### ✨ Returns : `usize`

    > Returns the length of the last grapheme cluster at the `dest`.

    > **The function will not remove anything.**

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(18, "Hello 👨‍🏭!");
    ```

    > This function does not delete or modify anything, it just returns the number of bytes that were supposed to be removed.
    >
    > It is designed to be used inline with other functions, so it should not be useful in your case.

    ```zig
    _ = Bytes.pop(array[0..18]);  // 👉 (1  for '!' ), "Hello 👨‍🏭"
    _ = Bytes.pop(array[0..17]);  // 👉 (11 for '👨‍🏭'), "Hello "
    _ = Bytes.pop(array[0..6]);   // 👉 (1  for ' ' ), "Hello"
    _ = Bytes.pop(array[0..5]);   // 👉 (1  for 'o' ), "Hell"
    _ = Bytes.pop(array[0..4]);   // 👉 (1  for 'l' ), "Hel"
    _ = Bytes.pop(array[0..3]);   // 👉 (1  for 'l' ), "He"
    _ = Bytes.pop(array[0..2]);   // 👉 (1  for 'e' ), "H"
    _ = Bytes.pop(array[0..1]);   // 👉 (1  for 'H' ), ""
    _ = Bytes.pop(array[0..0]);   // 👉 (0  for ''  ), ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.shift`](./shift.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>