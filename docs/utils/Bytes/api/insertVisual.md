# [←](../Bytes.md) `Bytes`.`insertVisual`

> Inserts a `slice` into `dest` at the specified `visual position`.

```zig
pub fn insertVisual(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type         | Description                       |
    | ----------- | ------------ | --------------------------------- |
    | `dest`      | `[]u8`       | The destination to insert into.   |
    | `slice`     | `[]const u8` | The slice to insert.              |
    | `dest_wlen` | `usize`      | The write length of `dest`.       |
    | `pos`       | `usize`      | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                      |
    | ----------------- | ------------------------------------------- |
    | `InvalidPosition` | The position is invalid.                    |
    | `OutOfRange`      | The insertion exceeds the bounds of `dest`. |
    | `OutOfRange`      | The `pos` is greater than `dest_wlen`.      |

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
        try Bytes.insertVisual(&array, "H",    0, 0); // 👉 "H"
        try Bytes.insertVisual(&array, "👨‍🏭",   1, 1); // 👉 "H👨‍🏭"
        try Bytes.insertVisual(&array, "o",   12, 1); // 👉 "Ho👨‍🏭"
        try Bytes.insertVisual(&array, "ell", 13, 1); // 👉 "Hello👨‍🏭"
        try Bytes.insertVisual(&array, " ",   16, 5); // 👉 "Hello 👨‍🏭"
        try Bytes.insertVisual(&array, "!",   17, 7); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.insertVisual(&array, "@", 0, 17); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

  > [`Bytes.insert`](./insert.md)

  > [`Bytes.insertOne`](./insertOne.md)

  > [`Bytes.insertVisualOne`](./insertVisualOne.md)

  > [`Bytes.append`](./append.md)

  > [`Bytes.appendOne`](./appendOne.md)

  > [`Bytes.prepend`](./prepend.md)

  > [`Bytes.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>