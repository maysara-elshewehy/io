<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/String/logo.png" alt="String" width="1000" />
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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center">
    <b><i>
        <sup> 🔥 Built for power. Designed for speed. Ready for production. 🔥 </sup>
    </i></b>
</div>
<br>

- ### Features 🌟

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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🎇 API Reference](#api) – Detailed documentation of available functions.

    🔹 [⚡ Performance & Benchmarks](#benchmarking) – Speed comparisons with other implementations.

    🔹 [🌍 Comparisons](#comparisons) – Detailed comparison with other string libraries.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

    > This library provides several types, each with its own approach to handling strings in the ZIG language.

    > You can choose from the following types according to the intended purpose:

    | Type                      | Description                                               |
    | ------------------------- | --------------------------------------------------------- |
    | [`Viewer`](./viewer)   | Immutable fixed-size string type that supports unicode.   |
    | [`Buffer`](./buffer)   | Mutable fixed-size string type that supports unicode.     |
    | [`String`](./string)   | Managed dynamic-size string type that supports unicode.   |
    | [`uString`](./ustring) | Unmanaged dynamic-size string type that supports unicode. |


    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    </div>

    > Internal utility modules for handling char arrays and Unicode operations.

    | Module                    | Description                                                     |
    | ------------------------- | --------------------------------------------------------------- |
    | [`chars`](./chars)     | Utility functions for char arrays.                              |
    | [`unicode`](./unicode) | Utility functions for Unicode codepoints and grapheme clusters. |


    <div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    </div>

    > ✔️ Implemented and tested.
    >
    > ⚒️ Under development.
    >
    > 🔩 Exists only for internal API integration.
    >
    > ❌ Contradicts container logic.

    | Function           | Viewer | Buffer | String | uString |
    | ------------------ | ------ | ------ | ------ | ------- |
    | init               | ✔️      | ✔️      | ✔️      | ✔️       |
    | initEmpty          | ✔️      | ✔️      | ✔️      | ✔️       |
    | initWithSelf       | ✔️      | ✔️      | ✔️      | ✔️       |
    | initWithSlice      | ✔️      | ✔️      | ✔️      | ✔️       |
    | initWithChar       | ❌      | ✔️      | ✔️      | ✔️       |
    | initWithCapacity   | ❌      | ✔️      | ✔️      | ✔️       |
    | initWithFmt        | ❌      | ✔️      | ✔️      | ✔️       |
    | initWithAllocator  | ❌      | ❌      | ✔️      | 🔩       |
    | deinit             | ❌      | ❌      | ✔️      | ✔️       |
    | size               | ✔️      | ✔️      | ✔️      | ✔️       |
    | len                | ✔️      | ✔️      | ✔️      | ✔️       |
    | vlen               | ✔️      | ✔️      | ✔️      | ✔️       |
    | src                | ✔️      | ✔️      | ✔️      | ✔️       |
    | sub                | ✔️      | ✔️      | ✔️      | ✔️       |
    | cString            | ❌      | ✔️      | ✔️      | ✔️       |
    | allocatedSlice     | ❌      | ❌      | ✔️      | ✔️       |
    | iterator           | ✔️      | ✔️      | ✔️      | ✔️       |
    | writer             | ❌      | ✔️      | ✔️      | ✔️       |
    | charAt             | ✔️      | ✔️      | ✔️      | ✔️       |
    | atVisual           | ✔️      | ✔️      | ✔️      | ✔️       |
    | find               | ✔️      | ✔️      | ✔️      | ✔️       |
    | findVisual         | ✔️      | ✔️      | ✔️      | ✔️       |
    | findLast           | ✔️      | ✔️      | ✔️      | ✔️       |
    | findLastVisual     | ✔️      | ✔️      | ✔️      | ✔️       |
    | includes           | ✔️      | ✔️      | ✔️      | ✔️       |
    | startsWith         | ✔️      | ✔️      | ✔️      | ✔️       |
    | endsWith           | ✔️      | ✔️      | ✔️      | ✔️       |
    | clone              | ✔️      | ✔️      | ✔️      | ✔️       |
    | isEqual            | ✔️      | ✔️      | ✔️      | ✔️       |
    | isEmpty            | ✔️      | ✔️      | ✔️      | ✔️       |
    | insert             | ❌      | ✔️      | ✔️      | ✔️       |
    | insertSlice        | ❌      | ✔️      | ✔️      | ✔️       |
    | insertChar         | ❌      | ✔️      | ✔️      | ✔️       |
    | insertSelf         | ❌      | ✔️      | ✔️      | ✔️       |
    | insertFmt          | ❌      | ✔️      | ✔️      | ✔️       |
    | visualInsert       | ❌      | ✔️      | ✔️      | ✔️       |
    | visualInsertSlice  | ❌      | ✔️      | ✔️      | ✔️       |
    | visualInsertChar   | ❌      | ✔️      | ✔️      | ✔️       |
    | visualInsertSelf   | ❌      | ✔️      | ✔️      | ✔️       |
    | visualInsertFmt    | ❌      | ✔️      | ✔️      | ✔️       |
    | append             | ❌      | ✔️      | ✔️      | ✔️       |
    | appendSlice        | ❌      | ✔️      | ✔️      | ✔️       |
    | appendChar         | ❌      | ✔️      | ✔️      | ✔️       |
    | appendSelf         | ❌      | ✔️      | ✔️      | ✔️       |
    | appendFmt          | ❌      | ✔️      | ✔️      | ✔️       |
    | prepend            | ❌      | ✔️      | ✔️      | ✔️       |
    | prependSlice       | ❌      | ✔️      | ✔️      | ✔️       |
    | prependChar        | ❌      | ✔️      | ✔️      | ✔️       |
    | prependSelf        | ❌      | ✔️      | ✔️      | ✔️       |
    | prependFmt         | ❌      | ✔️      | ✔️      | ✔️       |
    | repeat             | ❌      | ✔️      | ✔️      | ✔️       |
    | removeIndex        | ❌      | ✔️      | ✔️      | ✔️       |
    | removeVisualIndex  | ❌      | ✔️      | ✔️      | ✔️       |
    | removeRange        | ❌      | ✔️      | ✔️      | ✔️       |
    | removeVisualRange  | ❌      | ✔️      | ✔️      | ✔️       |
    | pop                | ❌      | ✔️      | ✔️      | ✔️       |
    | shift              | ❌      | ✔️      | ✔️      | ✔️       |
    | trim               | ❌      | ✔️      | ✔️      | ✔️       |
    | trimStart          | ❌      | ✔️      | ✔️      | ✔️       |
    | trimEnd            | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceRange       | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceVisualRange | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceFirst       | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceFirstN      | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceLast        | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceLastN       | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceNth         | ❌      | ✔️      | ✔️      | ✔️       |
    | replaceAll         | ❌      | ✔️      | ✔️      | ✔️       |
    | toLower            | ❌      | ✔️      | ✔️      | ✔️       |
    | toUpper            | ❌      | ✔️      | ✔️      | ✔️       |
    | toTitle            | ❌      | ✔️      | ✔️      | ✔️       |
    | reverse            | ❌      | ✔️      | ✔️      | ✔️       |
    | split              | ✔️      | ✔️      | ✔️      | ✔️       |
    | splitAll           | ✔️      | ✔️      | ✔️      | ✔️       |
    | splitToSelf        | ✔️      | ✔️      | ✔️      | ✔️       |
    | splitAllToSelf     | ✔️      | ✔️      | ✔️      | ✔️       |
    | clear              | ✔️      | ✔️      | ✔️      | ✔️       |
    | clearAndFree       | ❌      | ❌      | ✔️      | ✔️       |
    | shrink             | ❌      | ❌      | ✔️      | ✔️       |
    | shrinkAndFree      | ❌      | ❌      | ✔️      | ✔️       |
    | resize             | ❌      | ❌      | ✔️      | ✔️       |
    | fromOwnedSlice     | ❌      | ❌      | ✔️      | ✔️       |
    | toOwnedSlice       | ❌      | ❌      | ✔️      | ✔️       |
    | toManaged          | ⚒️      | ⚒️      | ❌      | ✔️       |
    | toUnmanaged        | ⚒️      | ⚒️      | ✔️      | ❌       |
    | toViewer           | ❌      | ⚒️      | ✔️      | ✔️       |
    | toInteger          | ⚒️      | ⚒️      | ⚒️      | ⚒️       |
    | toFloat            | ⚒️      | ⚒️      | ⚒️      | ⚒️       |
    | print              | ✔️      | ✔️      | ✔️      | ✔️       |
    | printTo            | ✔️      | ✔️      | ✔️      | ✔️       |
    | printWithNewLine   | ✔️      | ✔️      | ✔️      | ✔️       |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
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

    > You can find the source code for this benchmark here: **[SuperZIG-bench](https://github.com/maysara-elshewehy/SuperZIG-bench)**.

### Comparisons

- ### Comparison with Zig's Standard Library
    > Zig provides `std.unicode`, which includes utilities like `Utf8View` and `Utf8Iterator`.
    >
    > These are useful and were leveraged in our implementation of Unicode support.
    >
    > However, they have significant limitations.

    - #### Unicode Iteration
        > Consider the following text:
        ```zig
        const txt = "Aأ你🌟☹️👨‍🏭";
        ```
        > Each character in this string is represented as follows:

        | Character | Bytes | Codepoints |
        | --------- | ----- | ---------- |
        | `A`       | 1     | 1          |
        | `أ`       | 2     | 1          |
        | `你`      | 3     | 1          |
        | `🌟`       | 4     | 1          |
        | `☹️`       | 6     | 2          |
        | `👨‍🏭`       | 11    | 3          |

        - #### Iteration Using Zig's Standard Library
            > The only way to iterate over characters using Zig's standard library is:

            ```zig
            const std_view = try std.unicode.Utf8View.init("Aأ你🌟☹️👨‍🏭");
            var std_iter = std_view.iterator();

            while (std_iter.nextCodepointSlice()) |res|
                std.debug.print("{s}\n", .{res});
            ```

            **Output:**
            ```
            A
            ╪ú (أ)
            Σ╜á (你)
            ≡ƒîƒ (🌟)
            Γÿ╣ (Emoji part of ☹️)
            ∩╕Å (Modifier)
            ≡ƒæ¿ (👨)
            ΓÇì (ZWJ)
            ≡ƒÅ¡ (🏭)
            ```

            > As you can see, the standard library does not provide a way to iterate over real visual characters (grapheme clusters).

      - #### Iteration Using Our Library
        > We provide a better approach that allows iterating over grapheme clusters:

        ```zig
        var io_iter = try io.unicode.Iterator.init("Aأ你🌟☹️👨‍🏭");
        while (io_iter.nextGraphemeClusterSlice()) |res|
            std.debug.print("{s}\n", .{res});
        ```

        **Output:**
        ```
        A
        ╪ú (أ)
        Σ╜á (你)
        ≡ƒîƒ (🌟)
        Γÿ╣∩╕Å (☹️)
        ≡ƒæ¿ΓÇì≡ƒÅ¡ (👨‍🏭)
        ```

        > Our library correctly groups Unicode characters into proper grapheme clusters, making it a superior solution for text handling.

- ### Additional Comparisons

    #### `@JakubSzark/zig-string`
    - **Slow performance**: The implementation is not optimized for speed.
    - **Limited functionality**: Only supports UTF-8 code points but not full Unicode grapheme clusters.
    - **Incorrect behavior**: Mishandles Unicode text splitting.

    #### `zg`
    - Focused on Unicode normalization using a full local Unicode database.
    - Designed for a different purpose, making direct comparison with our library irrelevant.

    ### Why Our Library is Superior
    Our library provides:
    - **Proper Unicode support**: Handling grapheme clusters as expected.
    - **Performance**: Matching the speed of the Zig standard library.
    - **Feature completeness**: Everything offered by `std.ArrayList` and more.
    - **Real-world usability**: A practical and efficient solution for text processing.

    ### Final Thoughts
    We have invested significant time in understanding Unicode and designing an efficient approach. The claim that we have merely "simplified" text handling is inaccurate. Instead, we have **innovated and optimized** the process to create a truly robust solution.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>