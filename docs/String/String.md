# [←](../index.md) `io`.`String`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/logo/String/logo.png" alt="String" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <b>Dynamic UTF-8 string done right.</b><br />
</p>

<br />

<div align="center">
    <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

> The `String` module provides a robust and efficient dynamic string implementation tailored for `UTF-8` encoding.

> Designed to handle flexible string operations, allowing for resizing, cloning, and memory management with ease.
>
> Unlike fixed-size arrays, this dynamic string type can grow or shrink as needed, optimizing memory usage and ensuring high performance for applications that require frequent string manipulations.
>
> With built-in support for custom allocators and advanced functions for string analysis and manipulation, the `String` type is ideal for developers who need a reliable and efficient solution for handling text in the Zig programming language.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Usage

    > **Import `Buffer` module.**

    ```zig
    const String = @import("io").String;
    ```

    > **Initialize an empty string.**

    ```zig
    var str = String.init();
    // 🌟 Use `String.initAlloc` to use a specific allocator.
    defer str.deinit();

    _ = str.size(); // 👉 0
    _ = str.len();  // 👉 0
    ```

    > **Initialize a string with `value`.**

    ```zig
    var str = try String.initWith("Hello 🌍!");
    // 🌟 Use `String.initAllocWith` to use a specific allocator.
    defer str.deinit();

    _ = str.size(); // 👉 22 (11 * 2) (To reduce the number of allocations)
    _ = str.len();  // 👉 11
    ```

    > **Instantiate a string directly from a specified `value`.**

    ```zig
    var str = try String.instant("Hello 🌍!");
    defer str.deinit();

    _ = str.size(); // 👉 11
    _ = str.len();  // 👉 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Functions

   - #### ❱ Make some strings.

        | Method                                    | Description                                                 |
        | ----------------------------------------- | ----------------------------------------------------------- |
        | [`init`](./api/init.md)                   | Initializes an empty string.                                |
        | [`initWith`](./api/initWith.md)           | Initializes a string with `value`.                          |
        | [`initAlloc`](./api/initAlloc.md)         | Initializes an empty string with `specific allocator`.      |
        | [`initAllocWith`](./api/initAllocWith.md) | Initializes a string with `specific allocator` and `value`. |
        | [`instant`](./api/instant.md)             | Instantiates a string directly from a specified `value`.    |

   - #### ❱ Detect some information about the string.

        | Method                  | Description                                                     |
        | ----------------------- | --------------------------------------------------------------- |
        | [`size`](./api/size.md) | Returns the _(`size` / `capacity`)_ of the string.              |
        | [`len`](./api/len.md)   | Returns the number of _(`bytes` / `characters`)_ in the string. |
        | [`src`](./api/src.md)   | Returns the source of the string.                               |

   - #### ❱ Play with memory.

        | Method                      | Description                                           |
        | --------------------------- | ----------------------------------------------------- |
        | [`alloc`](./api/alloc.md)   | Allocate or reallocate the string to a new size.      |
        | [`deinit`](./api/deinit.md) | Deallocate the allocated memory and reset the string. |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Types

    > **_See [Types of `Bytes` Module](../Bytes/Bytes.md#types) for more information._**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;">Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>
