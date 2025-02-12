<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Terminal/logo.png" alt="Terminal" width="1000" />
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
    <b> Terminal in ZIG done right. </b>
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

    - 🌍 **Cross Platform**
        > Tested on Windows, macOS and Linux.

    - 🛡️ **Rock-Solid Stability**
        > Every function is rigorously tested, making the library safe, reliable, and ready for production.

    - 🏗️ **Optimized for Scalability**
        > The library is designed to be as efficient as possible, with a focus on performance.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

    🔹 [🌍 Comparisons](#comparisons) – Detailed comparison with other libraries.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

    > This library provides several sections, each with its own approach to handling Terminal in the ZIG language.

    - #### 🎉 Events

        - #### 🛠 Event Methods
            > Event handling for terminal input.

            | Method      | Description                                                    |
            | ----------- | -------------------------------------------------------------- |
            | listen      | Listens for a single key press with modifires support.         |
            | listenUntil | Continuously listens for key presses until a condition is met. |

        - #### 📚 Event Types
            > Type definitions used in event operations.

            | Type  | Description                     |
            | ----- | ------------------------------- |
            | Key   | Represents a key press event.   |
            | Mouse | Represents a mouse press event. |

    - #### 🔧 Utils
        > Utility functions for terminal operations.

       - #### 🗑️ clear

          | Function               | Description                                         |
          | ---------------------- | --------------------------------------------------- |
          | clear.all              | Clears the entire terminal screen.                  |
          | clear.line             | Clears the current line in the terminal.            |
          | clear.screenFromCursor | Clears the screen from the cursor to the end.       |
          | clear.screenToCursor   | Clears the screen from the beginning to the cursor. |
          | clear.lineFromCursor   | Clears the line from the cursor to the end.         |
          | clear.lineToCursor     | Clears the line from the beginning to the cursor.   |

       - #### ↗️ cursor

          | Function       | Description                                                |
          | -------------- | ---------------------------------------------------------- |
          | cursor.goTo    | Moves the cursor to the specified position.                |
          | cursor.goUp    | Moves the cursor up by the specified number of rows.       |
          | cursor.goDown  | Moves the cursor down by the specified number of rows.     |
          | cursor.goLeft  | Moves the cursor left by the specified number of columns.  |
          | cursor.goRight | Moves the cursor right by the specified number of columns. |
          | cursor.hide    | Hides the cursor.                                          |
          | cursor.show    | Shows the cursor.                                          |
          | cursor.save    | Saves the current cursor position.                         |
          | cursor.restore | Restores the cursor to the saved position.                 |

       - #### 🎨 colors

          | Function        | Description                                 |
          | --------------- | ------------------------------------------- |
          | colors.fg256    | Sets the foreground color using 256 colors. |
          | colors.bg256    | Sets the background color using 256 colors. |
          | colors.fgRGB    | Sets the foreground color using RGB values. |
          | colors.bgRGB    | Sets the background color using RGB values. |
          | colors.resetAll | Resets all colors and styles.               |

       - #### ✨ attr

          | Function             | Description                         |
          | -------------------- | ----------------------------------- |
          | attr.reset           | Resets all attributes.              |
          | attr.bold            | Sets the bold attribute.            |
          | attr.noBold          | Unsets the bold attribute.          |
          | attr.dim             | Sets the dim attribute.             |
          | attr.noDim           | Unsets the dim attribute.           |
          | attr.italic          | Sets the italic attribute.          |
          | attr.noItalic        | Unsets the italic attribute.        |
          | attr.underline       | Sets the underline attribute.       |
          | attr.noUnderline     | Unsets the underline attribute.     |
          | attr.blinking        | Sets the blinking attribute.        |
          | attr.noBlinking      | Unsets the blinking attribute.      |
          | attr.reverse         | Sets the reverse attribute.         |
          | attr.noReverse       | Unsets the reverse attribute.       |
          | attr.hidden          | Sets the hidden attribute.          |
          | attr.noHidden        | Unsets the hidden attribute.        |
          | attr.strikethrough   | Sets the strikethrough attribute.   |
          | attr.noStrikethrough | Unsets the strikethrough attribute. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Comparisons

    > First, a special thanks to [Mibu](https://github.com/xyaman/mibu).
    It is an excellent library, and much of the utils section is inspired by it.
    >
    > However, **it has a limitation**: it only works with `POSIX` and specifically `termios`, which is not supported on `Windows`.
    >
    > This library was built not only to address this but also to offer many other features you'll discover while browsing the documentation.

    | Library       | Cross-platform |
    | ------------- | -------------- |
    | `io.terminal` | ✔              |
    | `mibu`        | ❌              |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>