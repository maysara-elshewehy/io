# [←](../Bytes.md) `Bytes`.`insertOne`

> Inserts a `byte` into `dest` at the specified `position`.

```zig
pub fn insertOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                     |
    | ----------- | ------- | ------------------------------- |
    | `dest`      | `[]u8`  | The destination to insert into. |
    | `byte`      | `u8`    | The byte to insert.             |
    | `dest_wlen` | `usize` | The write length of `dest`.     |
    | `pos`       | `usize` | The position to insert at.      |

- #### 🚫 Errors

    | Error        | Reason                                      |
    | ------------ | ------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of `dest`. |
    | `OutOfRange` | The `pos` is greater than `dest_wlen`.      |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.initCapacity(7);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.insertOne(&array, 'H', 0, 0); // 👉 "H"
        try Bytes.insertOne(&array, '!', 1, 1); // 👉 "H!"
        try Bytes.insertOne(&array, 'o', 2, 1); // 👉 "Ho!"
        try Bytes.insertOne(&array, 'l', 3, 1); // 👉 "Hello!"
        try Bytes.insertOne(&array, 'e', 4, 1); // 👉 "Hello!"
        try Bytes.insertOne(&array, 'l', 5, 2); // 👉 "Hello!"
        try Bytes.insertOne(&array, ' ', 6, 5); // 👉 "Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.insertOne(&array, '@', 0, 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

  > [`Bytes.insert`](./insert.md)

  > [`Bytes.insertVisual`](./insertVisual.md)

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