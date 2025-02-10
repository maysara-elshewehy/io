<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/String/logo.png" alt="String" width="1000" />
</p>

<p align="center">
     <a href="#">
        <img src="https://img.shields.io/badge/under--development-yellow.svg" alt="Under Development" />
    </a>
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
    <b> Strings in ZIG done right. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://github.com/Super-ZIG/io">SuperZIG/io</a> library.</sup>
    </i></b>
</div>


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center">
    <b><i>
        <sup> 🔥 Built for power. Designed for speed. Ready for production. 🔥 </sup>
    </i></b>
</div>
<br>



- ### ✨ Features ✨

    - 🚀 **Unified Internal Logic**
        > All string types share the same core logic, acting as simple containers. The real functionality resides in internal modules like `utils.chars` and `utils.unicode`, ensuring efficiency, maintainability, and elegance.

    - 🔢 **Integer Type Support**
        > Works seamlessly with various integer types, including `u8`, `u16`, `u32`, `u64`, and beyond.

    - 🌍 **Full Unicode Compatibility**
        > Properly handles Unicode, preserving character integrity, including complex grapheme clusters like emojis and modifiers.

    - ⚡ **Blazing Fast Performance**
        > Matches the speed of Zig’s standard library and outperforms competitors by **488x** times in benchmarks.

    - 🛡️ **Rock-Solid Stability**
        > Every function is rigorously tested, making the library safe, reliable, and ready for production.

    - 🏗️ **Optimized for Scalability**
        > Designed with efficiency in mind, avoiding unnecessary allocations while maintaining flexibility.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

    🔹 [⚡ Performance & Benchmarks](#benchmarking) – Speed comparisons with other implementations.

    🔹 [🌍 Unicode Handling](#unicode-handling-comparison) – How the library correctly processes Unicode text.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

    > This library provides several types, each with its own approach to handling strings in the ZIG language.

    > You can choose from the following types according to the intended purpose:

    | Type                      | Description                                               |
    | ------------------------- | --------------------------------------------------------- |
    | [`Viewer`](./viewer.md)   | Immutable fixed-size string type that supports unicode.   |
    | [`Buffer`](./buffer.md)   | Mutable fixed-size string type that supports unicode.     |
    | [`String`](./string.md)   | Managed dynamic-size string type that supports unicode.   |
    | [`uString`](./uString.md) | Unmanaged dynamic-size string type that supports unicode. |


    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    </div>

    > Internal utility modules for handling char arrays and Unicode operations.

    | Module                    | Description                                                     |
    | ------------------------- | --------------------------------------------------------------- |
    | [`chars`](./chars.md)     | Utility functions for char arrays.                              |
    | [`unicode`](./unicode.md) | Utility functions for Unicode codepoints and grapheme clusters. |


    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    </div>

    > 🟢 Implemented and tested.
    >
    > 🟡 Under development.
    >
    > 🟣 Exists only for internal API integration.
    >
    > ⚫ Contradicts container logic.

    | Function           | Viewer | Buffer | String | uString |
    | ------------------ | ------ | ------ | ------ | ------- |
    | init               | 🟢      | 🟢      | 🟢      | 🟢       |
    | initEmpty          | 🟢      | 🟢      | 🟢      | 🟢       |
    | initWithSelf       | 🟢      | 🟢      | 🟢      | 🟢       |
    | initWithSlice      | 🟢      | 🟢      | 🟢      | 🟢       |
    | initWithChar       | ⚫      | 🟢      | 🟢      | 🟢       |
    | initWithCapacity   | ⚫      | 🟢      | 🟢      | 🟢       |
    | initWithFmt        | ⚫      | 🟢      | 🟢      | 🟢       |
    | initWithAllocator  | ⚫      | ⚫      | 🟢      | 🟣       |
    | deinit             | ⚫      | ⚫      | 🟢      | 🟢       |
    | size               | 🟢      | 🟢      | 🟢      | 🟢       |
    | len                | 🟢      | 🟢      | 🟢      | 🟢       |
    | vlen               | 🟢      | 🟢      | 🟢      | 🟢       |
    | src                | 🟢      | 🟢      | 🟢      | 🟢       |
    | sub                | 🟢      | 🟢      | 🟢      | 🟢       |
    | cString            | ⚫      | 🟢      | 🟢      | 🟢       |
    | allocatedSlice     | ⚫      | ⚫      | 🟢      | 🟢       |
    | iterator           | 🟢      | 🟢      | 🟢      | 🟢       |
    | writer             | ⚫      | 🟢      | 🟢      | 🟢       |
    | charAt             | 🟢      | 🟢      | 🟢      | 🟢       |
    | atVisual           | 🟢      | 🟢      | 🟢      | 🟢       |
    | find               | 🟢      | 🟢      | 🟢      | 🟢       |
    | findVisual         | 🟢      | 🟢      | 🟢      | 🟢       |
    | findLast           | 🟢      | 🟢      | 🟢      | 🟢       |
    | findLastVisual     | 🟢      | 🟢      | 🟢      | 🟢       |
    | includes           | 🟢      | 🟢      | 🟢      | 🟢       |
    | startsWith         | 🟢      | 🟢      | 🟢      | 🟢       |
    | endsWith           | 🟢      | 🟢      | 🟢      | 🟢       |
    | clone              | 🟢      | 🟢      | 🟢      | 🟢       |
    | isEqual            | 🟢      | 🟢      | 🟢      | 🟢       |
    | isEmpty            | 🟢      | 🟢      | 🟢      | 🟢       |
    | insert             | ⚫      | 🟢      | 🟢      | 🟢       |
    | insertSlice        | ⚫      | 🟢      | 🟢      | 🟢       |
    | insertChar         | ⚫      | 🟢      | 🟢      | 🟢       |
    | insertSelf         | ⚫      | 🟢      | 🟢      | 🟢       |
    | insertFmt          | ⚫      | 🟢      | 🟢      | 🟢       |
    | visualInsert       | ⚫      | 🟢      | 🟢      | 🟢       |
    | visualInsertSlice  | ⚫      | 🟢      | 🟢      | 🟢       |
    | visualInsertChar   | ⚫      | 🟢      | 🟢      | 🟢       |
    | visualInsertSelf   | ⚫      | 🟢      | 🟢      | 🟢       |
    | visualInsertFmt    | ⚫      | 🟢      | 🟢      | 🟢       |
    | append             | ⚫      | 🟢      | 🟢      | 🟢       |
    | appendSlice        | ⚫      | 🟢      | 🟢      | 🟢       |
    | appendChar         | ⚫      | 🟢      | 🟢      | 🟢       |
    | appendSelf         | ⚫      | 🟢      | 🟢      | 🟢       |
    | appendFmt          | ⚫      | 🟢      | 🟢      | 🟢       |
    | prepend            | ⚫      | 🟢      | 🟢      | 🟢       |
    | prependSlice       | ⚫      | 🟢      | 🟢      | 🟢       |
    | prependChar        | ⚫      | 🟢      | 🟢      | 🟢       |
    | prependSelf        | ⚫      | 🟢      | 🟢      | 🟢       |
    | prependFmt         | ⚫      | 🟢      | 🟢      | 🟢       |
    | repeat             | ⚫      | 🟢      | 🟢      | 🟢       |
    | removeIndex        | ⚫      | 🟢      | 🟢      | 🟢       |
    | removeVisualIndex  | ⚫      | 🟢      | 🟢      | 🟢       |
    | removeRange        | ⚫      | 🟢      | 🟢      | 🟢       |
    | removeVisualRange  | ⚫      | 🟢      | 🟢      | 🟢       |
    | pop                | ⚫      | 🟢      | 🟢      | 🟢       |
    | shift              | ⚫      | 🟢      | 🟢      | 🟢       |
    | trim               | ⚫      | 🟢      | 🟢      | 🟢       |
    | trimStart          | ⚫      | 🟢      | 🟢      | 🟢       |
    | trimEnd            | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceRange       | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceVisualRange | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceFirst       | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceFirstN      | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceLast        | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceLastN       | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceNth         | ⚫      | 🟢      | 🟢      | 🟢       |
    | replaceAll         | ⚫      | 🟢      | 🟢      | 🟢       |
    | toLower            | ⚫      | 🟢      | 🟢      | 🟢       |
    | toUpper            | ⚫      | 🟢      | 🟢      | 🟢       |
    | toTitle            | ⚫      | 🟢      | 🟢      | 🟢       |
    | reverse            | ⚫      | 🟢      | 🟢      | 🟢       |
    | split              | 🟢      | 🟢      | 🟢      | 🟢       |
    | splitAll           | 🟢      | 🟢      | 🟢      | 🟢       |
    | splitToSelf        | 🟢      | 🟢      | 🟢      | 🟢       |
    | splitAllToSelf     | 🟢      | 🟢      | 🟢      | 🟢       |
    | clear              | 🟢      | 🟢      | 🟢      | 🟢       |
    | clearAndFree       | ⚫      | ⚫      | 🟢      | 🟢       |
    | shrink             | ⚫      | ⚫      | 🟢      | 🟢       |
    | shrinkAndFree      | ⚫      | ⚫      | 🟢      | 🟢       |
    | resize             | ⚫      | ⚫      | 🟢      | 🟢       |
    | fromOwnedSlice     | ⚫      | ⚫      | 🟢      | 🟢       |
    | toOwnedSlice       | ⚫      | ⚫      | 🟢      | 🟢       |
    | toManaged          | 🟡      | 🟡      | ⚫      | 🟢       |
    | toUnmanaged        | 🟡      | 🟡      | 🟢      | ⚫       |
    | toViewer           | ⚫      | 🟡      | 🟢      | 🟢       |
    | toInteger          | 🟡      | 🟡      | 🟡      | 🟡       |
    | toFloat            | 🟡      | 🟡      | 🟡      | 🟡       |
    | print              | 🟡      | 🟡      | 🟡      | 🟡       |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>


- ### Benchmarking

    > Same speed of the standard library.

    > Faster then the competitor by **488x** times ⚡⚡.

    - `std.ArrayList.appendSlice`

        | Operation | Runs  | Total Time | Time/Run (avg)       |
        | --------- | ----- | ---------- | -------------------- |
        | `x1`      | 65535 | 841.846ms  | 12.845µs ± 18.981µs  |
        | `x10`     | 65535 | 702.371ms  | 10.717µs ± 16.316µs  |
        | `x100`    | 32767 | 1.247s     | 38.068µs ± 28.696µs  |
        | `x1000`   | 4095  | 1.188s     | 290.298µs ± 37.238µs |

    - `@JakubSzark/zig-string.concat`

        | Operation | Runs  | Total Time | Time/Run (avg ± σ)  |
        | --------- | ----- | ---------- | ------------------- |
        | `x1`      | 65526 | 838.354ms  | 12.794µs ± 16.675µs |
        | `x10`     | 65535 | 1.662s     | 25.374µs ± 13.587µs |
        | `x100`    | 1023  | 1.534s     | 1.5ms ± 117.256µs   |
        | `x1000`   | 7     | 1.014s     | 144.971ms ± 3.783ms |

    - `String.appendSlice`

        | Operation | Runs  | Total Time | Time/Run (avg ± σ)   | Performance Gain vs Competitor |
        | --------- | ----- | ---------- | -------------------- | ------------------------------ |
        | `x1`      | 65535 | 654.927ms  | 9.993µs ± 15.66µs    | ~                              |
        | `x10`     | 65535 | 686.376ms  | 10.473µs ± 15.866µs  | **⚡ 2.3x Faster ⚡**            |
        | `x100`    | 32767 | 1.258s     | 38.414µs ± 26.291µs  | **⚡ 37x Faster ⚡**             |
        | `x1000`   | 4095  | 1.175s     | 286.964µs ± 41.270µs | **⚡ 488x Faster ⚡**            |

    > Calculated using: `(Competitor Time/Run) ÷ (String Time/Run)`

    > It is normal for the values ​​to differ each time the benchmark is run,
    > but in general these percentages will remain close.

    > The benchmarks were run on a **Ubuntu 24.04.1 LTS** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.

    > The version of zig used is **0.14.0-dev.2265+8a00bd4ce**.

    > The tool used for benchmarking is **[zBench](https://github.com/hendriknielaender/zBench)** version **0.9.1**.

    > You can find the source code for this benchmark here: **[io-bench](https://github.com/maysara-elshewehy/io-bench)**.

- ### Unicode Handling Comparison

    > The `std.ArrayList` does not support Unicode, so it is excluded from this comparison.

    > The following test demonstrates the difference in Unicode handling between the two implementations:

    - `String`
        ```zig
        var string = try String.init(allocator, "-☹️");
        defer string.deinit();
        try std.testing.expectEqualStrings("-☹️", string.src());

        try std.testing.expectEqualStrings("☹️", string.pop().?); // Correctly handles grapheme clusters.
        try std.testing.expectEqualStrings("-", string.src());
        ```

    - `@JakubSzark/zig-string`
        ```zig
        var string = try zig_string.init_with_contents(allocator, "-☹️");
        defer string.deinit();
        try std.testing.expectEqualStrings("-☹️", string.str());

        // Fails: Incorrectly splits the grapheme cluster.
        try std.testing.expectEqualStrings("☹️", string.pop().?); // Found '\xef'.
        try std.testing.expectEqualStrings("-", string.str());
        ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>