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

> The `Buffer` module offers a highly efficient implementation of fixed-size strings, fully optimized for `UTF-8` encoding, the unified standard across our projects.

> Designed for scenarios where memory usage and performance are critical, this fixed string type provides a predefined capacity that ensures zero runtime resizing, making it predictable and lightweight.
>
> Ideal for applications requiring strict size constraints or prioritizing speed and memory efficiency, the `Buffer` module is perfect for embedded systems, parsers, or other performance-critical use cases. Its focus on simplicity and precision ensures seamless handling of `UTF-8` text data without the overhead of dynamic allocations.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Usage

    ```zig
    const Buffer = @import("io").Buffer;
    ```

    > **Create a Buffer of size 64. Initially, length is 0.**

    ```zig
    var buf = try Buffer.init(64);

    _ = buf.size(); // 👉 64
    _ = buf.len();  // 👉 0
    ```

    > **Create a Buffer of size 64 and copy a bytes into it. Length reflects the bytes length.**

    ```zig
    var buf = try Buffer.initWith(64, "Hello 🌍!");

    _ = buf.size(); // 👉 64
    _ = buf.len();  // 👉 11
    ```

    > **Clone a bytes into a Buffer. Size and length are equal to the bytes length.**

    ```zig
    var buf = Buffer.instant("Hello 🌍!");

    _ = buf.size(); // 👉 11
    _ = buf.len();  // 👉 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Functions

   - #### ❱ Make some buffers.

        | Method                          | Description                                                              |
        | ------------------------------- | ------------------------------------------------------------------------ |
        | [`init`](./api/init.md)         | Initializes a buffer of the specified size.                              |
        | [`initWith`](./api/initWith.md) | Initializes a buffer of the specified size and copies the value into it. |
        | [`instant`](./api/instant.md)       | Copies the value into a new buffer.                                      |

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
