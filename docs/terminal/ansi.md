<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/ANSI/logo.png" alt="ANSI" width="1000" />
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
    <b> Utility functions for ANSI escape code manipulation and terminal styling. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://super-zig.github.io/io/terminal">SuperZIG/io/terminal</a> module.</sup>
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
    - 🌍 **Cross Platform**
        > Support for Linux and Windows.

    - 🛠 **Easy-to-use API**
        > Simple API for initializing and handling key events.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🎇 API Reference](#api-) – Detailed documentation of available functions.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const ansi = @import("io").terminal.ansi;
    ```

    > The `ansi` module provides powerful tools for styling the terminal. Let's explore some of its features.

    ```zig
    try ansi.colors.bg256(writer, .red);
    ```
    ```zig
    try ansi.colors.fgRGB(writer, 255, 255, 255);
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

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
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Prompt](prompt)

        > Interactive prompts for user input.

    - [cli](./cli)

        > Seamless Command Line Integration with ZIG.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>