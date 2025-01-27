# [←](../bytes.md) `bytes`.`insertVisual`

> Inserts a `slice` into `dest` at the specified `visual position`.

```zig
pub fn insertVisual(dest: []u8, slice: []const u8, dest_wlen: usize, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    var array = try Bytes.initCapacity(18);
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Bytes.insertVisual(&array, "H",    0, 0); // 👉 "H"
        _ = try Bytes.insertVisual(&array, "👨‍🏭",   1, 1); // 👉 "H👨‍🏭"
        _ = try Bytes.insertVisual(&array, "o",   12, 1); // 👉 "Ho👨‍🏭"
        _ = try Bytes.insertVisual(&array, "ell", 13, 1); // 👉 "Hello👨‍🏭"
        _ = try Bytes.insertVisual(&array, " ",   16, 5); // 👉 "Hello 👨‍🏭"
        _ = try Bytes.insertVisual(&array, "!",   17, 7); // 👉 "Hello 👨‍🏭!"
        ```

    - ##### 🔴 Failure Cases
        
        > **_OutOfRange._**

        ```zig
        _ = try Bytes.insertVisual(&array, "@", 0, 17); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>