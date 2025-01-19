<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/logo/Bytes/logo.png" alt="Bytes" width="1000" />
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
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### Usage

    ```zig
    const Bytes = @import("io").utils.bytes;
    ```

    > **..?**

    ```zig
    ..?  // 👉 ..?
    ```


<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

   - #### ✨ Initialization

        | Function                                | Description                                                  |
        | --------------------------------------- | ------------------------------------------------------------ |
        | [`init`](./api/init.md)                 | Initializes an array of bytes of a given `size` and `value`. |
        | [`initCapacity`](./api/initCapacity.md) | Initializes an array of bytes of a given `size`.             |

   - #### 🔍 Search

        | Method                                | Description                                                           |
        | ------------------------------------- | --------------------------------------------------------------------- |
        | [`find`](./api/find.md)               | Finds the **real position** of the **first** occurrence of `value`.   |
        | [`findVisual`](./api/findVisual.md)   | Finds the **visual position** of the **first** occurrence of `value`. |
        | [`rfind`](./api/rfind.md)             | Finds the **real position** of the **last** occurrence of `value`.    |
        | [`rfindVisual`](./api/rfindVisual.md) | Finds the **visual position** of the **last** occurrence of `value`.  |
        | [`includes`](./api/includes.md)       | Returns `true` **if `dest` contains `target`**.                       |
        | [`startsWith`](./api/startsWith.md)   | Returns `true` **if `dest` starts with `target`**.                    |
        | [`endsWith`](./api/endsWith.md)       | Returns `true` **if `dest` ends with `target`**.                      |

   - #### 🌈 Letter Cases

        | Method                        | Description                                |
        | ----------------------------- | ------------------------------------------ |
        | [`toLower`](./api/toLower.md) | Converts all (ASCII) letters to lowercase. |
        | [`toUpper`](./api/toUpper.md) | Converts all (ASCII) letters to uppercase. |
        | [`toTitle`](./api/toTitle.md) | Converts all (ASCII) letters to titlecase. |

   - #### 🪄 Counting

        | Function                                | Description                                    |
        | --------------------------------------- | ---------------------------------------------- |
        | [`countWritten`](./api/countWritten.md) | Returns the total number of written bytes.     |
        | [`countVisual`](./api/countVisual.md)   | Returns the total number of visual characters. |

   - #### ✔️ Validation 

        | Function                      | Description                                                |
        | ----------------------------- | ---------------------------------------------------------- |
        | [`isByte`](./api/isByte.md)   | Returns `true` **if the value is a valid byte**.           |
        | [`isBytes`](./api/isbytes.md) | Returns `true` **if the value is a valid array of bytes**. |

   - #### 🌟 More

        | Function                                | Description                                       |
        | --------------------------------------- | ------------------------------------------------- |
        | [`writtenSlice`](./api/writtenSlice.md) | Returns a slice containing only the written part. |
        | [`toBytes`](./api/tobytes.md)           | Converts the given value to an array of bytes.    |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.utils.utf8](../utf8/utf8.md)
    > A set of useful functions for working with utf-8.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>