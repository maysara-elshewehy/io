# [←](../Bytes.md) `Bytes`.`appendOne`

> Appends a `byte` into `dest`.

```zig
pub fn appendOne(dest: []u8, byte: u8, dest_wlen: usize) insertError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                     |
    | ----------- | ------- | ------------------------------- |
    | `dest`      | `[]u8`  | The destination to insert into. |
    | `byte`      | `u8`    | The byte to insert.             |
    | `dest_wlen` | `usize` | The write length of `dest`.     |

- #### 🚫 Errors

    | Error        | Reason                                      |
    | ------------ | ------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of `dest`. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.initCapacity(7);
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.appendOne(&array, 'H', 0); // 👉 "H"
        try Bytes.appendOne(&array, 'e', 1); // 👉 "He"
        try Bytes.appendOne(&array, 'l', 2); // 👉 "Hel"
        try Bytes.appendOne(&array, 'l', 3); // 👉 "Hell"
        try Bytes.appendOne(&array, 'o', 4); // 👉 "Hello"
        try Bytes.appendOne(&array, ' ', 5); // 👉 "Hello "
        try Bytes.appendOne(&array, '!', 6); // 👉 "Hello !"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.appendOne(&array, '@', 0); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.initCapacity`](./initCapacity.md)

  > [`Bytes.insert`](./insert.md)

  > [`Bytes.insertOne`](./insertOne.md)

  > [`Bytes.insertVisual`](./insertVisual.md)

  > [`Bytes.insertVisualOne`](./insertVisualOne.md)

  > [`Bytes.append`](./append.md)

  > [`Bytes.prepend`](./prepend.md)

  > [`Bytes.prependOne`](./prependOne.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>