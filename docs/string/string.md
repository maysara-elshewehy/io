<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/String/logo.png" alt="String" width="1000" />
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
    <b> Managed dynamic-size string type that supports unicode. </b>
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

- ### 🚀 Features 🚀
  -  TODO

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const String = @import("io").String;
    ```

    > Now let's create our container, but before that we need to define the data type used to store the values, for example:
    >
    > If you are going to deal with (`utf8`, `utf16`, ..) encoding, you can use (`u8`, `u16`, ..) as the data type.

    ```zig
    var str = try String(u8).init(allocator, here_you_can_add_any_value_you_want)
    ```

    > Then you can use it just like the example below with full flexibility.

    ```zig
    // Initialize with any value from any type.
    var str = try String(u8).init(allocator, true);
    defer str.deinit();
    ```

    ```zig
    // Append any value from any type.
    try str.append('!');        // 👉 "true!="
    try str.append('=');        // 👉 "true!="
    try str.append(false);      // 👉 "true!=false"
    try str.append("👨‍🏭");       // 👉 "true!=false👨‍🏭"
    ```

    ```zig
    // Fast printing
    str.print();                // 👉 "true!=false👨‍🏭\n"
    ```

    ```zig
    // Detect the correct data.
    _ = str.len();              // 👉 22 (👨‍🏭 = 11 bytes)
    _ = str.vlen();             // 👉 12 (👨‍🏭 = 1 character)
    ```

    ```zig
    // Correct unicode (codePoint/graphemeCluster) handling.
    _ = str.pop();              // 👉 "👨‍🏭" removed.
    ```

    ```zig
    // and much more . . !
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

- #### 🧩 Fields

    | Field     | Type                | Description                           |
    | --------- | ------------------- | ------------------------------------- |
    | `m_alloc` | `std.mem.Allocator` | Allocator used for memory management. |
    | `m_src`   | `[]u8`              | The mutable unicode encoded chars.    |
    | `m_len`   | `usize`             | The number of written chars.          |

    > Note, contrary to what some people think, I do not follow the `C` or `C++` approach in naming.
    >
    > the prefix `m_` is there to distinguish between members and other things simply, I chose the prefix 'm_' because it is the most common and readable and understandable.

 - #### ✨ Initialization

    | Function          | Description                                                                              |
    | ----------------- | ---------------------------------------------------------------------------------------- |
    | init              | Initializes a `String` instance with anytype.                                            |
    | initEmpty         | Initializes a new empty `String` instance.                                               |
    | initWithChar      | Initializes a new `String` instance with the specified initial `char`.                   |
    | initWithSlice     | Initializes a new `String` instance with the specified initial `chars`.                  |
    | initWithSelf      | Initializes a new `String` instance with the specified initial `String`.                 |
    | initWithFmt       | Initializes a `String` instance with a formatted string.                                 |
    | initWithAllocator | Initializes a new empty `String` instance with the specified allocator.                  |
    | initWithCapacity  | Initializes a new `String` instance with the specified allocator and initial `capacity`. |
    | deinit            | Releases all allocated memory associated with the `String` instance.                     |


 - #### ➕ Insert

    | Function          | Description                                                                                |
    | ----------------- | ------------------------------------------------------------------------------------------ |
    | insert            | Inserts anyvalue from anytype into the `String` instance at the specified position.        |
    | insertChar        | Inserts a char into the `String` instance at the specified position.                       |
    | insertSlice       | Inserts a slice into the `String` instance at the specified position.                      |
    | insertSelf        | Inserts a `String` into the `String` instance at the specified position.                   |
    | insertFmt         | Inserts a formatted string into the `String` instance at the specified position.           |
    | visualInsert      | Inserts anyvalue from anytype into the `String` instance at the specified visual position. |
    | visualInsertChar  | Inserts a char into the `String` instance at the specified visual position.                |
    | visualInsertSlice | Inserts a slice into the `String` instance at the specified visual position.               |
    | visualInsertSelf  | Inserts a `String` into the `String` instance at the specified visual position.            |
    | visualInsertFmt   | Inserts a formatted string into the `String` instance at the specified visual position.    |
    | append            | Appends anyvalue from anytype to the `String` instance.                                    |
    | appendChar        | Appends a char to the `String` instance.                                                   |
    | appendSlice       | Appends a slice to the `String` instance.                                                  |
    | appendSelf        | Appends a `String` to the `String` instance.                                               |
    | appendFmt         | Appends a formatted string to the `String` instance.                                       |
    | prepend           | Prepends anyvalue from anytype to the `String` instance.                                   |
    | prependChar       | Prepends a char to the `String` instance.                                                  |
    | prependSlice      | Prepends a slice to the `String` instance.                                                 |
    | prependSelf       | Prepends a `String` to the `String` instance.                                              |
    | prependFmt        | Prepends a formatted string to the `String` instance.                                      |

- #### 📏 Data

    | Function | Description                                                    |
    | -------- | -------------------------------------------------------------- |
    | size     | Returns the number of chars that can be written.               |
    | len      | Returns the total number of written chars.                     |
    | vlen     | Returns the total number of visual characters.                 |
    | src      | Returns a slice containing only the written part.              |
    | sub      | Returns a sub-slice of the `String`.                           |
    | cString  | Returns a [:0]const u8 slice containing only the written part. |
    | charAt   | Returns a character at the specified index.                    |
    | atVisual | Returns a character at the specified visual position.          |
    | iterator | Creates an iterator for traversing the Unicode chars.          |
    | writer   | Initializes a Writer which will append to the list.            |

