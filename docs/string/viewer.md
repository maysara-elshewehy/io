<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Viewer/logo.png" alt="Viewer" width="1000" />
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
    <b> Immutable fixed-size string type that supports unicode. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://github.com/Super-ZIG/io">SuperZIG/io</a> library.</sup>
    </i></b>
</div>


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const Viewer = @import("io").Viewer;
    ```

    > Now let's create our container, but before that we need to define the data type used to store the values, for example:
    >
    > If you are going to deal with (`utf8`, `utf16`, ..) encoding, you can use (`u8`, `u16`, ..) as the data type.

    ```zig
    const view = try Viewer(u8).init("Hello 👨‍🏭!");
    ```

    > Then you can use it just like the example below with full flexibility.

    ```zig
    // Get the length of the viewer.
    _ = view.len();             // 👉 18
    ```

    ```zig
    // Get the visual length of the viewer.
    _ = view.vlen();            // 👉 8
    ```

    ```zig
    // Get a byte at a specific index.
    _ = view.charAt(0);         // 👉 'H'
    ```

    ```zig
    // Get a character at a specific visual position.
    _ = view.atVisual(6);       // 👉 "👨‍🏭"
    ```

    ```zig
    // Find the position of a substring.
    _ = view.find("👨‍🏭");        // 👉 6
    ```

    ```zig
    // Check if the viewer includes a specific substring.
    _ = view.includes("👨‍🏭");    // 👉 true
    ```

    ```zig
    // and much more . . !
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

- #### 🧩 Fields

    | Field   | Type         | Description                          |
    | ------- | ------------ | ------------------------------------ |
    | `m_src` | `[]const u8` | The immutable unicode encoded chars. |
    | `m_len` | `usize`      | The number of written chars.         |

 - #### ✨ Initialization

    | Function      | Description                                                              |
    | ------------- | ------------------------------------------------------------------------ |
    | init          | Initializes a `Viewer` instance with anytype.                            |
    | initEmpty     | Initializes a new empty `Viewer` instance.                               |
    | initWithChar  | Initializes a new `Viewer` instance with the specified initial `char`.   |
    | initWithSlice | Initializes a new `Viewer` instance with the specified initial `chars`.  |
    | initWithSelf  | Initializes a new `Viewer` instance with the specified initial `Viewer`. |

- #### 📏 Data

    | Function | Description                                           |
    | -------- | ----------------------------------------------------- |
    | size     | Returns the number of chars that can be written.      |
    | len      | Returns the total number of written chars.            |
    | vlen     | Returns the total number of visual characters.        |
    | src      | Returns a slice containing only the written part.     |
    | sub      | Returns a sub-slice of the `Viewer`.                  |
    | charAt   | Returns a character at the specified index.           |
    | atVisual | Returns a character at the specified visual position. |
    | iterator | Creates an iterator for traversing the Unicode chars. |

- #### 🔍 Find

    | Function       | Description                                                            |
    | -------------- | ---------------------------------------------------------------------- |
    | find           | Finds the position of the first occurrence of the target slice.        |
    | findVisual     | Finds the visual position of the first occurrence of the target slice. |
    | findLast       | Finds the position of the last occurrence of the target slice.         |
    | findLastVisual | Finds the visual position of the last occurrence of the target slice.  |
    | includes       | Returns `true` if the `Viewer` instance contains the target slice.     |
    | startsWith     | Returns `true` if the `Viewer` instance starts with the target slice.  |
    | endsWith       | Returns `true` if the `Viewer` instance ends with the target slice.    |

- #### ✅ Check

    | Function | Description                                                            |
    | -------- | ---------------------------------------------------------------------- |
    | isEqual  | Returns `true` if the `Viewer` instance equals the given target slice. |
    | isEmpty  | Returns `true` if the `Viewer` instance is empty.                      |

- #### 🔄 Split

    | Function       | Description                                                                                                                                                  |
    | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | split          | Splits the written portion into substrings separated by the specified delimiters.                                                                            |
    | splitAll       | Splits the written portion into all substrings separated by the specified delimiters.                                                                        |
    | splitToSelf    | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `Viewer` instance. |
    | splitAllToSelf | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `Viewer` instances.                          |

- #### 🔄 Utils

    | Function         | Description                                                                             |
    | ---------------- | --------------------------------------------------------------------------------------- |
    | clone            | Returns a deep copy of the `Viewer` instance.                                           |
    | clear            | Clears the contents of the `Viewer`.                                                    |
    | print            | Prints the contents of the `Viewer` instance to the standard writer.                    |
    | printTo          | Prints the contents of the `Viewer` instance to the given writer.                       |
    | printWithNewline | Prints the contents of the `Viewer` instance to the standard writer and adds a newline. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Unicode](./unicode)
        > Utility functions for Unicode codepoints and grapheme clusters.

    - [Chars](./chars)
        > Utility functions for char arrays.

    - [String](./string)
        > Managed dynamic-size string type that supports unicode.

    - [Buffer](./buffer)
        > Mutable fixed-size string type that supports unicode.

    - [uString](./ustring)
        > Unmanaged dynamic-size string type that supports unicode.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>