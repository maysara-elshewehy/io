# [←](../../readme.md) `io`.`utils`.`chars`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/logo/chars/logo.png" alt="chars" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <strong>Streamline string and character manipulation in Zig 🌟</strong><br />
</p>

<br />

</div>

> A **streamlined** and **powerful** library for **string** and **character** manipulation in **Zig**. It provides **efficient** and **robust** functions for typical operations such as **insertions**, **deletions**, **replacements**, and **searches**, with comprehensive **Unicode** support 🔥.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>


- #### Usage

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    // Creates a new array of characters with undefined value.
    var str = chars.make(64, null);

    // Appends a string to the array.
    chars.append(str[0..], 0, "Hello 🌍");              // 👉 "Hello 🌍"

    // Appends a character to the array.
    chars.append(str[0..], 10, '!');                    // 👉 "Hello 🌍!"

    // Removes a character using its positions.
    chars.remove(str[0..], 1);                          // 👉 "Hllo 🌍!"

    // Removes a range of string.
    chars.remove(str[0..], .{ 0, 9 });                  // 👉 "!"

    // Replace a part of string with another
    chars.replace(str[0..], 1, "!", "Hello 🌍!", 1);    // 👉 "Hello 🌍!"
    ```

- ### API

   - #### ❱ Basics

        | Method                      | Description                                                                                            |
        | --------------------------- | ------------------------------------------------------------------------------------------------------ |
        | [`size`](./api/size.md)     | Returns the size of a _(`string` or `char`)_.                                                          |
        | [`bytes`](./api/bytes.md)   | Returns the number of characters in the string.                                                        |
        | [`ubytes`](./api/ubytes.md) | Returns the number of characters in the string (Unicode characters are counted as regular characters). |
        | [`make`](./api/make.md)     | Returns a _(`fixed-string`)_ with specified size and content.                                          |
        | [`get`](./api/get.md)       | Returns the (`unicode` or `char`) at the specified position_(`non-real`)_ in the string.               |

   - #### ➕ Insertion

        | Method                              | Description                                                                                      |
        | ----------------------------------- | ------------------------------------------------------------------------------------------------ |
        | [`append`](./api/append.md)         | Inserts a _(`string` or `char`)_ into the `end` of the string.                                   |
        | [`prepend`](./api/prepend.md)       | Inserts a _(`string` or `char`)_ into the `beg` of the string.                                   |
        | [`insert`](./api/insert.md)         | Inserts a _(`string` or `char`)_ into a `specific position` in the string.                       |
        | [`insertReal`](./api/insertReal.md) | Inserts a _(`string` or `char`)_ into a `specific position` _(The real position)_ in the string. |

   - #### ➖ Deletion

        | Method                            | Description                                                             |
        | --------------------------------- | ----------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)       | Removes a _(`range` or `position`)_ from the string.                    |
        | [`shift`](./api/shift.md)         | Removes a _(`N` bytes)_ from the beg of the string.                     |
        | [`pop`](./api/pop.md)             | Removes a _(`N` bytes)_ from the end of the string _(using `/0`)_.      |
        | [`trim`](./api/trim.md)           | Removes all matching characters fromt both start and end of the string. |
        | [`trimEnd`](./api/trimEnd.md)     | Removes all matching characters at the end of the string.               |
        | [`trimStart`](./api/trimStart.md) | Removes all matching characters at the beg of the string.               |
        | [`zeros`](./api/zeros.md)         | Fills a string with _(`\0` character)_.                                 |

    - #### ➷ Find

        | Method                    | Description                                                           |
        | ------------------------- | --------------------------------------------------------------------- |
        | [`find`](./api/find.md)   | Returns the first occurrence of a _(`string` or `char`)_ in a string. |
        | [`rfind`](./api/rfind.md) | Returns the last occurrence of a _(`string` or `char`)_ in a string.  |

    - #### ❓ Check

        | Method                              | Description                                                   |
        | ----------------------------------- | ------------------------------------------------------------- |
        | [`eql`](./api/eql.md)               | Returns true if the given strings are equivalent.             |
        | [`includes`](./api/includes.md)     | Returns true if the string contains a _(`string` or `char`)_. |
        | [`endsWith`](./api/endsWith.md)     | Returns true if the string ends with the given substring.     |
        | [`startsWith`](./api/startsWith.md) | Returns true if the string starts with the given substring.   |

    - #### ⏪️ Replace

        | Method                          | Description                                                                                                    |
        | ------------------------------- | -------------------------------------------------------------------------------------------------------------- |
        | [`replace`](./api/replace.md)   | Replaces the first `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements. |
        | [`rreplace`](./api/rreplace.md) | Replaces the last `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements.  |

    - #### ▨ More

        | Method                        | Description                                                                |
        | ----------------------------- | -------------------------------------------------------------------------- |
        | [`repeat`](./api/repeat.md)   | Repeats the _(`string` or `char`)_ `N` times.                              |
        | [`reverse`](./api/reverse.md) | Reverses the characters in the string.                                     |
        | [`split`](./api/split.md)     | Splits the string into a slice based on a delimiter and a target position. |

  - #### Types

    > `io.utils.chars.types.<typeName>`.

    | Type       | Refer To     |
    | ---------- | ------------ |
    | `char`     | `u8`         |
    | `str`      | `[]u8`       |
    | `cstr`     | `[]const u8` |
    | `unsigned` | `usize`      |
    | `signed`   | `isize`      |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>