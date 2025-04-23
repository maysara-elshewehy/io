<!----------------------------------- CSS ----------------------------------->

<style>
@font-face {
    font-family: 'Chakra Petch';
    src: url('https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/fonts/Chakra_Petch/ChakraPetch-Bold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}
</style>

<!--------------------------------------------------------------------------->



<!----------------------------------- BEG ----------------------------------->
<br>
<div align="center">
    <p style="font-size: 40px; font-family: 'Chakra Petch', sans-serif;">
        ASCII
    </p>
</div>

<p align="center">
    <img src="https://img.shields.io/badge/version-0.0.8 dev.1-blue.svg" alt="Version" />
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <a href="https://github.com/Super-ZIG/io/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="license" />
    </a>
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
    <b>
        When simplicity meets efficiency
    </b>
</p>

<div align="center">
    <b>
        <i>
            <sup>
                part of
                <a href="https://github.com/Super-ZIG" title="SuperZIG Framework">SuperZig</a><span style="color:gray;">::</span><a href="https://github.com/Super-ZIG/io" title="IO Library">io</a> library
            </sup>
        </i>
    </b>
</div>

<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    <br>
</div>

<!--------------------------------------------------------------------------->



<!--------------------------------- Features -------------------------------->

- **🍃 Zero dependencies**—meticulously crafted code.

- **🚀 Blazing fast**—almost as fast as light!

- **🌍 Universal compatibility**—Windows, Linux, and macOS.

- **🛡️ Battle-tested**—ready for production.

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- --- ----------------------------------->


- ### Quick Start 🔥

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const ascii = @import("io").string.utils.ascii;
    ```

    > Convert characters

    ```zig
    _ = ascii.toUpper('a');         // 👉 'A'
    _ = ascii.toLower('A');         // 👉 'a'
    ```

    > Check character properties

    ```zig
    _ = ascii.isUpper('A');         // 👉 true
    _ = ascii.isLower('a');         // 👉 true
    _ = ascii.isDigit('1');         // 👉 true
    _ = ascii.isHex('F');           // 👉 true
    _ = ascii.isWhitespace(' ');    // 👉 true
    _ = ascii.isPunctuation('!');   // 👉 true
    ...
    ```

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- API ----------------------------------->

- ### API

    - #### Conversion

        | Function | Description                                                                                    |
        | -------- | ---------------------------------------------------------------------------------------------- |
        | toUpper  | Converts a character to `uppercase`, If not a `lowercase` letter, it is returned `unchanged`.  |
        | toLower  | Converts a character to `lowercase`, If not an `uppercase` letter, it is returned `unchanged`. |

    - #### Properties

        | Function       | Description                                                                                             |
        | -------------- | ------------------------------------------------------------------------------------------------------- |
        | isUpper        | Returns true if the character is an uppercase letter (`A-Z`).                                           |
        | isLower        | Returns true if the character is a lowercase letter (`a-z`).                                            |
        | isAlphabetic   | Returns true if the character is an alphabetic letter (`A-Z`, `a-z`).                                   |
        | isDigit        | Returns true if the character is a numeric digit (`0-9`).                                               |
        | isAlphanumeric | Returns true if the character is alphanumeric (`A-Z`, `a-z`, `0-9`).                                    |
        | isHex          | Returns true if the character is a hexadecimal digit (`0-9`, `A-F`, `a-f`).                             |
        | isOctal        | Returns true if the character is an octal digit (`0-7`).                                                |
        | isBinary       | Returns true if the character is a binary digit (`0-1`).                                                |
        | isPunctuation  | Returns true if the character is a punctuation symbol (`!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, ..).     |
        | isWhitespace   | Returns true if the character is a whitespace character (`space`, `tab`, `newline`, `carriage return`). |
        | isPrintable    | Returns true if the character is printable (`A-Z`, `a-z`, `0-9`, `punctuation marks`, `space`).         |
        | isControl      | Returns true if the character is a control character (`ASCII 0x00-0x1F or 0x7F`).                       |

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!---------------------------------- BENCH ---------------------------------->

- ### Benchmark

    > A quick summary with sample performance test results between _**`SuperZIG`.`io`.`string`.`utils`.`ascii`**_ implementations and its popular competitors.

    - #### vs `std.ascii`

        > _**In summary**, the two run at **the same speed** because they share almost the same code. ✨_

        - #### Debug Build (`zig build run -- ascii`)

            | Implementation | Scale | Runs   | Total Time | Avg Time/Run |
            | -------------- | ----- | ------ | ---------- | ------------ |
            | `std`          | x10   | 100000 | 793.9ms    | 7.9μs        |
            | `io`           | x10   | 100000 | 821.5ms    | 8.2μs        |
            | `std`          | x1k   | 2221   | 2.4s       | 1.1ms        |
            | `io`           | x1k   | 2549   | 2.0s       | 801.5μs      |
            | `std`          | x100k | 25     | 2.0s       | 78.4ms       |
            | `io`           | x100k | 26     | 1.9s       | 72.7ms       |

        - #### Release Build (`zig build run --release=fast -- ascii`)

            | Implementation | Scale | Runs   | Total Time | Avg Time/Run |
            | -------------- | ----- | ------ | ---------- | ------------ |
            | `std`          | x10   | 100000 | 1.5ms      | 15ns         |
            | `io`           | x10   | 100000 | 1.5ms      | 14ns         |
            | `std`          | x1k   | 100000 | 1.5ms      | 14ns         |
            | `io`           | x1k   | 100000 | 1.4ms      | 14ns         |
            | `std`          | x100k | 100000 | 1.4ms      | 13ns         |
            | `io`           | x100k | 100000 | 1.3ms      | 13ns         |

    > **It is normal for the values ​​to differ each time the benchmark is run, but in general these percentages will remain close.**

    > The benchmarks were run on a **Windows 11 v24H2** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.
    >
    > The version of zig used is **0.14.0**.
    >
    > The source code of this benchmark **[bench/string/utils/ascii.zig](https://github.com/Super-ZIG/io-bench/tree/main/src/bench/string/utils/ascii.zig)**.

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- END ----------------------------------->

<br>
<div align="center">
    <a href="https://github.com/maysara-elshewehy">
        <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/>
    </a>
</div>

<!--------------------------------------------------------------------------->