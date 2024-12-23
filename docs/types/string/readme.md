# [←](../../readme.md) `io`.`utils`.`string`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/logo/string/logo.png" alt="string" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <strong>Dynamic string done right.</strong><br />
</p>

<br />

</div>

> A **streamlined** and **powerful** library for **dynamic string** manipulation in **Zig**. It provides **efficient** and **robust** functions for typical operations such as **insertions**, **deletions**, **replacements**, and **searches**, with comprehensive **Unicode** support.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Usage 🌀

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init();        // Creates a new string structure.
    defer string.deinit();          // Cleans up the allocated memory (if allocated) when the scope ends.

    try str.append("Hello 🌍!");    // 👉 "Hello 🌍!"
    str.len();                      // 👉 8     All characters = 1.
    str.bytes();                    // 👉 11    Normal characters = 1, Unicode characters = 4.
    str.size();                     // 👉 22    Total size of the allocated memory.
    str.src();                      // 👉 "Hello 🌍!"
    ```

- ### API

   - #### ☵ Init

        | Method                          | Description                                                  |
        | ------------------------------- | ------------------------------------------------------------ |
        | [`init`](./api/init.md)         | Initialize an empty string.                                  |
        | [`initWith`](./api/initWith.md) | Initialize a string with an allocator and a given substring. |
        | [`deinit`](./api/initWith.md)   | Deallocate the string buffer.                                |
        | [`allocate`](./api/initWith.md) | Allocate or reallocate the string buffer to a new size.      |

   - #### ❱ Basics

        | Method                      | Description                                                                                            |
        | --------------------------- | ------------------------------------------------------------------------------------------------------ |
        | [`bytes`](./api/bytes.md)   | Returns the number of characters in the buffer.                                                        |
        | [`ubytes`](./api/ubytes.md) | Returns the number of characters in the buffer (Unicode characters are counted as regular characters). |
        | [`size`](./api/size.md)     | Returns the size of the buffer.                                                                        |
        | [`src`](./api/src.md)       | Returns the source of the buffer.                                                                      |

   - #### ⡾ Fields

        | Field     | Description                                        |
        | --------- | -------------------------------------------------- |
        | `m_buff`  | Nullable array of characters to store the content. |
        | `m_alloc` | Allocator used for memory management.              |
        | `m_size`  | Size of the buffer.                                |
        | `m_bytes` | Length of the buffer.                              |


    - #### ⠟ Types

        | Type       | Refer To                                                             |
        | ---------- | -------------------------------------------------------------------- |
        | `char`     | [`io.utils.chars.types.char`](../../utils/chars/readme.md#types)     |
        | `str`      | [`io.utils.chars.types.str`](../../utils/chars/readme.md#types)      |
        | `cstr`     | [`io.utils.chars.types.cstr`](../../utils/chars/readme.md#types)     |
        | `unsigned` | [`io.utils.chars.types.unsigned`](../../utils/chars/readme.md#types) |
        | `signed`   | [`io.utils.chars.types.signed`](../../utils/chars/readme.md#types)   |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>