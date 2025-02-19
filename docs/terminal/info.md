<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/Info/logo.png" alt="Info" width="1000" />
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
    <b> Detailed terminal information ensuring cross-platform compatibility. </b>
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
        > Support for Linux, Windows, and macOS.

    - 🛠 **Easy-to-use API**
        > An intuitive API designed for ease of use, allowing developers to seamlessly integrate terminal settings into their applications with minimal effort.

    - 📈 **Performance Optimized**
        > Efficient and fast, ensuring minimal impact on your system's resources.

    - 🔧 **Customizable**
        > Highly configurable settings to tailor the terminal behavior to your needs.

    - 🛡️ **Rock-Solid Stability**
        > Every function is rigorously tested, making the library safe, reliable, and ready for production.

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
    const info = @import("io").terminal.info;
    ```

    > The `info` module provides powerful tools for handling terminal info. Let's explore some of its features.

    ```zig
    _ = try info.get();         // current terminal info.
    _ = try info.getHeight();   // current terminal height.
    _ = try info.getWidth();    // current terminal width.
    _ = try info.getRows();     // current terminal rows.
    _ = try info.getCols();     // current terminal cols.
    _ = try info.getCursor();   // current terminal cursor.
    ...
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

    - #### ✨ Methods

        | Function            | Description                                                           |
        | ------------------- | --------------------------------------------------------------------- |
        | `get`               | Get current terminal info.                                            |
        | `getCursor`         | Get current cursor position.                                          |
        | `getHeight`         | Get current terminal height.                                          |
        | `getWidth`          | Get current terminal width.                                           |
        | `getRows`           | Get current terminal rows.                                            |
        | `getCols`           | Get current terminal cols.                                            |
        | `setCursor`         | Set the cursor position.                                              |
        | `setCursorAndClear` | Set the cursor position and clears everything after the new position. |

    - #### 🍃 Types

        - #### TerminalInfo

            | Field    | Type   | Description                            | Supported OS |
            | -------- | ------ | -------------------------------------- | ------------ |
            | `height` | u16    | The height of the terminal.            | All          |
            | `width`  | u16    | The width of the terminal.             | All          |
            | `rows`   | u16    | The number of rows in the terminal.    | All          |
            | `cols`   | u16    | The number of columns in the terminal. | All          |
            | `cursor` | Cursor | The current cursor position.           | All          |

        - #### Cursor

            | Field | Type | Description                              |
            | ----- | ---- | ---------------------------------------- |
            | `x`   | i16  | The x-coordinate of the cursor position. |
            | `y`   | i16  | The y-coordinate of the cursor position. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [settings](./settings)

        > Comprehensive terminal settings for cross-platform compatibility.

    - [ansi](./ansi)

        > Utility functions for ANSI escape code manipulation and terminal styling.

    - [cli](./cli)

        > Seamless Command Line Integration with ZIG.

    - [Prompt](prompt)

        > Interactive prompts for user input.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>