- #### ❌ Remove

    | Function          | Description                                                                           |
    | ----------------- | ------------------------------------------------------------------------------------- |
    | removeIndex       | Removes a char from the `String` instance at the specified position.                  |
    | removeVisualIndex | Removes a char from the `String` instance by the specified visual position.           |
    | removeRange       | Removes a range of chars from the `String` instance.                                  |
    | removeVisualRange | Removes a range of chars from the `String` instance by the specified visual position. |
    | pop               | Removes the last grapheme cluster from the `String` instance.                         |
    | shift             | Removes the first grapheme cluster from the `String` instance.                        |
    | trim              | Trims whitespace from both ends of the `String` instance.                             |
    | trimStart         | Trims whitespace from the start of the `String` instance.                             |
    | trimEnd           | Trims whitespace from the end of the `String` instance.                               |

- #### 🔄 Replace

    | Function           | Description                                                                           |
    | ------------------ | ------------------------------------------------------------------------------------- |
    | replaceRange       | Replaces a range of chars with another slice in the `String`.                         |
    | replaceVisualRange | Replaces a visual range of chars with another slice in the `String`.                  |
    | replaceFirst       | Replaces the first occurrence of a slice with another slice in the `String`.          |
    | replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `String`. |
    | replaceLast        | Replaces the last occurrence of a slice with another slice in the `String`.           |
    | replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `String`.  |
    | replaceAll         | Replaces all occurrences of a slice with another slice in the `String`.               |
    | replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `String`.          |

- #### 🔍 Find

    | Function       | Description                                                            |
    | -------------- | ---------------------------------------------------------------------- |
    | find           | Finds the position of the first occurrence of the target slice.        |
    | findVisual     | Finds the visual position of the first occurrence of the target slice. |
    | findLast       | Finds the position of the last occurrence of the target slice.         |
    | findLastVisual | Finds the visual position of the last occurrence of the target slice.  |
    | includes       | Returns `true` if the `String` instance contains the target slice.     |
    | startsWith     | Returns `true` if the `String` instance starts with the target slice.  |
    | endsWith       | Returns `true` if the `String` instance ends with the target slice.    |

- #### 🔠 Case

    | Function | Description                                                          |
    | -------- | -------------------------------------------------------------------- |
    | toLower  | Converts all (ASCII) letters in the `String` instance to lowercase.  |
    | toUpper  | Converts all (ASCII) letters in the `String` instance to uppercase.  |
    | toTitle  | Converts all (ASCII) letters in the `String` instance to title case. |

- #### ✅ Check

    | Function | Description                                                            |
    | -------- | ---------------------------------------------------------------------- |
    | isEqual  | Returns `true` if the `String` instance equals the given target slice. |
    | isEmpty  | Returns `true` if the `String` instance is empty.                      |

- #### 🔄 Split

    | Function       | Description                                                                                                                                                  |
    | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | split          | Splits the written portion into substrings separated by the specified delimiters.                                                                            |
    | splitAll       | Splits the written portion into all substrings separated by the specified delimiters.                                                                        |
    | splitToSelf    | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `String` instance. |
    | splitAllToSelf | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `String` instances.                          |

- #### 🔄 Repeat

    | Function | Description                                                           |
    | -------- | --------------------------------------------------------------------- |
    | repeat   | Repeats a char `count` times and appends it to the `String` instance. |

- #### 🔧 Memory Management

    | Function       | Description                                                 |
    | -------------- | ----------------------------------------------------------- |
    | shrink         | Reduces length to `new_len`.                                |
    | shrinkAndFree  | Reduces allocated capacity to `new_len`.                    |
    | resize         | Adjusts the `String` instance length to `new_len`.          |
    | clear          | Clears the contents of the `String`.                        |
    | clearAndFree   | Clears the contents of the `String` and frees its memory.   |
    | fromOwnedSlice | Initializes a new `String` from the given owned slice.      |
    | toOwnedSlice   | Transfers ownership of the `String`'s memory to the caller. |

- #### 🔄 Conversion

    | Function    | Description                                        |
    | ----------- | -------------------------------------------------- |
    | toUnmanaged | Converts the `String` into an unmanaged `uString`. |
    | toViewer    | Converts the `String` instance to a `Viewer`.      |

- #### 🔄 Utils

    | Function         | Description                                                                             |
    | ---------------- | --------------------------------------------------------------------------------------- |
    | clone            | Returns a deep copy of the `String` instance.                                           |
    | reverse          | Reverses the order of the characters in the `String` instance (considering Unicode).    |
    | print            | Prints the contents of the `String` instance to the standard writer.                    |
    | printTo          | Prints the contents of the `String` instance to the given writer.                       |
    | printWithNewline | Prints the contents of the `String` instance to the standard writer and adds a newline. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Unicode](./unicode)
        > Utility functions for Unicode codepoints and grapheme clusters.

    - [Chars](./chars)
        > Utility functions for char arrays.

    - [Viewer](./viewer)
        > Immutable fixed-size string type that supports unicode.

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