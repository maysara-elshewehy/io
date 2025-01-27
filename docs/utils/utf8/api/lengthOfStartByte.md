# [←](../utf8.md) `utf8`.`utils`.`lengthOfStartByte`

> Returns length of the codepoint depending on the first byte.

```zig
pub fn lengthOfStartByte(value: u8) error{InvalidValue}!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type | Description          |
    | --------- | ---- | -------------------- |
    | `value`   | `u8` | The value to handle. |

- #### 🚫 Errors

    | Error          | Reason                              |
    | -------------- | ----------------------------------- |
    | `InvalidValue` | if the `value` is not a valid utf8. |

- #### ✨ Returns : `usize`

    > Returns length of the codepoint depending on the first byte.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const utf8 = @import("io").utils.utf8;
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = utf8.utils.lengthOfStartByte("A-"[0]);    // 👉 1 (length of first codepoint of "A")
        _ = utf8.utils.lengthOfStartByte("ب-"[0]);    // 👉 2 (length of first codepoint of "ب")
        _ = utf8.utils.lengthOfStartByte("你-"[0]);   // 👉 3 (length of first codepoint of "你")
        _ = utf8.utils.lengthOfStartByte("🌟-"[0]);   // 👉 4 (length of first codepoint of "🌟")
        _ = utf8.utils.lengthOfStartByte("☹️-"[0]);   // 👉 3 (length of first codepoint of "☹️")
        _ = utf8.utils.lengthOfStartByte("👨‍🏭-"[0]);   // 👉 4 (length of first codepoint of "👨‍🏭")
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        _ = utf8.utils.lengthOfStartByte(0x80); // 👉 error.InvalidValue
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`utf8.firstGcLength`](./firstGcLength.md)

  > [`utf8.Iterator`](./Iterator.md)

  > [`utf8.Codepoint`](./Codepoint.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>