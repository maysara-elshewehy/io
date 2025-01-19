<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/logo/uString/logo.png" alt="uString" width="1000" />
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

<p align="center"> <b>Unmanaged dynamic UTF-8 string done right.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### Usage

    ```zig
    const uString = @import("io").types.uString;
    ```

    > **..?**

    ```zig
    ..?  // 👉 ..?
    ```


<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

  - #### 🧩 Fields

      | Field      | Type    | Description                                          |
      | ---------- | ------- | ---------------------------------------------------- |
      | `source`   | `[]u8`  | The mutable UTF-8 encoded bytes.                     |
      | `length`   | `usize` | The number of written bytes to `source`.             |
      | `capacity` | `usize` | The number of bytes that can be written to `source`. |

   - #### ✨ Initialization

        | Function                                | Description                                                         |
        | --------------------------------------- | ------------------------------------------------------------------- |
        | [`init`](./api/init.md)                 | Initializes a new `uString` instance using `allocator` and `value`. |
        | [`initCapacity`](./api/initCapacity.md) | Initializes a new `uString` instance using `allocator` and `size`.  |
        | [`deinit`](./api/deinit.md)             | Release all allocated memory.                                       |

  - #### 🔍 Search

      | Method                                | Description                                                           |
      | ------------------------------------- | --------------------------------------------------------------------- |
      | [`find`](./api/find.md)               | Finds the **real position** of the **first** occurrence of `value`.   |
      | [`findVisual`](./api/findVisual.md)   | Finds the **visual position** of the **first** occurrence of `value`. |
      | [`rfind`](./api/rfind.md)             | Finds the **real position** of the **last** occurrence of `value`.    |
      | [`rfindVisual`](./api/rfindVisual.md) | Finds the **visual position** of the **last** occurrence of `value`.  |
      | [`includes`](./api/includes.md)       | Returns `true` **if contains `target`**.                              |
      | [`startsWith`](./api/startsWith.md)   | Returns `true` **if starts with `target`**.                           |
      | [`endsWith`](./api/endsWith.md)       | Returns `true` **if ends with `target`**.                             |

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

   - #### 🚀 Iterations

        | Function                        | Description                                         |
        | ------------------------------- | --------------------------------------------------- |
        | [`iterator`](./api/iterator.md) | Creates an iterator for traversing the UTF-8 bytes. |

   - #### 🌟 More

        | Function                                    | Description                                                           |
        | ------------------------------------------- | --------------------------------------------------------------------- |
        | [`allocatedSlice`](./api/allocatedSlice.md) | Returns a slice representing the entire allocated memory range.       |
        | [`writtenSlice`](./api/writtenSlice.md)     | Returns a slice containing only the written part.                     |
        | [`toManaged`](./api/toManaged.md)           | Converts the `uString` to a `String`, taking ownership of the memory. |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.type.String](../String/String.md)
    > Managed dynamic UTF-8 type.

  - #### [io.type.Viewer](../Viewer/Viewer.md)
    > Immutable fixed UTF-8 type.

  - #### [io.type.Buffer](../Buffer/Buffer.md)
    > Mutable fixed UTF-8 type.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>