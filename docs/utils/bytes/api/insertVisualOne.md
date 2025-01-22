# [←](../bytes.md) `bytes`.`insertVisualOne`

> Inserts a `byte` into `destination` at the specified `position` by **visual position**.

```zig
pub fn insertVisualOne(dest: []u8, byte: u8, dest_wlen: usize, pos: usize) insertVisualError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.bytes;
    var array = try Bytes.init(18, "👨‍🏭");
    ```

    - ##### 🟢 Success Cases

        ```zig
        _ = try Bytes.insertVisualOne(&array, 'H', 11, 1); // 👉 "👨‍🏭H"
        _ = try Bytes.insertVisualOne(&array, '!', 11, 2); // 👉 "👨‍🏭H!"
        _ = try Bytes.insertVisualOne(&array, 'o', 11, 2); // 👉 "👨‍🏭Ho!"
        _ = try Bytes.insertVisualOne(&array, 'l', 11, 2); // 👉 "👨‍🏭Hlo!"
        _ = try Bytes.insertVisualOne(&array, 'e', 11, 2); // 👉 "👨‍🏭Helo!"
        _ = try Bytes.insertVisualOne(&array, 'l', 11, 3); // 👉 "👨‍🏭Hello!"
        _ = try Bytes.insertVisualOne(&array, ' ', 11, 6); // 👉 "👨‍🏭Hello !"
        ```

    - ##### 🔴 Failure Cases
        
        > **_OutOfRange._**

        ```zig
        _ = try Bytes.insertVisualOne(&array, '@', 0, 6); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>