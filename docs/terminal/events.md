<p align="center">
  <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/Events/logo.png" alt="Events" width="1000" />
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
    <b> Robust event handling for terminal key presses and mouse events. </b>
</p>
<div align="center">
    <b><i>
        <sup> Part of the <a href="https://super-zig.github.io/io/terminal">SuperZIG/io/terminal</a> module. </sup>
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
      > *Supports Linux, Windows, and macOS*, ensuring seamless integration regardless of your environment.

    - ⚡ **Raw Mode Input**
      > Captures key presses directly from the terminal without interference, making it ideal for real-time applications.

    - 🔄 **Continuous Listening**
      > Supports both single and continuous key press listening with customizable conditions.

    - 🔎 **Extensive Key Detection**

      - **ASCII & Unicode Support:**
        >   Handles standard ASCII characters as well as Unicode (e.g., Arabic, English, and many other languages).

      - **Modifier Keys:**
        >   Accurately detects and combines modifiers like **Ctrl**, **Alt**, and **Shift** with other keys.

      - **Special Keys:**
        >   Supports detection of arrow keys, function keys (F1–F12), Home, End, Insert, Delete, PageUp, PageDown, and more.

      - **Simultaneous Key Presses:**
        >   Capable of detecting multiple keys pressed at the same time (e.g., Ctrl+Alt+Up, Ctrl+Shift+Alt+Down).

    - 🛠 **Easy-to-use API**
      > Provides a straightforward API with functions such as `listenUntil` and `listenUntilWith` for flexible event handling.

    - 🛡 **Rock-Solid Stability**
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

    > First, install the library as described in the [installation guide](https://github.com/Super-ZIG/io/wiki/installation).

    ```zig
    const events = @import("io").terminal.events;
    ```

    > The `events` module provides robust event handling for terminal key presses with support for Unicode and simultaneous key combinations. For example, to listen for user input and exit when the user presses `Alt + Q`, you can do:

    ```zig
    pub fn cond(event: events.Event) bool {
        if(event.key.isAlt() and (event.key.m_key[0] == 'Q' or event.key.m_key[0] == 'q')) {
            std.debug.print("Bye\n", .{});
            return true;
        }
        event.key.printWithNewline() catch {};
        return false;
    }

    pub fn main() !void {
        try events.listenUntil(cond);
    }
    ```

    > For instance, when the user presses the following keys in order:

    1. `Up`
    2. `Ctrl + Up`
    3. `Alt + Up`
    4. `Shift + Up`
    5. `Ctrl + Alt + Up`
    6. `Ctrl + Shift + Alt + Up`
    7. `Ctrl + Q`

    > The expected output will be:

    ```bash
    Up
    Ctrl + Up
    Alt + Up
    Shift + Up
    Ctrl + Alt + Up
    Ctrl + Shift + Alt + Up
    Bye
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

  - #### ✨ Methods

      | Function          | Description                                                    |
      | ----------------- | -------------------------------------------------------------- |
      | `listenUntil`     | Continuously listens for key presses until a condition is met. |
      | `listenUntilWith` | Similar to `listenUntil` but accepts additional arguments.     |

  - #### 🍃 Types

    - #### Key

      - #### Fields

        | Field    | Type         | Description                                                                                           |
        | -------- | ------------ | ----------------------------------------------------------------------------------------------------- |
        | `m_read` | `[]const u8` | Reference to the raw key buffer as received from the terminal.                                        |
        | `m_key`  | `[32]u8`     | A copy of the key (in UTF-8) extracted during parsing, ensuring stable display regardless of memory changes. |
        | `m_mask` | `u32`        | Bitmask representing modifiers and special key types (e.g., Ctrl, Alt, Shift, arrow keys, function keys, etc.). |

      - #### Methods

        - **Print / Format**
            | Function               | Description                                                          |
            | ---------------------- | -------------------------------------------------------------------- |
            | `printTo`              | Prints the key to a provided writer.                                 |
            | `print`                | Prints the key to the standard output.                               |
            | `printWithNewline`     | Prints the key to standard output with a newline appended.           |

        - **Check Functions**
            | Function             | Description                                               |
            | -------------------- | --------------------------------------------------------- |
            | `isAlphabetic`       | Checks if the key is an alphabetic character.             |
            | `isNumeric`          | Checks if the key is numeric.                             |
            | `isShift`            | Returns true if the Shift modifier is active.             |
            | `isAlt`              | Returns true if the Alt modifier is active.               |
            | `isAltShift`         | Returns true if both Alt and Shift modifiers are active.  |
            | `isAltCtrl`          | Returns true if both Alt and Ctrl modifiers are active.   |
            | `isCtrl`             | Returns true if the Ctrl modifier is active.              |
            | `isCtrlShift`        | Returns true if both Ctrl and Shift modifiers are active. |
            | `isCtrlAltShift`     | Returns true if Ctrl, Alt, and Shift modifiers are active.|
            | `isModifier`         | Returns true if any modifier (Ctrl, Alt, Shift) is active.  |
            | `isArrow`            | Checks if an arrow key is pressed.                        |
            | `isUp`               | Checks if the Up arrow key is pressed.                    |
            | `isDown`             | Checks if the Down arrow key is pressed.                  |
            | `isLeft`             | Checks if the Left arrow key is pressed.                  |
            | `isRight`            | Checks if the Right arrow key is pressed.                 |
            | `isFunction`         | Checks if any function key (F1-F12) is pressed.           |
            | `isF1` – `isF12`     | Checks for specific function keys (F1 through F12).       |
            | `isSpecial`          | Checks if the key is one of the special keys (Enter, Escape, Tab, Backspace, etc.). |
            | `isHome`             | Checks if the Home key is pressed.                        |
            | `isEnd`              | Checks if the End key is pressed.                         |
            | `isPageUp`           | Checks if the Page Up key is pressed.                     |
            | `isPageDown`         | Checks if the Page Down key is pressed.                   |
            | `isInsert`           | Checks if the Insert key is pressed.                      |
            | `isDelete`           | Checks if the Delete key is pressed.                      |

    - #### Mouse
      > (Mouse functionality is planned for future development.)

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Info](./info)
      > Detailed terminal information ensuring cross-platform compatibility.

    - [settings](./settings)
      > Comprehensive terminal settings for cross-platform operation.

    - [ansi](./ansi)
      > Utility functions for ANSI escape code manipulation and terminal styling.

    - [cli](./cli)
      > Seamless command-line integration with ZIG.

    - [Prompt](prompt)
      > Interactive prompts for user input.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy">
    <img src="https://img.shields.io/badge/Made%20with%20❤️%20by-Maysara-orange"/>
</a>
</div>
