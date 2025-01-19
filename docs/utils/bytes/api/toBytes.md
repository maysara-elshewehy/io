# [←](../bytes.md) `bytes`.`toBytes`

> Converts the given value to an array of bytes.

```zig
pub inline fn toBytes(value: anytype) toBytesError![]const u8
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter | Type      | Description           |
    | --------- | --------- | --------------------- |
    | `value`   | `anytype` | The value to convert. |

- #### 🚫 Errors
    
    | Error          | Reason                |
    | -------------- | --------------------- |
    | `InvalidValue` | The value is invalid. |

- #### ✨ Returns : `[]const u8`

    > A constant array of bytes filled with the given value.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    ```

    - ##### 🟢 Success Cases

        > **_Single byte._**

        ```zig
        _ = try Bytes.toBytes('A');         // 👉 "A"
        _ = try Bytes.toBytes(65);          // 👉 "A"
        ```

        > **_Array of bytes._**

        ```zig
        _ = try Bytes.toBytes("");          // 👉 ""
        _ = try Bytes.toBytes("A");         // 👉 "A"
        ```

    - ##### 🔴 Failure Cases
        
        > **_InvalidValue._**

        ```zig
        _ = try Bytes.toBytes(256);         // 👉 error.InvalidValue (Exceeds maximum byte value `255`)
        _ = try Bytes.toBytes(-1);          // 👉 error.InvalidValue (Negative number)
        _ = try Bytes.toBytes(1.5);         // 👉 error.InvalidValue (Float)
        _ = try Bytes.toBytes(true);        // 👉 error.InvalidValue (Boolean)
        _ = try Bytes.toBytes([_]u7{'#'});  // 👉 error.InvalidValue (Array of non-byte type)
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.isByte`](./isByte.md)

  > [`Bytes.isBytes`](./isbytes.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>