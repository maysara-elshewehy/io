# [←](../Unicode.md) `utf8`.`utils`.`lengthOfStartByte`

> Returns length of the codepoint depending on the first byte.

```zig
pub fn lengthOfStartByte(value: u8) error{InvalidValue}!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type | Description          |
    | --------- | ---- | -------------------- |
    | `value`   | `u8` | The value to handle. |

- #### 🚫 Errors

    | Error          | Reason                                 |
    | -------------- | -------------------------------------- |
    | `InvalidValue` | if the `value` is not a valid Unicode. |

- #### ✨ Returns : `usize`

    > Returns length of the codepoint depending on the first byte.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Unicode = @import("io").utils.Unicode;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Unicode.utils.lengthOfStartByte("A-"[0]);    // 👉 1 (length of first codepoint of "A")
        _ = try Unicode.utils.lengthOfStartByte("ب-"[0]);    // 👉 2 (length of first codepoint of "ب")
        _ = try Unicode.utils.lengthOfStartByte("你-"[0]);   // 👉 3 (length of first codepoint of "你")
        _ = try Unicode.utils.lengthOfStartByte("🌟-"[0]);   // 👉 4 (length of first codepoint of "🌟")
        _ = try Unicode.utils.lengthOfStartByte("☹️-"[0]);   // 👉 3 (length of first codepoint of "☹️")
        _ = try Unicode.utils.lengthOfStartByte("👨‍🏭-"[0]);   // 👉 4 (length of first codepoint of "👨‍🏭")
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        try Unicode.utils.lengthOfStartByte(0x80); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Unicode.firstGcLength`](./firstGcLength.md)

  > [`Unicode.Iterator`](./Iterator.md)

  > [`Unicode.Codepoint`](./Codepoint.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>