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

<p align="center"> <b>Immutable fixed UTF-8 string done right.</b> </p>

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- ### Usage

    ```zig
    const Viewer = @import("io").types.Viewer;
    ```

    ```zig
    ..?  // 👉 ..?
    ```


<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

  - #### 🧩 Fields

      | Field    | Type         | Description                           |
      | -------- | ------------ | ------------------------------------- |
      | `source` | `[]const u8` | The UTF-8 encoded bytes to be viewed. |

   - #### ✨ Initialization

        | Function                | Description                                                   |
        | ----------------------- | ------------------------------------------------------------- |
        | [`init`](./api/init.md) | Initializes a new Viewer instance with the given UTF-8 bytes. |

   - #### 🚀 Iterations

        | Function                | Description                                                   |
        | ----------------------- | ------------------------------------------------------------- |
        | [`iterator`](./api/iterator.md) | Creates an iterator for traversing the UTF-8 bytes. |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/><br>
</div>

- #### 🔗 Related

  - #### [io.type.Buffer](../Buffer/Buffer.md)
    > Mutable fixed UTF-8 type.

  - #### [io.type.String](../String/String.md)
    > Managed dynamic UTF-8 type.
  
  - #### [io.type.uString](../uString/uString.md)
    > Unmanaged dynamic UTF-8 type.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;"><br>Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>