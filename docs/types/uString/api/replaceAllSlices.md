# [←](../uString.md) `uString`.`replaceAllSlices`

> Replaces all occurrences of a slice with another.

```zig
pub fn replaceAllSlices(self: *Self, allocator: Allocator, match: []const u8, replacement: []const u8) Allocator.Error!usize
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter     | Type        | Description                |
    | ------------- | ----------- | -------------------------- |
    | `self`        | `*Self`     | The `uString` instance.    |
    | `allocator`   | `Allocator` | The allocator to use.      |
    | `match`       | `[]u8`      | The slice to match.        |
    | `replacement` | `[]u8`      | The slice to replace with. |

- #### 🚫 Errors

    | Error             | Reason                 |
    | ----------------- | ---------------------- |
    | `Allocator.Error` | The allocation failed. |

- #### ✨ Returns : `usize`

    > Modifies `uString` instance in place and returns the number of replacements.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const uString = @import("io").types.uString;
    var string = try uString.init(allocator, "Hello 👨‍🏭!");
    defer string.deinit(allocator);
    ```

    ```zig
    const res = try string.replaceAllSlices(allocator, "👨‍🏭", "World");
    // res    👉 1
    // string 👉 "Hello World!"
    ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`uString.init`](./init.md)

  > [`uString.replaceAllChars`](./replaceAllChars.md)

  > [`uString.replaceRange`](./replaceRange.md)

  > [`uString.replaceVisualRange`](./replaceVisualRange.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>