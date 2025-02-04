<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Unicode/logo.png" alt="Unicode" width="1000" />
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

<p align="center"> <b>Simplified and perfected.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div><br>


- ### API

   - #### ✨ Structures

        | Structure                         | Description                                                                         |
        | --------------------------------- | ----------------------------------------------------------------------------------- |
        | [`Iterator`](./api/Iterator.md)   | A _(`grapheme cluster`, `codepoint`)_ iterator for iterating over a slice of Bytes. |
        | [`Codepoint`](./api/Codepoint.md) | A struct to represent a single Unicode codepoint with properties.                   |

   - #### 🧩 Utilities

        | Function                                          | Description                                                          |
        | ------------------------------------------------- | -------------------------------------------------------------------- |
        | [`getRealPosition`](./api/getRealPosition.md)     | Returns the real position in the array based on the visual position. |
        | [`getVisualPosition`](./api/getVisualPosition.md) | Returns the visual position in the array based on the real position. |
        | [`lengthOfStartByte`](./api/lengthOfStartByte.md) | Returns length of the codepoint depending on the first byte.         |

   - #### 🌟 More

        > TODO: complete this documentation.

        | Function                                | Description                                    |
        | --------------------------------------- | ---------------------------------------------- |
        | [`lastCp`](./api/lastCp.md)             | Returns the last codepoint.                    |
        | [`lastCpSlice`](./api/lastCpSlice.md)   | Returns a slice of the last codepoint.         |
        | [`firstGcSlice`](./api/firstGcSlice.md) | Returns a slice of the first grapheme cluster. |
        | [`lastGcSlice`](./api/lastGcSlice.md)   | Returns a slice of the last grapheme cluster.  |

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.utils.Bytes](../Bytes/Bytes.md)
    > A set of useful functions for working with Bytes.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>