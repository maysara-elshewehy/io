<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/logo/Bytes/logo.png" alt="Bytes" width="1000" />
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

<p align="center"> <b>Simplified and perfected.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### API

   - #### ✨ Initialization

        | Function                                | Description                                                  |
        | --------------------------------------- | ------------------------------------------------------------ |
        | [`init`](./api/init.md)                 | Initializes an array of bytes of a given `size` and `value`. |
        | [`initCapacity`](./api/initCapacity.md) | Initializes an array of bytes of a given `size`.             |

   - #### ➕ Insert

        | Function                                      | Description                                                       |
        | --------------------------------------------- | ----------------------------------------------------------------- |
        | [`insert`](./api/insert.md)                   | Inserts a `slice` into `dest` at the specified `position`.        |
        | [`insertOne`](./api/insertOne.md)             | Inserts a `byte` into `dest` at the specified `position`.         |
        | [`insertVisual`](./api/insertVisual.md)       | Inserts a `slice` into `dest` at the specified `visual position`. |
        | [`insertVisualOne`](./api/insertVisualOne.md) | Inserts a `byte` into `dest` at the specified `visual position`.  |
        | [`append`](./api/append.md)                   | Appends a `slice` into `dest`.                                    |
        | [`appendOne`](./api/appendOne.md)             | Appends a `byte` into `dest`.                                     |
        | [`prepend`](./api/prepend.md)                 | Prepends a `slice` into `dest`.                                   |
        | [`prependOne`](./api/prependOne.md)           | Prepends a `byte` into `dest`.                                    |

   - #### ➖ Remove

        | Function                                          | Description                                                                            |
        | ------------------------------------------------- | -------------------------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)                       | Removes a byte from the `dest`.                                                        |
        | [`removeRange`](./api/removeRange.md)             | Removes a `range` of bytes from the `dest`.                                            |
        | [`removeVisual`](./api/removeVisual.md)           | Removes a byte from the `dest` by the `visual position`.                               |
        | [`removeVisualRange`](./api/removeVisualRange.md) | Removes a `range` of bytes from the `dest` by the `visual position`.                   |
        | [`pop`](./api/pop.md)                             | Returns the length of the last grapheme cluster at the `dest`.                         |
        | [`shift`](./api/shift.md)                         | Removes the first grapheme cluster at the `dest`, Returns the number of removed Bytes. |

   - #### 🔍 Search

        | Method                                | Description                                                          |
        | ------------------------------------- | -------------------------------------------------------------------- |
        | [`find`](./api/find.md)               | Finds the `position` of the **first** occurrence of `target`.        |
        | [`findVisual`](./api/findVisual.md)   | Finds the `visual position` of the **first** occurrence of `target`. |
        | [`rfind`](./api/rfind.md)             | Finds the `position` of the **last** occurrence of `target`.         |
        | [`rfindVisual`](./api/rfindVisual.md) | Finds the `visual position` of the **last** occurrence of `target`.  |
        | [`includes`](./api/includes.md)       | Returns `true` **if `dest` contains `target`**.                      |
        | [`startsWith`](./api/startsWith.md)   | Returns `true` **if `dest` starts with `target`**.                   |
        | [`endsWith`](./api/endsWith.md)       | Returns `true` **if `dest` ends with `target`**.                     |

   - #### 🌈 Letter Cases

        | Method                        | Description                                |
        | ----------------------------- | ------------------------------------------ |
        | [`toLower`](./api/toLower.md) | Converts all (ASCII) letters to lowercase. |
        | [`toUpper`](./api/toUpper.md) | Converts all (ASCII) letters to uppercase. |
        | [`toTitle`](./api/toTitle.md) | Converts all (ASCII) letters to titlecase. |

   - #### 🪄 Data

        | Function                                | Description                                       |
        | --------------------------------------- | ------------------------------------------------- |
        | [`countWritten`](./api/countWritten.md) | Returns the total number of written Bytes.        |
        | [`countVisual`](./api/countVisual.md)   | Returns the total number of visual characters.    |
        | [`writtenSlice`](./api/writtenSlice.md) | Returns a slice containing only the written part. |

   - #### ✔️ Validation

        | Function                      | Description                                                |
        | ----------------------------- | ---------------------------------------------------------- |
        | [`isByte`](./api/isByte.md)   | Returns `true` **if the value is a valid byte**.           |
        | [`isBytes`](./api/isBytes.md) | Returns `true` **if the value is a valid array of bytes**. |

   - #### ✂️ Split

        | Function                        | Description                                                                    |
        | ------------------------------- | ------------------------------------------------------------------------------ |
        | [`split`](./api/split.md)       | Splits string into substrings by delimiter and returns substring at index.     |
        | [`splitAll`](./api/splitAll.md) | Splits string into substrings by delimiter and returns an array of substrings. |

   - #### 🛠️ Replace

        | Function                                            | Description                                          |
        | --------------------------------------------------- | ---------------------------------------------------- |
        | [`replaceAllChars`](./api/replaceAllChars.md)       | Replaces all occurrence of a character with another. |
        | [`replaceAllSlices`](./api/replaceAllSlices.md)     | Replaces all occurrences of a slice with another.    |
        | [`replaceRange`](./api/replaceRange.md)             | Replaces a range of bytes with another.              |
        | [`replaceVisualRange`](./api/replaceVisualRange.md) | Replaces a visual range of bytes with another.       |

   - #### 🌟 More

        | Function                      | Description                      |
        | ----------------------------- | -------------------------------- |
        | [`reverse`](./api/reverse.md) | Reverses the order of the Bytes. |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.utils.Unicode](../Unicode/Unicode.md)
    > A set of useful functions for working with unicode.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>