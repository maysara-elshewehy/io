# [←](../index.md) `io`.`Buffer`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/logo/Buffer/logo.png" alt="Buffer" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <b>Fixed UTF-8 string done right.</b><br />
</p>

<br />

<div align="center">
    <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

> The `Buffer` module offers a highly efficient implementation of fixed-size strings, optimized for `UTF-8` encoding.

> Designed for scenarios where memory usage and performance are critical, the fixed string type provides a predefined capacity that ensures zero runtime resizing, making it predictable and lightweight.
>
> This type is perfect for applications requiring strict size constraints or those that prioritize speed and memory efficiency.
>
> With a focus on simplicity and precision, the `Buffer` module enables seamless handling of text data without the overhead of dynamic allocations, making it an excellent choice for embedded systems, parsers, or other performance-critical use cases.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Usage

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    > **Create a Buffer of size 64. Initially, length is 0.**

    ```zig
    var buf = try Buffer.make(64);

    _ = buf.size(); // 👉 64
    _ = buf.len();  // 👉 0
    ```

    > **Create a Buffer of size 64 and copy a bytes into it. Length reflects the bytes length.**

    ```zig
    var buf = try Buffer.makeWith(64, "Hello 🌍!");

    _ = buf.size(); // 👉 64
    _ = buf.len();  // 👉 11
    ```

    > **Clone a bytes into a Buffer. Size and length are equal to the bytes length.**

    ```zig
    var buf = Buffer.clone("Hello 🌍!");

    _ = buf.size(); // 👉 11
    _ = buf.len();  // 👉 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Functions

   - #### ❱ Make some buffers.

        | Method                      | Description                                                           |
        | --------------------------- | --------------------------------------------------------------------- |
        | [`make`](./api/make.md)     | Creates a buffer of the specified size.                               |
        | [`makeWith`](./api/makeWith.md) | Creates a buffer of the specified size and copies the string into it. |
        | [`clone`](./api/clone.md)   | Creates a buffer and copies the string into it.                       |

   - #### ❱ Count the buffer.

        | Method                  | Description                                                     |
        | ----------------------- | --------------------------------------------------------------- |
        | [`len`](./api/len.md)   | Returns the number of _(`bytes` / `characters`)_ in the buffer. |
        | [`size`](./api/size.md) | Returns the _(`size` / `capacity`)_ of the buffer.              |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Types

    > **_See [Types of `Bytes` Module](../Bytes/Bytes.md#types) for more information._**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;">Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>
