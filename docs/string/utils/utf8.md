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
        UTF-8
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
    const utf8 = @import("io").string.utils.utf8;
    ```

    > Convert slice to codepoint

    ```zig
    const cp = utf8.decode("🌟");                   // cp 👉 0x1F31F
    ```

    > Convert codepoint to slice

    ```zig
    var buf: [4]u8 = undefined;
    const len = utf8.encode(0x1F31F, &buf);         // len 👉 4
                                                    // buf 👉 "🌟"
    ```

    > Get codepoint length

    ```zig
    const len = utf8.getCodepointLength(0x1F31F)    // 👉 4
    ```

    > Get UTF-8 sequence length

    ```zig
    const len = utf8.getCodepointLength("🌟"[0])    // 👉 4
    ```

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- API ----------------------------------->

- ### API

    - #### Encoding / Decoding

        | Function | Description                                                                                        |
        | -------- | -------------------------------------------------------------------------------------------------- |
        | encode _(`cp: u21, out: []u8`) `u3`_  | Fast encode a single Unicode `codepoint` to `UTF-8 sequence`, Returns the number of bytes written. |
        | decode _(`slice: []const u8`) `u21`_  | Fast decode a `UTF-8 sequence` to a Unicode `codepoint`, Returns the decoded codepoint.            |

    - #### Properties

        | Function           | Description                                                                                 |
        | ------------------ | ------------------------------------------------------------------------------------------- |
        | getCodepointLength _(`cp: u21`) `u3`_ | Returns the number of bytes (`1-4`) needed to encode a `codepoint` in UTF-8 format.         |
        | getSequenceLength _(`first_byte: u8`) `u3`_  | Returns the expected number of bytes (`1-4`) in a `UTF-8 sequence` based on the first byte. |

    - #### Validation

        | Function           | Description                                                         |
        | ------------------ | ------------------------------------------------------------------- |
        | isValid _(`slice: []const u8`) `bool`_ | Returns true if the provided slice contains valid `UTF-8 sequence`. |

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!---------------------------------- BENCH ---------------------------------->

- ### Benchmark

    > A quick summary with sample performance test results between _**`SuperZIG`.`io`.`string`.`utils`.`utf8`**_ implementations and its popular competitors.

    - #### vs `std.unicode`

        > _**In summary**, `io` is faster by **5 times** compared to `std` in most cases, thanks to its optimized implementation. ✨_

        - #### Debug Build (`zig build run -- utf8`)

            | Implementation | Scale | Runs | Total Time | Avg Time/Run |
            | -------------- | ----- | ---- | ---------- | ------------ |
            | `std`          | x10   | 1099 | 2.01s      | 1.829ms      |
            | `io`           | x10   | 3158 | 2.043s     | 646.947μs    |
            | `std`          | x1k   | 10   | 1.885s     | 188.5ms      |
            | `io`           | x1k   | 32   | 2.031s     | 63.473ms     |
            | `std`          | x100k | 1    | 18.938s    | 18.938s      |
            | `io`           | x100k | 1    | 6.38s      | 6.38s        |

        - #### Release Build (`zig build run --release=fast -- utf8`)

            | Implementation | Scale | Runs  | Total Time | Avg Time/Run |
            | -------------- | ----- | ----- | ---------- | ------------ |
            | `std`          | x10   | 10829 | 1.963s     | 181.28μs     |
            | `io`           | x10   | 60651 | 1.951s     | 32.169μs     |
            | `std`          | x1k   | 103   | 1.974s     | 19.171ms     |
            | `io`           | x1k   | 592   | 2.101s     | 3.55ms       |
            | `std`          | x100k | 1     | 1.936s     | 1.936s       |
            | `io`           | x100k | 5     | 1.764s     | 352.809ms    |

    > **It is normal for the values ​​to differ each time the benchmark is run, but in general these percentages will remain close.**

    > The benchmarks were run on a **Windows 11 v24H2** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.
    >
    > The version of zig used is **0.14.0**.
    >
    > The source code of this benchmark **[bench/string/utils/utf8.zig](https://github.com/Super-ZIG/io-bench/tree/main/src/bench/string/utils/utf8.zig)**.

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