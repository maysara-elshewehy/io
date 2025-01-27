# [←](../uString.md) `uString`.`pop`

> Removes the last grapheme cluster at the `uString` instance, Returns removed slice.

```zig
pub fn pop(self: *Self) ?[]const u8
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type    | Description            |
    | --------- | ------- | ---------------------- |
    | `self`    | `*Self` | The `uString` instance. |

- #### ✨ Returns : `?[]const u8`

    > Returns the removed slice or `null`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.shift`](./shift.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>