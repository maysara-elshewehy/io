# [←](../String.md) `String`.`pop`

> Removes the last grapheme cluster at the `String` instance, Returns removed slice.

```zig
pub fn pop(self: *Self) ?[]const u8
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `String` instance. |

- #### ✨ Returns : `?[]const u8`

    > Returns the removed slice or `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const String = @import("io").types.String;
    var string = try String.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit();
    ```

    ```zig
    _ = string.pop().?; // 👉 ('!' ), "Hello 👨‍🏭"
    _ = string.pop().?; // 👉 ('👨‍🏭'), "Hello "
    _ = string.pop().?; // 👉 (' ' ), "Hello"
    _ = string.pop().?; // 👉 ('o' ), "Hell"
    _ = string.pop().?; // 👉 ('l' ), "Hel"
    _ = string.pop().?; // 👉 ('l' ), "He"
    _ = string.pop().?; // 👉 ('e' ), "H"
    _ = string.pop().?; // 👉 ('H' ), ""
    _ = string.pop();   // 👉 null
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`String.init`](./init.md)

  > [`String.shift`](./shift.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>