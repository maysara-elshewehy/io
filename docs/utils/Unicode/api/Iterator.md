# [←](../Unicode.md) `utf8`.`Iterator`

> A _(`grapheme cluster`, `codepoint`)_ iterator for iterating over a slice of Bytes.

```zig
pub const Iterator = struct
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### ✨ Fields

    | Field           | Type         | Description                           |
    | --------------- | ------------ | ------------------------------------- |
    | `input_bytes`   | `[]const u8` | The input bytes to iterate over.      |
    | `current_index` | `usize`      | The current position of the iterator. |

- #### 🧩 Functions

    - #### init

        > Initializes a Codepoint using the given input Bytes.

        > 🚫 Returns `Error.InvalidValue` **_if the `input_bytes` is not a valid Unicode._**

        ```zig
        pub fn init(input_bytes: []const u8) Error!Self
        ```

    - #### nextSlice

        > Retrieves the next codepoint slice and advances the iterator.

        ```zig
        pub fn nextSlice(self: *Self) ?[]const u8
        ```

    - #### nextGraphemeCluster

        > Retrieves the next grapheme cluster slice and advances the iterator.

        ```zig
        pub fn nextGraphemeCluster(self: *Self) ?[]const u8
        ```

    - #### next

        > Decodes and returns the next codepoint and advances the iterator.

        ```zig
        pub fn next(self: *Self) ?types.codepoint
        ```

    - #### peek

        > Decodes and returns the next codepoint without advancing the iterator.

        ```zig
        pub fn peek(self: *Self, codepoints_count: usize) []const u8
        ```

- #### 🚫 Errors

    | Error          | Reason                                       |
    | -------------- | -------------------------------------------- |
    | `InvalidValue` | **_if the `slice` is not a valid Unicode._** |

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Unicode = @import("io").utils.Unicode;
    ```

    ```zig
    const txt = "Aأ你🌟☹️👨‍🏭@";
    ```

    > It is recommended to see the examples of our [Codepoint structure](./Codepoint.md#-examples) to know some details about codepoints.

    - ##### 🟢 Success Cases

        > **Iterate using Codepoints (Slice).**
        ```zig
        var iterator = try Unicode.Iterator.init(txt);
        while (iterator.nextSlice()) |codepoint| {
            std.debug.print("[{s}]\n", .{codepoint});
        }

        // [A]
        // [أ]
        // [你]
        // [🌟]
        // [☹️]  (first codepoint of "☹️")
        // [☹️]  (second codepoint of "☹️") (modifier)
        // [👨‍🏭] (first codepoint of "👨‍🏭")
        // [👨‍🏭] (second codepoint of "👨‍🏭") (ZWJ)
        // [👨‍🏭] (third codepoint of "👨‍🏭")
        // [@]
        ```

        > **Iterate using Grapheme Clusters (Slice).**
        ```zig
        var iterator = try Unicode.Iterator.init(txt);
        while (iterator.nextGraphemeCluster()) |grapheme_cluster| {
            std.debug.print("[{s}]\n", .{grapheme_cluster});
        }

        // [A]
        // [أ]
        // [你]
        // [🌟]
        // [☹️]
        // [👨‍🏭]
        // [@]
        ```

        > **Iterate using Codepoints.**
        ```zig
        var iterator = try Unicode.Iterator.init(txt);
        while (iterator.next()) |codepoint| {
            std.debug.print("[0x{x}]\n", .{codepoint});
        }

        // [0x41]
        // [0x623]
        // [0x4f60]
        // [0x1f31f]
        // [0x2639]
        // [0xfe0f]
        // [0x1f468]
        // [0x200d]
        // [0x1f3ed]
        // [0x40]
        ```

        > **Preview the following `N` of codepoints, Without affecting the index of the iterator.**
        ```zig
        var iterator = try Unicode.Iterator.init("ABC");
        std.debug.print("[{s}]\n", .{iterator.peek(1)});
        std.debug.print("[{s}]\n", .{iterator.peek(2)});
        std.debug.print("[{s}]\n", .{iterator.peek(3)});

        // [A]
        // [AB]
        // [ABC]
        ```

    - ##### 🔴 Failure Cases

        > **_InvalidValue._**

        ```zig
        _ = Unicode.Iterator.init(txt[6..8]);  // 👉 error.InvalidValue (half of 🌟)
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Unicode.Codepoint`](./Codepoint.md)

  > [`Unicode.lengthOfFirst`](./lengthOfFirst.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>