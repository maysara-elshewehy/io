# [←](../utf8.md) `utf8`.`utils`.`lengthOfFirst`

> Returns length of the codepoint depending on the first byte.

```zig
pub fn lengthOfFirst(value: anytype) lengthOfFirstError!usize
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type                           | Description          |
    | --------- | ------------------------------ | -------------------- |
    | `value`   | `u8` or `[]const u8` | The value to handle. |

- #### 🚫 Errors
    
    | Error          | Reason                                                         |
    | -------------- | -------------------------------------------------------------- |
    | `InvalidValue` | if the `value` is multi-byte and is not a valid utf8 byte.     |
    | . . .          | if the `value` is single-byte and not valid a utf8 start byte. |

- #### ✨ Returns : `usize`

    > Returns length of the codepoint depending on the first byte **if single-byte**, or total length of the first grapheme cluster **if multi-byte**.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const utf8 = @import("io").utils.utf8;
    ```

    - ##### 🟢 Success Cases

        > **_Single Byte (First Byte of Unicode Sequence)._**

        ```zig
        _ = utf8.utils.lengthOfFirst("A-"[0]);    // 👉 1 (length of first codepoint of "A")
        _ = utf8.utils.lengthOfFirst("ب-"[0]);    // 👉 2 (length of first codepoint of "ب")
        _ = utf8.utils.lengthOfFirst("你-"[0]);   // 👉 3 (length of first codepoint of "你")
        _ = utf8.utils.lengthOfFirst("🌟-"[0]);   // 👉 4 (length of first codepoint of "🌟")
        _ = utf8.utils.lengthOfFirst("☹️-"[0]);    // 👉 3 (length of first codepoint of "☹️")
        _ = utf8.utils.lengthOfFirst("👨‍🏭-"[0]);   // 👉 4 (length of first codepoint of "👨‍🏭")
        ```
        
        > **_Array of bytes (Starting from the first codepoint in the Unicode Sequence)._**

        ```zig
        _ = utf8.utils.lengthOfFirst("A-");       // 👉  1 (total length of "A")
        _ = utf8.utils.lengthOfFirst("ب-");       // 👉  2 (total length of "ب")
        _ = utf8.utils.lengthOfFirst("你-");      // 👉  3 (total length of "你")
        _ = utf8.utils.lengthOfFirst("🌟-");      // 👉  4 (total length of "🌟")
        _ = utf8.utils.lengthOfFirst("☹️-");       // 👉  6 (total length of "☹️")
        _ = utf8.utils.lengthOfFirst("👨‍🏭-");      // 👉 11 (total length of "👨‍🏭")
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try utf8.utils.lengthOfFirst(256);    // 👉 error.InvalidValue (Exceeds the maximum byte value)
        _ = try utf8.utils.lengthOfFirst(-1);     // 👉 error.InvalidValue (Negative integer is not valid utf8) 
        _ = try utf8.utils.lengthOfFirst(true);   // 👉 error.InvalidValue (Boolean is not valid utf8) 
        _ = try utf8.utils.lengthOfFirst(0.45);   // 👉 error.InvalidValue (Float is not valid utf8) 
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`utf8.Iterator`](./Iterator.md)

  > [`utf8.Codepoint`](./Codepoint.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>