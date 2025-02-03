# [←](../Unicode.md) `utf8`.`utils`.`firstGcLength`

> Returns total length of the first grapheme cluster.

```zig
pub fn firstGcLength(value: []const u8) error{InvalidValue}!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type         | Description          |
    | --------- | ------------ | -------------------- |
    | `value`   | `[]const u8` | The value to handle. |

- #### 🚫 Errors

    | Error          | Reason                                 |
    | -------------- | -------------------------------------- |
    | `InvalidValue` | if the `value` is not a valid Unicode. |

- #### ✨ Returns : `usize`

    > Returns total length of the first grapheme cluster.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Unicode = @import("io").utils.Unicode;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Unicode.utils.firstGcLength("A-");       // 👉  1 (total length of "A")
        _ = try Unicode.utils.firstGcLength("ب-");       // 👉  2 (total length of "ب")
        _ = try Unicode.utils.firstGcLength("你-");      // 👉  3 (total length of "你")
        _ = try Unicode.utils.firstGcLength("🌟-");      // 👉  4 (total length of "🌟")
        _ = try Unicode.utils.firstGcLength("☹️-");      // 👉  6 (total length of "☹️")
        _ = try Unicode.utils.firstGcLength("👨‍🏭-");      // 👉 11 (total length of "👨‍🏭")
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        const invalidUtf8 : u8 = &[_]u8{0x80, 0x81, 0x82};
        _ = Unicode.utils.lengthOfStartByte(invalidUtf8); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Unicode.lengthOfStartByte`](./lengthOfStartByte.md)

  > [`Unicode.Iterator`](./Iterator.md)

  > [`Unicode.Codepoint`](./Codepoint.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>