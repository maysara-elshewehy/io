<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Buffer/logo.png" alt="Buffer" width="1000" />
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
    <b> Mutable fixed-size string type that supports unicode. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://github.com/Super-ZIG/io/string/">SuperZIG/io/string</a> module.</sup>
    </i></b>
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    var Buffer = @import("io").Buffer;
    ```

    > Now let's create our container, but before that we need to define the data type used to store the values, for example:
    >
    > If you are going to deal with (`utf8`, `utf16`, ..) encoding, you can use (`u8`, `u16`, ..) as the data type.

    ```zig
    const buff = try Buffer(u8, 100).init(true);
    ```

    > Then you can use it just like the example below with full flexibility.

    ```zig
    // Append any value from any type.
    try buff.append('!');       // 👉 "true!="
    try buff.append('=');       // 👉 "true!="
    try buff.append(false);     // 👉 "true!=false"
    try buff.append("👨‍🏭");      // 👉 "true!=false👨‍🏭"
    ```

    ```zig
    // Fast printing
    buff.print();               // 👉 "true!=false👨‍🏭\n"
    ```

    ```zig
    // Detect the correct data.
    _ = buff.len();             // 👉 22 (👨‍🏭 = 11 bytes)
    _ = buff.vlen();            // 👉 12 (👨‍🏭 = 1 character)
    ```

    ```zig
    // Correct unicode (codePoint/graphemeCluster) handling.
    _ = buff.pop();             // 👉 "👨‍🏭" removed.
    ```

    ```zig
    // and much more . . !
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

- #### 🧩 Fields

    | Field     | Type                | Description                           |
    | --------- | ------------------- | ------------------------------------- |
    | `m_src`   | `[100]u8`           | The mutable unicode encoded chars.    |
    | `m_len`   | `usize`             | The number of written chars.          |

 - #### ✨ Initialization

    | Function          | Description                                                                              |
    | ----------------- | ---------------------------------------------------------------------------------------- |
    | init              | Initializes a `Buffer` instance with anytype.                                            |
    | initEmpty         | Initializes a new empty `Buffer` instance.                                               |
    | initWithChar      | Initializes a new `Buffer` instance with the specified initial `char`.                   |
    | initWithSlice     | Initializes a new `Buffer` instance with the specified initial `chars`.                  |
    | initWithSelf      | Initializes a new `Buffer` instance with the specified initial `Buffer`.                 |
    | initWithFmt       | Initializes a `Buffer` instance with a formatted string.                                 |

- #### ➕ Insert

    | Function          | Description                                                                                |
    | ----------------- | ------------------------------------------------------------------------------------------ |
    | insert            | Inserts anyvalue from anytype into the `Buffer` instance at the specified position.        |
    | insertChar        | Inserts a char into the `Buffer` instance at the specified position.                       |
    | insertSlice       | Inserts a slice into the `Buffer` instance at the specified position.                      |
    | insertSelf        | Inserts a `Buffer` into the `Buffer` instance at the specified position.                   |
    | insertFmt         | Inserts a formatted string into the `Buffer` instance at the specified position.           |
    | visualInsert      | Inserts anyvalue from anytype into the `Buffer` instance at the specified visual position. |
    | visualInsertChar  | Inserts a char into the `Buffer` instance at the specified visual position.                |
    | visualInsertSlice | Inserts a slice into the `Buffer` instance at the specified visual position.               |
    | visualInsertSelf  | Inserts a `Buffer` into the `Buffer` instance at the specified visual position.            |
    | visualInsertFmt   | Inserts a formatted string into the `Buffer` instance at the specified visual position.    |
    | append            | Appends anyvalue from anytype to the `Buffer` instance.                                    |
    | appendChar        | Appends a char to the `Buffer` instance.                                                   |
    | appendSlice       | Appends a slice to the `Buffer` instance.                                                  |
    | appendSelf        | Appends a `Buffer` to the `Buffer` instance.                                               |
    | appendFmt         | Appends a formatted string to the `Buffer` instance.                                       |
    | prepend           | Prepends anyvalue from anytype to the `Buffer` instance.                                   |
    | prependChar       | Prepends a char to the `Buffer` instance.                                                  |
    | prependSlice      | Prepends a slice to the `Buffer` instance.                                                 |
    | prependSelf       | Prepends a `Buffer` to the `Buffer` instance.                                              |
    | prependFmt        | Prepends a formatted string to the `Buffer` instance.                                      |

