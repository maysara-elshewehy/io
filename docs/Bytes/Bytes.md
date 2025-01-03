# [←](../index.md) `io`.`Bytes`

<p align="center">
  <img src="https://super-zig.github.io/io/_dist/img/logo/Bytes/logo.png" alt="Bytes" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <b>Simplified and perfected.</b><br />
</p>

<br />

<div align="center">
    <img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

</div>

> Everything for me is either a **`byte`** or a **`bytes`**, and **my preferred and universally accepted format** is `UTF-8`, so before using this library, know that it **only handles cases that follow the guidelines of this format**, otherwise **an error will be returned** indicating that.
>
> This library was built after many trials and experiments, so it is well polished, whether in terms of **performance**, **testing**, **documentation**, or even **the quality of the code** itself and its maintainability later.
>
> Designed to streamline text and byte manipulation, reducing development time and effort.
>
>  With this library, you can focus on building your application's core logic while leaving the heavy lifting of text processing to **Bytes**.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Usage

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    > **Create an empty buffer of size 64.**

    ```zig
    var res = try Bytes.make(64);

    _ = res.len;          // 👉 64
    _ = Bytes.count(res); // 👉 0
    ```

    > **Create a buffer of size 64 and copy a bytes into it.**

    ```zig
    var res = try Bytes.makeWith(64, "Hello 🌍!");

    _ = res.len;          // 👉 64
    _ = Bytes.count(res); // 👉 11
    ```

    > **Clone a bytes into a new buffer.**

    ```zig
    var res = Bytes.clone("Hello 🌍!");

    _ = res.len;          // 👉 11
    _ = Bytes.count(res); // 👉 11
    ```

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Functions

   - #### ❱ Starting with bytes.

        | Method                        | Description                                                   |
        | ----------------------------- | ------------------------------------------------------------- |
        | [`isByte`](./api/isByte.md)   | Returns `true` if the type of `input` is a [`byte`](#types).  |
        | [`isBytes`](./api/isBytes.md) | Returns `true` if the type of `input` is a [`bytes`](#types). |
        | [`toByte`](./api/toByte.md)   | Safely casts the `input` value to a [`byte`](#types).         |

   - #### ❱ Make some bytes.

        | Method                      | Description                                                                         |
        | --------------------------- | ----------------------------------------------------------------------------------- |
        | [`make`](./api/make.md)     | Creates an array of `size` bytes.                                                   |
        | [`makeWith`](./api/makeWith.md) | Creates a valid `utf-8` array of `size` bytes and copies the `input` bytes into it. |
        | [`copy`](./api/copy.md)     | Copies the `input` bytes into `another` array.                                      |
        | [`clone`](./api/clone.md)   | Copies the `input` bytes into a `new` array.                                        |

   - #### ❱ Count the bytes.

        | Method                    | Description                                                                                  |
        | ------------------------- | -------------------------------------------------------------------------------------------- |
        | [`count`](./api/count.md) | Returns the number of bytes in the `input` array, stops at the first 0 byte, or at the size. |

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Types

    > You can access to types using `Bytes.Types.<typeName>`

    | Type     | Refer To       |
    | -------- | -------------- |
    | `byte`   | `u8`           |
    | `bytes`  | `[]byte`       |
    | `cbytes` | `[]const byte` |
    | `len`    | `usize`        |
    | `range`  | `[2]len`       |

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;">Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>