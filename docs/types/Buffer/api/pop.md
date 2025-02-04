# [←](../Buffer.md) `Buffer`.`pop`

> Removes the last grapheme cluster at the `Buffer` instance, Returns removed slice.

```zig
pub fn pop(self: *Self) ?[]const u8
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `Buffer` instance. |

- #### ✨ Returns : `?[]const u8`

    > Returns the removed slice or `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Buffer = @import("io").types.Buffer;
    var buffer = try Buffer.init(18, "Hello 👨‍🏭!");
    ```

    ```zig
    _ = buffer.pop().?; // 👉 ('!' ), "Hello 👨‍🏭"
    _ = buffer.pop().?; // 👉 ('👨‍🏭'), "Hello "
    _ = buffer.pop().?; // 👉 (' ' ), "Hello"
    _ = buffer.pop().?; // 👉 ('o' ), "Hell"
    _ = buffer.pop().?; // 👉 ('l' ), "Hel"
    _ = buffer.pop().?; // 👉 ('l' ), "He"
    _ = buffer.pop().?; // 👉 ('e' ), "H"
    _ = buffer.pop().?; // 👉 ('H' ), ""
    _ = buffer.pop();   // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Buffer.init`](./init.md)

  > [`Buffer.shift`](./shift.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>