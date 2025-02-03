<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/logo/Viewer/logo.png" alt="Viewer" width="1000" />
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

<p align="center"> <b>Immutable fixed-size string type that supports Unicode.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### API

  - #### 🧩 Fields

      | Field      | Type         | Description                             |
      | ---------- | ------------ | --------------------------------------- |
      | `m_source` | `[]const u8` | The unicode encoded bytes to be viewed. |

   - #### ✨ Initialization

        | Function                | Description                                                     |
        | ----------------------- | --------------------------------------------------------------- |
        | [`init`](./api/init.md) | Initializes a new Viewer instance with the given unicode bytes. |

   - #### 🔍 Search

        | Method                                | Description                                                          |
        | ------------------------------------- | -------------------------------------------------------------------- |
        | [`find`](./api/find.md)               | Finds the `position` of the **first** occurrence of `target`.        |
        | [`findVisual`](./api/findVisual.md)   | Finds the `visual position` of the **first** occurrence of `target`. |
        | [`rfind`](./api/rfind.md)             | Finds the `position` of the **last** occurrence of `target`.         |
        | [`rfindVisual`](./api/rfindVisual.md) | Finds the `visual position` of the **last** occurrence of `target`.  |
        | [`includes`](./api/includes.md)       | Returns `true` **if contains `target`**.                             |
        | [`startsWith`](./api/startsWith.md)   | Returns `true` **if starts with `target`**.                          |
        | [`endsWith`](./api/endsWith.md)       | Returns `true` **if ends with `target`**.                            |

   - #### 🪄 Data

        | Function                      | Description                                       |
        | ----------------------------- | ------------------------------------------------- |
        | [`length`](./api/length.md)   | Returns the total number of written Bytes.        |
        | [`vlength`](./api/vlength.md) | Returns the total number of visual characters.    |
        | [`slice`](./api/slice.md)     | Returns a slice containing only the written part. |

   - #### ➰ Iterations

        | Function                        | Description                                           |
        | ------------------------------- | ----------------------------------------------------- |
        | [`iterator`](./api/iterator.md) | Creates an iterator for traversing the unicode bytes. |

   - #### ✂️ Split

        | Function                        | Description                                                                    |
        | ------------------------------- | ------------------------------------------------------------------------------ |
        | [`split`](./api/split.md)       | Splits string into substrings by delimiter and returns substring at index.     |
        | [`splitAll`](./api/splitAll.md) | Splits string into substrings by delimiter and returns an array of substrings. |

   - #### 🌟 More

        | Function                      | Description                              |
        | ----------------------------- | ---------------------------------------- |
        | [`clone`](./api/clone.md)     | Returns a copy of the `Viewer` instance. |
        | [`equals`](./api/equals.md)   | Checks if two strings are equal.         |
        | [`isEmpty`](./api/isEmpty.md) | Checks if the string is empty.           |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.type.Buffer](../Buffer/Buffer.md)
    > Mutable fixed-size string type that supports Unicode.

  - #### [io.type.String](../String/String.md)
    > Managed dynamic-size string type that supports Unicode.

  - #### [io.type.uString](../uString/uString.md)
    > Unmanaged dynamic-size string type that supports Unicode.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>