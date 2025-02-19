<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/Chars/logo.png" alt="Chars" width="1000" />
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
    <b> Utility functions for character arrays. </b>
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

    - 🌍 **Unicode Support**
        > Properly handles Unicode, preserving character integrity, including complex grapheme clusters like emojis and modifiers.

    - ⚡ **Blazing Fast Performance**
        > Matches the speed of Zig’s standard library and outperforms competitors in benchmarks.

    - 🛡️ **Rock-Solid Stability**
        > Every function is rigorously tested, making the library safe, reliable, and ready for production.

    - 🏗️ **Optimized for Scalability**
        > Designed with efficiency in mind, avoiding unnecessary allocations while maintaining flexibility.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🎇 API Reference](#api) – Detailed documentation of available functions.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const chars = @import("io").chars;
    ```

    > Now let's create our container, but before that we need to define the data type used to store the values, for example:
    >
    > If you are going to deal with (`utf8`, `utf16`, ..) encoding, you can use (`u8`, `u16`, ..) as the data type.

    ```zig
    var array = chars.initWithCapacity(u8, 100);
    ```

    > Then you can use it just like the example below with full flexibility.

    ```zig
    // Append a slice.
    try chars.appendSlice(u8, &array, "ello 👨‍🏭!", 0);  // 👉 "ello 👨‍🏭!"
    ```

    ```zig
    // Append a character.
    try chars.appendChar(u8, &array, 'H', 17);          // 👉 "Hello 👨‍🏭!"
    ```

    ```zig
    // Get the length of the array.
    _ = chars.countWritten(u8, &array);                 // 👉 18
    ```

    ```zig
    // Get the visual length of the array.
    _ = chars.countVisual(u8, &array);                  // 👉 8
    ```

    ```zig
    // Find the position of a substring.
    _ = chars.find(u8, array, "👨‍🏭");                  // 👉 6
    ```

    ```zig
    // Check if the array includes a specific substring.
    _ = chars.includes(u8, array, "👨‍🏭");             // 👉 true
    ```

    ```zig
    // and much more . . !
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

    - #### ✨ Initialization

        | Function                    | Description                                                                               |
        | --------------------------- | ----------------------------------------------------------------------------------------- |
        | initWithCapacity            | Initializes an array of chars of a given `size`, filled with null chars.                  |
        | initWithSlice               | Initializes an array of chars of a given `size` and `value`, terminated with a null char. |
        | initWithSliceAssumeCapacity | Initializes an array of chars of a given `size` and `value`.                              |

    - #### ➕ Insert

        | Function          | Description                                                                     |
        | ----------------- | ------------------------------------------------------------------------------- |
        | insertSlice       | Inserts a `slice` into `dest` at the specified `position` by **real position**. |
        | insertChar        | Inserts a `char` into `dest` at the specified `position` by **real position**.  |
        | visualInsertSlice | Inserts a `slice` into `dest` at the specified `visual position`.               |
        | visualInsertChar  | Inserts a `char` into `dest` at the specified `visual position`.                |
        | appendSlice       | Appends a `slice` into `dest`.                                                  |
        | appendChar        | Appends a `char` into `dest`.                                                   |
        | prependSlice      | Prepends a `slice` into `dest`.                                                 |
        | prependChar       | Prepends a `char` into `dest`.                                                  |

    - #### ❌ Remove

        | Function          | Description                                                                            |
        | ----------------- | -------------------------------------------------------------------------------------- |
        | removeIndex       | Removes a char from the `dest`.                                                        |
        | removeVisualIndex | Removes a char from the `dest` by the `visual position`.                               |
        | removeRange       | Removes a `range` of chars from the `dest`.                                            |
        | removeVisualRange | Removes a `range` of chars from the `dest` by the `visual position`.                   |
        | pop               | Returns the length of the last grapheme cluster at the `dest`.                         |
        | shift             | Removes the first grapheme cluster at the `dest`, returns the number of removed chars. |

    - #### 🔍 Find

        | Function       | Description                                                          |
        | -------------- | -------------------------------------------------------------------- |
        | find           | Finds the `position` of the **first** occurrence of `target`.        |
        | findVisual     | Finds the `visual position` of the **first** occurrence of `target`. |
        | findLast       | Finds the `position` of the **last** occurrence of `target`.         |
        | findLastVisual | Finds the `visual position` of the **last** occurrence of `target`.  |
        | includes       | Returns `true` **if `dest` contains `target`**.                      |
        | startsWith     | Returns `true` **if `dest` starts with `target`**.                   |
        | endsWith       | Returns `true` **if `dest` ends with `target`**.                     |

    - #### 🔠 Case

        | Function       | Description                                                                   |
        | -------------- | ----------------------------------------------------------------------------- |
        | toLower        | Converts all (ASCII) letters to lowercase.                                    |
        | toUpper        | Converts all (ASCII) letters to uppercase.                                    |
        | toTitle        | Converts all (ASCII) letters to titlecase.                                    |
        | reverse        | Reverses the order of the chars.                                              |
        | reverseUnicode | Reverses the order of the chars in the `Self` instance (considering Unicode). |

    - #### ✅ Check

        | Function | Description                                                |
        | -------- | ---------------------------------------------------------- |
        | isChar   | Returns `true` **if the value is a valid char**.           |
        | isSlice  | Returns `true` **if the value is a valid array of chars**. |

    - #### 📏 Count

        | Function     | Description                                                                 |
        | ------------ | --------------------------------------------------------------------------- |
        | countWritten | Returns the total number of written chars, stopping at the first null char. |
        | countVisual  | Returns the total number of visual chars.                                   |
        | writtenSlice | Returns a slice containing only the written part.                           |

    - #### 🔄 Split

        | Function | Description                                                                              |
        | -------- | ---------------------------------------------------------------------------------------- |
        | split    | Splits the written portion of the string into substrings separated by the delimiter.     |
        | splitAll | Splits the written portion of the string into all substrings separated by the delimiter. |

    - #### 🔄 Replace

        | Function           | Description                                          |
        | ------------------ | ---------------------------------------------------- |
        | replaceAllChars    | Replaces all occurrence of a character with another. |
        | replaceAllSlices   | Replaces all occurrences of a slice with another.    |
        | replaceRange       | Replaces a range of chars with another.              |
        | replaceVisualRange | Replaces a visual range of chars with another.       |

    - #### 🔄 Utils

        | Function         | Description                                                                   |
        | ---------------- | ----------------------------------------------------------------------------- |
        | equals           | Returns true if the `a` is equal to `b`.                                      |
        | isEmpty          | Returns true if the `value` is empty.                                         |
        | print            | Prints the contents of the `slice` to the standard writer.                    |
        | printTo          | Prints the contents of the `slice` to the given writer.                       |
        | printWithNewline | Prints the contents of the `slice` to the standard writer and adds a newline. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Unicode](./unicode)
        > Utility functions for Unicode codepoints and grapheme clusters.

    - [Viewer](./viewer)
        > Immutable fixed-size string type that supports unicode.

    - [String](./string)
        > Managed dynamic-size string type that supports unicode.

    - [Buffer](./buffer)
        > Mutable fixed-size string type that supports unicode.

    - [uString](./ustring)
        > Unmanaged dynamic-size string type that supports unicode.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>
````
