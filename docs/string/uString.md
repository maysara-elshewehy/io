<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/uString/logo.png" alt="uString" width="1000" />
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
    <b> Unmanaged dynamic-size string type that supports unicode. </b>
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
    const uString = @import("io").uString;
    ```

    > Now let's create our container, but before that we need to define the data type used to store the values, for example:
    >
    > If you are going to deal with (`utf8`, `utf16`, ..) encoding, you can use (`u8`, `u16`, ..) as the data type.

    ```zig
    var str = try uString(u8).init(allocator, here_you_can_add_any_value_you_want)
    ```

    > Then you can use it just like the example below with full flexibility.

    ```zig
    // Initialize with any value from any type.
    var str = try uString(u8).init(allocator, true);
    defer str.deinit(allocator);
    ```

    ```zig
    // Append any value from any type.
    try str.append('!');                // 👉 "true!="
    try str.append('=');                // 👉 "true!="
    try str.append(false);              // 👉 "true!=false"
    try str.append("👨‍🏭");               // 👉 "true!=false👨‍🏭"
    ```

    ```zig
    // Fast printing
    str.print();                        // 👉 "true!=false👨‍🏭\n"
    ```

    ```zig
    // Detect the correct data.
    const length = str.len();           // 👉 22 (👨‍🏭 = 11 bytes)
    const visualLength = str.vlen();    // 👉 12 (👨‍🏭 = 1 character)
    ```

    ```zig
    // Correct unicode (codePoint/graphemeCluster) handling.
    const removed = str.pop();          // 👉 "👨‍🏭" removed.
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
    | `m_src`   | `[]u8`              | The mutable unicode encoded chars.    |
    | `m_len`   | `usize`             | The number of written chars.          |

 - #### ✨ Initialization

    | Function          | Description                                                                              |
    | ----------------- | ---------------------------------------------------------------------------------------- |
    | init              | Initializes a `uString` instance with anytype.                                            |
    | initEmpty         | Initializes a new empty `uString` instance.                                               |
    | initWithChar      | Initializes a new `uString` instance with the specified initial `char`.                   |
    | initWithSlice     | Initializes a new `uString` instance with the specified initial `chars`.                  |
    | initWithSelf      | Initializes a new `uString` instance with the specified initial `uString`.                 |
    | initWithFmt       | Initializes a `uString` instance with a formatted string.                                 |
    | initWithAllocator | Initializes a new empty `uString` instance with the specified allocator.                  |
    | initWithCapacity  | Initializes a new `uString` instance with the specified allocator and initial `capacity`. |
    | deinit            | Releases all allocated memory associated with the `uString` instance.                     |


 - #### ➕ Insert

    | Function          | Description                                                                                |
    | ----------------- | ------------------------------------------------------------------------------------------ |
    | insert            | Inserts anyvalue from anytype into the `uString` instance at the specified position.        |
    | insertChar        | Inserts a char into the `uString` instance at the specified position.                       |
    | insertSlice       | Inserts a slice into the `uString` instance at the specified position.                      |
    | insertSelf        | Inserts a `uString` into the `uString` instance at the specified position.                   |
    | insertFmt         | Inserts a formatted string into the `uString` instance at the specified position.           |
    | visualInsert      | Inserts anyvalue from anytype into the `uString` instance at the specified visual position. |
    | visualInsertChar  | Inserts a char into the `uString` instance at the specified visual position.                |
    | visualInsertSlice | Inserts a slice into the `uString` instance at the specified visual position.               |
    | visualInsertSelf  | Inserts a `uString` into the `uString` instance at the specified visual position.            |
    | visualInsertFmt   | Inserts a formatted string into the `uString` instance at the specified visual position.    |
    | append            | Appends anyvalue from anytype to the `uString` instance.                                    |
    | appendChar        | Appends a char to the `uString` instance.                                                   |
    | appendSlice       | Appends a slice to the `uString` instance.                                                  |
    | appendSelf        | Appends a `uString` to the `uString` instance.                                               |
    | appendFmt         | Appends a formatted string to the `uString` instance.                                       |
    | prepend           | Prepends anyvalue from anytype to the `uString` instance.                                   |
    | prependChar       | Prepends a char to the `uString` instance.                                                  |
    | prependSlice      | Prepends a slice to the `uString` instance.                                                 |
    | prependSelf       | Prepends a `uString` to the `uString` instance.                                              |
    | prependFmt        | Prepends a formatted string to the `uString` instance.                                      |

- #### 📏 Data

    | Function | Description                                           |
    | -------- | ----------------------------------------------------- |
    | size     | Returns the number of chars that can be written.      |
    | len      | Returns the total number of written chars.            |
    | vlen     | Returns the total number of visual characters.        |
    | src      | Returns a slice containing only the written part.     |
    | sub      | Returns a sub-slice of the `uString`.                  |
    | charAt   | Returns a character at the specified index.           |
    | atVisual | Returns a character at the specified visual position. |
    | iterator | Creates an iterator for traversing the Unicode chars. |
    | writer   | Initializes a Writer which will append to the list.   |

