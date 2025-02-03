# [←](../Bytes.md) `Bytes`.`insert`

> Inserts a `slice` into `dest` at the specified `position`.

```zig
pub fn insert(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type         | Description                     |
    | ----------- | ------------ | ------------------------------- |
    | `dest`      | `[]u8`       | The destination to insert into. |
    | `slice`     | `[]const u8` | The slice to insert.            |
    | `dest_wlen` | `usize`      | The write length of `dest`.     |
    | `pos`       | `usize`      | The position to insert at.      |

- #### 🚫 Errors

    | Error        | Reason                                      |
    | ------------ | ------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of `dest`. |
    | `OutOfRange` | The `pos` is greater than `dest_wlen`.      |

- #### ✨ Returns : `void`

    > Modifies `dest` in place **_if `slice` length is greater than 0_.**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.initCapacity(18);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.insert(&array, "H",   0, 0); // 👉 "H"
        try Bytes.insert(&array, "!",   1, 1); // 👉 "H!"
        try Bytes.insert(&array, "o",   2, 1); // 👉 "Ho!"
        try Bytes.insert(&array, "ell", 3, 1); // 👉 "Hello!"
        try Bytes.insert(&array, " ",   6, 5); // 👉 "Hello !"
        try Bytes.insert(&array, "👨‍🏭",  7, 6); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.insert(&array, "@", 0, 17); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

  > [`Bytes.insertOne`](./insertOne.md)

  > [`Bytes.insertVisual`](./insertVisual.md)

  > [`Bytes.insertVisualOne`](./insertVisualOne.md)

  > [`Bytes.append`](./append.md)

  > [`Bytes.appendOne`](./appendOne.md)

  > [`Bytes.prepend`](./prepend.md)

  > [`Bytes.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>