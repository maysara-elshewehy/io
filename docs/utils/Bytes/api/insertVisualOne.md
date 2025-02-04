# [←](../Bytes.md) `Bytes`.`insertVisualOne`

> Inserts a `byte` into `dest` at the specified `visual position`.

```zig
pub fn insertVisualOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                       |
    | ----------- | ------- | --------------------------------- |
    | `dest`      | `[]u8`  | The destination to insert into.   |
    | `byte`      | `u8`    | The byte to insert.               |
    | `dest_wlen` | `usize` | The write length of `dest`.       |
    | `pos`       | `usize` | The visual position to insert at. |

- #### 🚫 Errors

    | Error             | Reason                                      |
    | ----------------- | ------------------------------------------- |
    | `InvalidPosition` | The position is invalid.                    |
    | `OutOfRange`      | The insertion exceeds the bounds of `dest`. |
    | `OutOfRange`      | The `pos` is greater than `dest_wlen`.      |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(18, "👨‍🏭");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.insertVisualOne(&array, 'H', 11, 1); // 👉 "👨‍🏭H"
        try Bytes.insertVisualOne(&array, '!', 11, 2); // 👉 "👨‍🏭H!"
        try Bytes.insertVisualOne(&array, 'o', 11, 2); // 👉 "👨‍🏭Ho!"
        try Bytes.insertVisualOne(&array, 'l', 11, 2); // 👉 "👨‍🏭Hlo!"
        try Bytes.insertVisualOne(&array, 'e', 11, 2); // 👉 "👨‍🏭Helo!"
        try Bytes.insertVisualOne(&array, 'l', 11, 3); // 👉 "👨‍🏭Hello!"
        try Bytes.insertVisualOne(&array, ' ', 11, 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.insertVisualOne(&array, '@', 0, 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.insert`](./insert.md)

  > [`Bytes.insertOne`](./insertOne.md)

  > [`Bytes.insertVisual`](./insertVisual.md)

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