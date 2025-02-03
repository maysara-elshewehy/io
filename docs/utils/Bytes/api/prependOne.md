# [←](../Bytes.md) `Bytes`.`prependOne`

> Prepends a `byte` into `dest`.

```zig
pub fn prependOne(dest: []u8, byte: u8, dest_wlen: usize) insertError!void
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

- #### 🚫 Errors

    | Error        | Reason                                      |
    | ------------ | ------------------------------------------- |
    | `OutOfRange` | The insertion exceeds the bounds of `dest`. |

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
        try Bytes.prependOne(&array, 'H', 0); // 👉 "H"
        try Bytes.prependOne(&array, 'e', 1); // 👉 "eH"
        try Bytes.prependOne(&array, 'l', 2); // 👉 "leH"
        try Bytes.prependOne(&array, 'l', 3); // 👉 "lleH"
        try Bytes.prependOne(&array, 'o', 4); // 👉 "olleH"
        try Bytes.prependOne(&array, ' ', 5); // 👉 " olleH"
        try Bytes.prependOne(&array, '!', 6); // 👉 "! olleH"
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.prependOne(&array, '@', 0); // 👉 error.OutOfRange
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

  > [`Bytes.append`](./append.md)

  > [`Bytes.appendOne`](./appendOne.md)

  > [`Bytes.prepend`](./prepend.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>