- #### 📏 Data

    | Function | Description                                           |
    | -------- | ----------------------------------------------------- |
    | size     | Returns the number of chars that can be written.      |
    | len      | Returns the total number of written chars.            |
    | vlen     | Returns the total number of visual characters.        |
    | src      | Returns a slice containing only the written part.     |
    | sub      | Returns a sub-slice of the `Buffer`.                  |
    | charAt   | Returns a character at the specified index.           |
    | atVisual | Returns a character at the specified visual position. |
    | iterator | Creates an iterator for traversing the Unicode chars. |
    | writer   | Initializes a Writer which will append to the list.   |

- #### ❌ Remove

    | Function          | Description                                                                           |
    | ----------------- | ------------------------------------------------------------------------------------- |
    | removeIndex       | Removes a char from the `Buffer` instance at the specified position.                  |
    | removeVisualIndex | Removes a char from the `Buffer` instance by the specified visual position.           |
    | removeRange       | Removes a range of chars from the `Buffer` instance.                                  |
    | removeVisualRange | Removes a range of chars from the `Buffer` instance by the specified visual position. |
    | pop               | Removes the last grapheme cluster from the `Buffer` instance.                         |
    | shift             | Removes the first grapheme cluster from the `Buffer` instance.                        |
    | trim              | Trims whitespace from both ends of the `Buffer` instance.                             |
    | trimStart         | Trims whitespace from the start of the `Buffer` instance.                             |
    | trimEnd           | Trims whitespace from the end of the `Buffer` instance.                               |

- #### 🔄 Replace

    | Function           | Description                                                                           |
    | ------------------ | ------------------------------------------------------------------------------------- |
    | replaceRange       | Replaces a range of chars with another slice in the `Buffer`.                         |
    | replaceVisualRange | Replaces a visual range of chars with another slice in the `Buffer`.                  |
    | replaceFirst       | Replaces the first occurrence of a slice with another slice in the `Buffer`.          |
    | replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `Buffer`. |
    | replaceLast        | Replaces the last occurrence of a slice with another slice in the `Buffer`.           |
    | replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `Buffer`.  |
    | replaceAll         | Replaces all occurrences of a slice with another slice in the `Buffer`.               |
    | replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `Buffer`.          |

- #### 🔍 Find

    | Function       | Description                                                            |
    | -------------- | ---------------------------------------------------------------------- |
    | find           | Finds the position of the first occurrence of the target slice.        |
    | findVisual     | Finds the visual position of the first occurrence of the target slice. |
    | findLast       | Finds the position of the last occurrence of the target slice.         |
    | findLastVisual | Finds the visual position of the last occurrence of the target slice.  |
    | includes       | Returns `true` if the `Buffer` instance contains the target slice.     |
    | startsWith     | Returns `true` if the `Buffer` instance starts with the target slice.  |
    | endsWith       | Returns `true` if the `Buffer` instance ends with the target slice.    |

- #### 🔠 Case

    | Function | Description                                                          |
    | -------- | -------------------------------------------------------------------- |
    | toLower  | Converts all (ASCII) letters in the `Buffer` instance to lowercase.  |
    | toUpper  | Converts all (ASCII) letters in the `Buffer` instance to uppercase.  |
    | toTitle  | Converts all (ASCII) letters in the `Buffer` instance to title case. |

- #### ✅ Check

    | Function | Description                                                            |
    | -------- | ---------------------------------------------------------------------- |
    | isEqual  | Returns `true` if the `Buffer` instance equals the given target slice. |
    | isEmpty  | Returns `true` if the `Buffer` instance is empty.                      |

- #### 🔄 Split

    | Function       | Description                                                                                                                                                  |
    | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | split          | Splits the written portion into substrings separated by the specified delimiters.                                                                            |
    | splitAll       | Splits the written portion into all substrings separated by the specified delimiters.                                                                        |
    | splitToSelf    | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `Buffer` instance. |
    | splitAllToSelf | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `Buffer` instances.                          |

- #### 🔄 Repeat

    | Function | Description                                                           |
    | -------- | --------------------------------------------------------------------- |
    | repeat   | Repeats a char `count` times and appends it to the `Buffer` instance. |

- #### 🔄 Utils

    | Function | Description                                                                          |
    | -------- | ------------------------------------------------------------------------------------ |
    | clone    | Returns a deep copy of the `Buffer` instance.                                        |
    | clear    | Clears the contents of the `Buffer`.                                                 |
    | reverse  | Reverses the order of the characters in the `Buffer` instance (considering Unicode). |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Unicode](./unicode.md)
        > Utility functions for Unicode codepoints and grapheme clusters.

    - [Chars](./chars.md)
        > Utility functions for char arrays.

    - [Viewer](./viewer.md)
        > Immutable fixed-size string type that supports unicode.

    - [String](./string.md)
        > Managed dynamic-size string type that supports unicode.

    - [uString](./uString.md)
        > Unmanaged dynamic-size string type that supports unicode.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>