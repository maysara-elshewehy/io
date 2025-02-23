<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/Settings/logo.png" alt="Settings" width="1000" />
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
    <b> Comprehensive terminal settings for cross-platform compatibility. </b>
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

    - ⚡ **Full Control**
      > Easily **enable**/**disable** all the **flags** you want and **toggle** **RawMode** with just one instruction.

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
    const settings = @import("io").terminal.settings;
    ```

    > The `settings` module provides powerful tools for handling terminal settings. Let's explore some of its features.

    > For example, let's get the current terminal settings.

    ```zig
    var terminal_settings = try settings.get();
    ```

    > Now, you can access the settings.

    ```zig
    _ = terminal_settings.options.rawMode; // 👉 true/false

    // or

    _ = settings.isRawModeEnabled(); // 👉 true/false
    ```

    > Now, let's change the terminal settings and apply the changes.

    ```zig
    // change the terminal settings
    terminal_settings.options.rawMode = true;

    // apply the changes
    try settings.set(terminal_settings);
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

    - #### ✨ Methods

        | Function           | Description                          |
        | ------------------ | ------------------------------------ |
        | `get`              | Get current terminal settings.       |
        | `set`              | Set current terminal settings.       |
        | `enableRawMode`    | Enable raw mode.                     |
        | `disableRawMode`   | Disable raw mode.                    |
        | `isRawModeEnabled` | Returns true if raw mode is enabled. |

    - #### 🍃 Types

        - #### TerminalSettings

            | Field     | Type            | Description                                         |
            | --------- | --------------- | --------------------------------------------------- |
            | `core`    | struct          | to hold the os terminal settings.                   |
            | `handles` | struct          | to hold the os i/o handles.                         |
            | `options` | TerminalOptions | to hold the terminal settings options(flags/modes). |

        - #### TerminalOptions

            | Field       | Type | Description                                                                  | Supported OS |
            | ----------- | ---- | ---------------------------------------------------------------------------- | ------------ |
            | `rawMode`   | bool | true if the `raw mode` is enabled.                                           | All          |
            | `echo`      | bool | true if the `echo` is enabled.                                               | Linux        |
            | `canonical` | bool | true if the `canonical` input is enabled.                                    | Linux        |
            | `extended`  | bool | true if the `extended` input processing is enabled.                          | Linux        |
            | `signals`   | bool | true if the signals (`SIGINT`, `SIGTSTP`, `SIGTTIN`, `SIGTTOU`) are enabled. | Linux        |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Info](./info)

        > Detailed terminal information ensuring cross-platform compatibility.

    - [ansi](./ansi)

        > Utility functions for ANSI escape code manipulation and terminal styling.

    - [cli](./cli)

        > Seamless Command Line Integration with ZIG.

    - [Events](./events)

      > Robust event handling for terminal key presses and mouse events.

    - [Prompt](prompt)

        > Interactive prompts for user input.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>