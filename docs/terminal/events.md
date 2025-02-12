<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Events/logo.png" alt="Events" width="1000" />
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
    <b> Event handling for terminal input. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://super-zig.github.io/io/terminal">SuperZIG/io/terminal</a> module.</sup>
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
        > Support for Linux and Windows.

    - ⚡ **Raw Mode**
        > Capturing key presses directly from the terminal.

    - 🔄 **Continuous Listening**
        > Support for single and continuous key press listening.

    - 🛠 **Easy-to-use API**
        > Simple API for initializing and handling key events.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

    🔹 [🌍 Comparisons](#comparisons) – Detailed comparison with other libraries.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const events = @import("io").terminal.events;
    ```

    > The `events` module provides powerful events for handling terminal key presses. Let's explore some of its features.

    > For example, let's listen to the user input using a cross-platform raw mode.

    ```zig
    const key = try events.listen();

    try key.print();
    ```

    > Suppose the user pressed `ctrl` + `shift` + `A`
    **OUTPUT**

    ```bash
    ctrl + shift + A
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

| Index              |
| ------------------ |
| [Events](#-events) |
| [Types](#️-types)   |

- #### 🔹 Events

    | Function      | Description                                                    |
    | ------------- | -------------------------------------------------------------- |
    | `listen`      | Listens for a single key press event.                          |
    | `listenUntil` | Continuously listens for key presses until a condition is met. |


- #### 🔹 Types

  - #### 🔹 Key

    - ##### 🔹 Fields

        | Field     | Type    | Description                    |
        | --------- | ------- | ------------------------------ |
        | `m_val`   | `u8`    | The value of the key pressed.  |
        | `m_mod`   | `u3`    | The modifier keys pressed.     |
        | `m_state` | `State` | The state of the key press.    |
        | `m_arrow` | `Arrow` | The arrow key pressed, if any. |

    - ##### ✨ Initialization

      | Function | Description                                        |
      | -------- | -------------------------------------------------- |
      | `init`   | Initializes a new `Key` instance.                  |
      | `print`  | Prints a human-readable representation of the key. |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Comparisons

  - #### vs Mibu.

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

- ### 🔗 Related

    - [CLI](./cli)
        > Easy CLI in ZIG.

    - [ANSI](./ansi)
        > ANSI escape codes handling.

    - [Prompts](#)
        > Interactive prompts for user input.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>