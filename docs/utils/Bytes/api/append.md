# [←](../Bytes.md) `Bytes`.`append`

> Appends a `slice` into `dest`.

```zig
pub fn append(dest: []u8, slice: []const u8, dest_wlen: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type         | Description                     |
    | ----------- | ------------ | ------------------------------- |
    | `dest`      | `[]u8`       | The destination to insert into. |
    | `slice`     | `[]const u8` | The slice to insert.            |
    | `dest_wlen` | `usize`      | The write length of `dest`.     |

- #### 🚫 Errors

    | Error        | Reason                                      |
    | ------------ | ------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of `dest`. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.initCapacity(18);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.append(&array, "H",   0); // 👉 "H"
        try Bytes.append(&array, "e",   1); // 👉 "He"
        try Bytes.append(&array, "llo", 2); // 👉 "Hello"
        try Bytes.append(&array, " ",   4); // 👉 "Hello "
        try Bytes.append(&array, "👨‍🏭",  5); // 👉 "Hello 👨‍🏭"
        try Bytes.append(&array, "!",  15); // 👉 "Hello 👨‍🏭!"

        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.append(&array, "@", 16); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

  > [`Bytes.insert`](./insert.md)

  > [`Bytes.insertOne`](./insertOne.md)

  > [`Bytes.insertVisual`](./insertVisual.md)

  > [`Bytes.insertVisualOne`](./insertVisualOne.md)

  > [`Bytes.appendOne`](./appendOne.md)

  > [`Bytes.prepend`](./prepend.md)

  > [`Bytes.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>