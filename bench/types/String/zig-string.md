# [←](../../index.md) `io.types.String` vs `@JakubSzark/zig-string` ⚡

> A detailed comparison between `io.types.String` and `@JakubSzark/zig-string`, focusing on their performance, features, and ideal use cases. 🧐

- ## Key Differences ✨

  - ### Overview of `@JakubSzark/zig-string` 🛠️

    - A dynamic string implementation provided by `@JakubSzark`.
    - Designed for general-purpose string manipulation.
    - Lacks advanced Unicode support, which can lead to issues with grapheme clusters and multi-codepoint characters.
    - Uses a simple concatenation approach without pre-allocating memory, resulting in slower performance for frequent modifications.

    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
    </div>

  - ### Overview of `io.types.String` 🚀

    - A specialized string implementation from `SuperZIG`, designed specifically for advanced string manipulation.
    - Optimized for operations such as concatenation, searching, and formatting.
    - Provides full Unicode support, including handling of grapheme clusters and multi-codepoint characters.
    - Pre-allocates memory to reduce allocation frequency, resulting in faster performance for frequent modifications.

    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
    </div>


- ## Why This Comparison? 🤔

    When I first considered creating my custom `String` type, I explored existing libraries, with `@JakubSzark/zig-string` being one of the most prominent. While it is a solid implementation, it has notable limitations:

    1. **Lack of Unicode Support**: `@JakubSzark/zig-string` struggles with grapheme clusters and multi-codepoint characters. For example, when using the `pop` function on a string containing a grapheme cluster (e.g., `"☹️"`), it only removes the last codepoint (the modifier) but fails to handle the associated base character, leading to incorrect results.

    2. **Performance**: `@JakubSzark/zig-string` is slower in scenarios involving frequent modifications, as it does not pre-allocate memory as aggressively as `io.types.String`.

    In contrast, `io.types.String` was designed from the ground up to handle these cases efficiently, offering both speed and correctness in text processing.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ## Performance Comparison 📈

    The following table highlights the performance differences in append operations using a 1024-byte string:

    - ### `@JakubSzark/zig-string.concat`

        | Operation | Runs  | Total Time | Time/Run (avg ± σ)  | Performance Gain vs Competitor |
        | --------- | ----- | ---------- | ------------------- | ------------------------------ |
        | `x1`      | 65526 | 838.354ms  | 12.794µs ± 16.675µs | -                              |
        | `x10`     | 65535 | 1.662s     | 25.374µs ± 13.587µs | -                              |
        | `x100`    | 1023  | 1.534s     | 1.5ms ± 117.256µs   | -                              |
        | `x1000`   | 7     | 1.014s     | 144.971ms ± 3.783ms | -                              |

    - ### `io.types.String.append`

        | Operation | Runs  | Total Time | Time/Run (avg ± σ)   | Performance Gain vs Competitor |
        | --------- | ----- | ---------- | -------------------- | ------------------------------ |
        | `x1`      | 65535 | 654.927ms  | 9.993µs ± 15.66µs    | -                              |
        | `x10`     | 65535 | 716.3ms    | 10.93µs ± 16.553µs   | **⚡ 2.32x Faster ⚡**           |
        | `x100`    | 32767 | 1.32s      | 40.284µs ± 36.741µs  | **⚡ 37.2x Faster ⚡**           |
        | `x1000`   | 4095  | 1.215s     | 296.895µs ± 48.761µs | **⚡ 488x Faster ⚡**            |

    > Calculated using: `(Competitor Time/Run) ÷ (io.types.String Time/Run)`

    > You can find the benchmarks at [io-bench](https://github.com/maysara-elshewehy/io-bench/blob/main/String_vs_zigstring.zig) repository.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

## Unicode Handling Test 🧪

The following test demonstrates the difference in Unicode handling between the two implementations:

```zig
const txt = "-☹️";

// io.types.String
{
    var string = try io.types.String.init(std.testing.allocator, txt);
    defer string.deinit();
    try std.testing.expectEqualStrings(txt, string.writtenSlice());

    try std.testing.expectEqualStrings("☹️", string.pop().?); // Correctly handles grapheme clusters.
    try std.testing.expectEqualStrings("-", string.writtenSlice());
}

// @JakubSzark/zig-string
{
    var string = zString.init(std.testing.allocator);
    defer string.deinit();
    try string.concat(txt);
    try std.testing.expectEqualStrings(txt, string.str());

    // Fails: Incorrectly splits the grapheme cluster.
    // try std.testing.expectEqualStrings("☹️", string.pop().?); // Found '\xef'.
    // try std.testing.expectEqualStrings("-", string.str());
}
```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

## Conclusion 🏆

- **`io.types.String`**: An excellent choice for applications requiring extensive string processing, especially those involving Unicode text. It offers superior performance, advanced features, and correct handling of grapheme clusters and multi-codepoint characters.

- **`@JakubSzark/zig-string`**: A versatile and general-purpose string implementation, suitable for simpler use cases where advanced Unicode support is not required. However, it falls short in performance and correctness for complex text processing tasks.

For projects demanding high-performance and robust text manipulation, `io.types.String` is the clear winner. 🚀