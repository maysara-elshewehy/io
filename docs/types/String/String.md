<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/logo/String/logo.png" alt="String" width="1000" />
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

<p align="center"> <b>Managed dynamic-size string type that supports Unicode.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### API

  - #### 🧩 Fields

      | Field         | Type                | Description                                            |
      | ------------- | ------------------- | ------------------------------------------------------ |
      | `m_allocator` | `std.mem.Allocator` | Allocator used for memory management.                  |
      | `m_source`    | `[]u8`              | The mutable unicode encoded Bytes.                     |
      | `m_capacity`  | `usize`             | The number of bytes that can be written to `m_source`. |

   - #### ✨ Initialization

        | Function                                | Description                                                                 |
        | --------------------------------------- | --------------------------------------------------------------------------- |
        | [`init`](./api/init.md)                 | Initializes a new `String` instance with the given `allocator` and `value`. |
        | [`initAlloc`](./api/initAlloc.md)       | Initializes a new `String` instance with the given `allocator`.             |
        | [`initCapacity`](./api/initCapacity.md) | Initializes a new `String` instance with `allocator` and `size`.            |
        | [`deinit`](./api/deinit.md)             | Release all allocated memory.                                               |

   - #### ➕ Insert

        | Function                                      | Description                                                         |
        | --------------------------------------------- | ------------------------------------------------------------------- |
        | [`insert`](./api/insert.md)                   | Inserts a `slice` at the specified `position` by **real position**. |
        | [`insertOne`](./api/insertOne.md)             | Inserts a `byte` at the specified `position` by **real position**.  |
        | [`insertVisual`](./api/insertVisual.md)       | Inserts a `slice` at the specified `visual position`.               |
        | [`insertVisualOne`](./api/insertVisualOne.md) | Inserts a `byte` at the specified `visual position`.                |
        | [`append`](./api/append.md)                   | Appends a `slice` into the `String` instance.                       |
        | [`appendOne`](./api/appendOne.md)             | Appends a `byte` into the `String` instance.                        |
        | [`prepend`](./api/prepend.md)                 | Prepends a `slice` into the `String` instance.                      |
        | [`prependOne`](./api/prependOne.md)           | Prepends a `byte` into the `String` instance.                       |

   - #### ➖ Remove

        | Function                                          | Description                                                                                       |
        | ------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)                       | Removes a byte from the `String` instance.                                                        |
        | [`removeRange`](./api/removeRange.md)             | Removes a `range` of bytes from the `String` instance.                                            |
        | [`removeVisual`](./api/removeVisual.md)           | Removes a byte from the `String` instance by the `visual position`.                               |
        | [`removeVisualRange`](./api/removeVisualRange.md) | Removes a `range` of bytes from the `String` instance by the `visual position`.                   |
        | [`pop`](./api/pop.md)                             | Removes the last grapheme cluster at the `String` instance, Returns the number of removed Bytes.  |
        | [`shift`](./api/shift.md)                         | Removes the first grapheme cluster at the `String` instance, Returns the number of removed Bytes. |

   - #### 🔍 Search

      | Method                                | Description                                                          |
      | ------------------------------------- | -------------------------------------------------------------------- |
      | [`find`](./api/find.md)               | Finds the `position` of the **first** occurrence of `target`.        |
      | [`findVisual`](./api/findVisual.md)   | Finds the `visual position` of the **first** occurrence of `target`. |
      | [`rfind`](./api/rfind.md)             | Finds the `position` of the **last** occurrence of `target`.         |
      | [`rfindVisual`](./api/rfindVisual.md) | Finds the `visual position` of the **last** occurrence of `target`.  |
      | [`includes`](./api/includes.md)       | Returns `true` **if contains `target`**.                             |
      | [`startsWith`](./api/startsWith.md)   | Returns `true` **if starts with `target`**.                          |
      | [`endsWith`](./api/endsWith.md)       | Returns `true` **if ends with `target`**.                            |

   - #### 🌈 Letter Cases

        | Method                        | Description                                |
        | ----------------------------- | ------------------------------------------ |
        | [`toLower`](./api/toLower.md) | Converts all (ASCII) letters to lowercase. |
        | [`toUpper`](./api/toUpper.md) | Converts all (ASCII) letters to uppercase. |
        | [`toTitle`](./api/toTitle.md) | Converts all (ASCII) letters to titlecase. |

   - #### 🪄 Data

        | Function                                    | Description                                                     |
        | ------------------------------------------- | --------------------------------------------------------------- |
        | [`length`](./api/length.md)                 | Returns the total number of written Bytes.                      |
        | [`vlength`](./api/vlength.md)               | Returns the total number of visual characters.                  |
        | [`slice`](./api/slice.md)                   | Returns a slice containing only the written part.               |
        | [`allocatedSlice`](./api/allocatedSlice.md) | Returns a slice representing the entire allocated memory range. |

   - #### ➰ Iterations

        | Function                        | Description                                           |
        | ------------------------------- | ----------------------------------------------------- |
        | [`iterator`](./api/iterator.md) | Creates an iterator for traversing the unicode bytes. |

   - #### ✂️ Split

        | Function                                        | Description                                                                                           |
        | ----------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
        | [`split`](./api/split.md)                       | Splits string into substrings by delimiter and returns substring at index.                            |
        | [`splitAll`](./api/splitAll.md)                 | Splits string into substrings by delimiter and returns an array of substrings.                        |
        | [`splitToString`](./api/splitToString.md)       | Splits string into substrings by delimiter and returns substring at index as a new `String` instance. |
        | [`splitAllToString`](./api/splitAllToString.md) | Splits string into substrings by delimiter and returns an array of new `String` instances.            |

   - #### 🛠️ Replace

        | Function                                            | Description                                          |
        | --------------------------------------------------- | ---------------------------------------------------- |
        | [`replaceAllChars`](./api/replaceAllChars.md)       | Replaces all occurrence of a character with another. |
        | [`replaceAllSlices`](./api/replaceAllSlices.md)     | Replaces all occurrences of a slice with another.    |
        | [`replaceRange`](./api/replaceRange.md)             | Replaces a range of bytes with another.              |
        | [`replaceVisualRange`](./api/replaceVisualRange.md) | Replaces a visual range of bytes with another.       |

   - #### 🌟 More

        | Function                      | Description                                                       |
        | ----------------------------- | ----------------------------------------------------------------- |
        | [`reverse`](./api/reverse.md) | Reverses the order of the characters **_(considering unicode)_**. |
        | [`clone`](./api/clone.md)     | Returns a copy of the `String` instance.                          |
        | [`equals`](./api/equals.md)   | Checks if two strings are equal.                                  |
        | [`isEmpty`](./api/isEmpty.md) | Checks if the string is empty.                                    |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.type.uString](../uString/uString.md)
    > Unmanaged dynamic-size string type that supports Unicode.

  - #### [io.type.Viewer](../Viewer/Viewer.md)
    > Immutable fixed-size string type that supports Unicode.

  - #### [io.type.String](../String/String.md)
    > Mutable fixed-size string type that supports Unicode.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>