- #### ❌ Remove

    | Function          | Description                                                                           |
    | ----------------- | ------------------------------------------------------------------------------------- |
    | removeIndex       | Removes a char from the `uString` instance at the specified position.                  |
    | removeVisualIndex | Removes a char from the `uString` instance by the specified visual position.           |
    | removeRange       | Removes a range of chars from the `uString` instance.                                  |
    | removeVisualRange | Removes a range of chars from the `uString` instance by the specified visual position. |
    | pop               | Removes the last grapheme cluster from the `uString` instance.                         |
    | shift             | Removes the first grapheme cluster from the `uString` instance.                        |
    | trim              | Trims whitespace from both ends of the `uString` instance.                             |
    | trimStart         | Trims whitespace from the start of the `uString` instance.                             |
    | trimEnd           | Trims whitespace from the end of the `uString` instance.                               |

- #### 🔄 Replace

    | Function           | Description                                                                           |
    | ------------------ | ------------------------------------------------------------------------------------- |
    | replaceRange       | Replaces a range of chars with another slice in the `uString`.                         |
    | replaceVisualRange | Replaces a visual range of chars with another slice in the `uString`.                  |
    | replaceFirst       | Replaces the first occurrence of a slice with another slice in the `uString`.          |
    | replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `uString`. |
    | replaceLast        | Replaces the last occurrence of a slice with another slice in the `uString`.           |
    | replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `uString`.  |
    | replaceAll         | Replaces all occurrences of a slice with another slice in the `uString`.               |
    | replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `uString`.          |

- #### 🔍 Find

    | Function       | Description                                                            |
    | -------------- | ---------------------------------------------------------------------- |
    | find           | Finds the position of the first occurrence of the target slice.        |
    | findVisual     | Finds the visual position of the first occurrence of the target slice. |
    | findLast       | Finds the position of the last occurrence of the target slice.         |
    | findLastVisual | Finds the visual position of the last occurrence of the target slice.  |
    | includes       | Returns `true` if the `uString` instance contains the target slice.     |
    | startsWith     | Returns `true` if the `uString` instance starts with the target slice.  |
    | endsWith       | Returns `true` if the `uString` instance ends with the target slice.    |

- #### 🔠 Case

    | Function | Description                                                          |
    | -------- | -------------------------------------------------------------------- |
    | toLower  | Converts all (ASCII) letters in the `uString` instance to lowercase.  |
    | toUpper  | Converts all (ASCII) letters in the `uString` instance to uppercase.  |
    | toTitle  | Converts all (ASCII) letters in the `uString` instance to title case. |

- #### ✅ Check

    | Function | Description                                                            |
    | -------- | ---------------------------------------------------------------------- |
    | isEqual  | Returns `true` if the `uString` instance equals the given target slice. |
    | isEmpty  | Returns `true` if the `uString` instance is empty.                      |

- #### 🔄 Split

    | Function       | Description                                                                                                                                                  |
    | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | split          | Splits the written portion into substrings separated by the specified delimiters.                                                                            |
    | splitAll       | Splits the written portion into all substrings separated by the specified delimiters.                                                                        |
    | splitToSelf    | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `uString` instance. |
    | splitAllToSelf | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `uString` instances.                          |

- #### 🔄 Repeat

    | Function | Description                                                           |
    | -------- | --------------------------------------------------------------------- |
    | repeat   | Repeats a char `count` times and appends it to the `uString` instance. |

- #### 🔧 Memory Management

    | Function       | Description                                                 |
    | -------------- | ----------------------------------------------------------- |
    | shrink         | Reduces length to `new_len`.                                |
    | shrinkAndFree  | Reduces allocated capacity to `new_len`.                    |
    | resize         | Adjusts the `uString` instance length to `new_len`.          |
    | clear          | Clears the contents of the `uString`.                        |
    | clearAndFree   | Clears the contents of the `uString` and frees its memory.   |
    | fromOwnedSlice | Initializes a new `uString` from the given owned slice.      |
    | toOwnedSlice   | Transfers ownership of the `uString`'s memory to the caller. |

- #### 🔄 Conversion

    | Function    | Description                                        |
    | ----------- | -------------------------------------------------- |
    | toManaged   | Converts the `uString` into a managed `String`.    |
    | toViewer    | Converts the `uString` instance to a `Viewer`.      |

- #### 🔄 Utils

    | Function | Description                                                                          |
    | -------- | ------------------------------------------------------------------------------------ |
    | clone    | Returns a deep copy of the `uString` instance.                                        |
    | reverse  | Reverses the order of the characters in the `uString` instance (considering Unicode). |

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

    - [Buffer](./buffer.md)
        > Mutable fixed-size string type that supports unicode.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>
