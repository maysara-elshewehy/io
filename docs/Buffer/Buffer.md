# [←](../) `io`.`Buffer`

<p align="center">
  <img src="../../dist/img/logo/Buffer/logo.png" alt="chars" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <b>Fixed string done right.</b><br />
</p>

<br />

<div align="center">
    <img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

</div>

> ..?

<div align="center">
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
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
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
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
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Types

    > **_See [Types of `Bytes` Module](../Bytes/Bytes.md#types) for more information._**

<div align="center">
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;">Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>
