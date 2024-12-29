# [←](../readme.md) `io`.`types`.`buffer`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/logo/buffer/logo.png" alt="buffer" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <strong>Fixed string done right.</strong><br />
</p>

<br />

</div>

> A **streamlined** and **powerful** library for **fixed string** manipulation in **Zig**. It provides **efficient** and **robust** functions for typical operations such as **insertions**, **deletions**, **replacements**, and **searches**, with comprehensive **Unicode** support.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Usage

    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var buf = chars.make(64, "Hello 🌍!");  // Creates a fixed array of characters.
    var str = buffer(&buf);                 // Creates a new buffer structure.

    str.ubytes();                           // 👉 8     (Unicode characters are counted as regular characters).
    str.bytes();                            // 👉 11    Regular characters = 1, Unicode characters = 4.
    str.size();                             // 👉 64    Total size of the array.
    str.str.m_buff[0..str.m_bytes];         // 👉 "Hello 🌍!"
    ```

- ### API

   - #### ❱ Basics

        | Method                      | Description                                                                                            |
        | --------------------------- | ------------------------------------------------------------------------------------------------------ |
        | [`bytes`](./api/bytes.md)   | Returns the number of characters in the string.                                                        |
        | [`ubytes`](./api/ubytes.md) | Returns the number of characters in the string (Unicode characters are counted as regular characters). |
        | [`size`](./api/size.md)     | Returns the size of the string.                                                                        |

   - #### ➕ Insertion

        | Method                              | Description                                                                      |
        | ----------------------------------- | -------------------------------------------------------------------------------- |
        | [`append`](./api/append.md)         | Inserts a _(`string` or `char`)_ into the `end` of the string.                   |
        | [`prepend`](./api/prepend.md)       | Inserts a _(`string` or `char`)_ into the `beg` of the string.                   |
        | [`insert`](./api/insert.md)         | Inserts a _(`string` or `char`)_ into a `specific position` in the string.       |
        | [`insertReal`](./api/insertReal.md) | Inserts a _(`string` or `char`)_ into a `specific real  position` in the string. |

   - #### ➖ Deletion

        | Method                              | Description                                                                 |
        | ----------------------------------- | --------------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)         | Removes a _(`range` or `position`)_ from the string.                        |
        | [`removeReal`](./api/removeReal.md) | Removes a _(`range` or `real position`)_ from the string.                   |
        | [`shift`](./api/shift.md)           | Removes a _(`N` bytes)_ from the beg of the string.                         |
        | [`pop`](./api/pop.md)               | Removes a _(`N` bytes)_ from the end of the string _(using `/0`)_.          |
        | [`trim`](./api/trim.md)             | Removes all matching characters fromt both `start` and `end` of the string. |
        | [`trimEnd`](./api/trimEnd.md)       | Removes all matching characters at the `end` of the string.                 |
        | [`trimStart`](./api/trimStart.md)   | Removes all matching characters at the `beg` of the string.                 |

    - #### 🔍 Find

        | Method                    | Description                                                           |
        | ------------------------- | --------------------------------------------------------------------- |
        | [`find`](./api/find.md)   | Returns the first occurrence of a _(`string` or `char`)_ in a string. |
        | [`rfind`](./api/rfind.md) | Returns the last occurrence of a _(`string` or `char`)_ in a string.  |

    - #### ℀ Case

        | Method                        | Description                                     |
        | ----------------------------- | ----------------------------------------------- |
        | [`toLower`](./api/toLower.md) | Converts all (ASCII) letters to _`lower` case_. |
        | [`toUpper`](./api/toUpper.md) | Converts all (ASCII) letters to _`upper` case_. |
        | [`toTitle`](./api/toTitle.md) | Converts all (ASCII) words to _`title` case_.   |

    - #### ⚌ Check

        | Method                              | Description                                                               |
        | ----------------------------------- | ------------------------------------------------------------------------- |
        | [`eql`](./api/eql.md)               | Returns true if the string are equal to the given _(`string` or `char`)_. |
        | [`includes`](./api/includes.md)     | Returns true if the string contains a _(`string` or `char`)_.             |
        | [`endsWith`](./api/endsWith.md)     | Returns true if the string ends with the given _(`string` or `char`)_.    |
        | [`startsWith`](./api/startsWith.md) | Returns true if the string starts with the given _(`string` or `char`)_.  |

    - #### 🔄 Replace

        | Method                          | Description                                                                                                    |
        | ------------------------------- | -------------------------------------------------------------------------------------------------------------- |
        | [`replace`](./api/replace.md)   | Replaces the first `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements. |
        | [`rreplace`](./api/rreplace.md) | Replaces the last `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements.  |

    - #### ✂️ Split

        | Method                                            | Description                                                                                                                                    |
        | ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
        | [`split`](./api/split.md)                         | Returns a slice of the string split by the separator _(`string` or `char`)_ at the specified position, or null if failed.                      |
        | [`splitAll`](./api/splitAll.md)                   | Returns an array of slices of the string split by the separator _(`string` or `char`)_.                                                        |
        | [`splitToString`](./api/splitToString.md)         | Returns a slice of the string as `io.types.string` split by the separator _(`string` or `char`)_ at the specified position, or null if failed. |
        | [`splitAllToStrings`](./api/splitAllToStrings.md) | Returns an array of slices of `io.types.string` split by the separator _(`string` or `char`)_.                                                 |
        | [`lines`](./api/lines.md)                         | Returns an array of slices of the string split by the separator _(`\r\n` or `\n`)_.                                                            |


    - #### ▧ More

        | Method                        | Description                                   |
        | ----------------------------- | --------------------------------------------- |
        | [`repeat`](./api/repeat.md)   | Repeats the _(`string` or `char`)_ `N` times. |
        | [`reverse`](./api/reverse.md) | Reverses the characters in the string.        |

   - #### ✍️ Writer

        | Method                                | Description                                                                     |
        | ------------------------------------- | ------------------------------------------------------------------------------- |
        | [`Writer (Type)`](./api/Writer_t.md)  | The underlying type of the Writer returned by `writer()`.                       |
        | [`writer`](./api/writer.md)           | Returns a writer for the string.                                                |
        | [`write`](./api/write.md)             | Writes a _(`formatted string`)_ into the `end` of the string.                   |
        | [`writeStart`](./api/writeStart.md)   | Writes a _(`formatted string`)_ into the `beg` of the string.                   |
        | [`writeAt`](./api/writeAt.md)         | Writes a _(`formatted string`)_ into a `specific position` in the string.       |
        | [`writeAtReal`](./api/writeAtReal.md) | Writes a _(`formatted string`)_ into a `specific real  position` in the string. |

   - #### ➡️ Iterator

        | Method                                   | Description                                                   |
        | ---------------------------------------- | ------------------------------------------------------------- |
        | [`Iterator (Type)`](./api/Iterator_t.md) | The underlying type of the Iterator returned by `iterator()`. |
        | [`iterator`](./api/iterator.md)          | Returns an iterator for the string.                           |

   - #### ⡾ Fields

        | Field     | Description                               |
        | --------- | ----------------------------------------- |
        | `m_buff`  | Array of characters to store the content. |
        | `m_size`  | Size of the string.                       |
        | `m_bytes` | Length of the string.                     |


    - #### ⠟ Types

        | Type   | Refer To                                                         |
        | ------ | ---------------------------------------------------------------- |
        | `char` | [`io.utils.chars.types.char`](../../utils/chars/readme.md#types) |
        | `str`  | [`io.utils.chars.types.str`](../../utils/chars/readme.md#types)  |
        | `cstr` | [`io.utils.chars.types.cstr`](../../utils/chars/readme.md#types) |
        | `len`  | [`io.utils.chars.types.len`](../../utils/chars/readme.md#types)  |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>