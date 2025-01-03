# [←](../) `io`.`String`

<p align="center">
  <img src="../../dist/img/logo/String/logo.png" alt="chars" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <b>Dynamic string done right.</b><br />
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
    const String = @import("io").String;
    ```
- ### Examples

    > Create an empty string

    ```zig
    var str = String.make();
    // 🌟 Use `String.makeAlloc` to use a specific allocator.

    _ = str.size(); // 👉 0
    _ = str.len();  // 👉 0
    ```

    > Create a string with initial content

    ```zig
    var str = try String.makeWith("Hello 🌍!");
    // 🌟 Use `String.makeWithAlloc` to use a specific allocator.

    _ = str.size(); // 👉 22 (11 * 2) (To reduce the number of allocations)
    _ = str.len();  // 👉 11
    ```

    > Clone an existing string

    ```zig
    var str = try String.clone("Hello 🌍!");

    _ = str.size(); // 👉 11
    _ = str.len();  // 👉 11
    ```

<div align="center">
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Functions

   - #### ❱ Make some strings.

        | Method                                    | Description                                                                    |
        | ----------------------------------------- | ------------------------------------------------------------------------------ |
        | [`make`](./api/make.md)                   | Creates a string of the specified size.                                        |
        | [`makeAlloc`](./api/makeAlloc.md)         | Creates a new string with a `specific allocator`.                              |
        | [`makeWith`](./api/makeWith.md)           | Creates a string of the specified size and copies the string into it.          |
        | [`makeWithAlloc`](./api/makeWithAlloc.md) | Creates a new string with a `specific allocator` and copies the bytes into it. |
        | [`clone`](./api/clone.md)                 | Creates a new string and copies the bytes into it with the same size.          |

   - #### ❱ Detect some information about the string.

        | Method                  | Description                                                     |
        | ----------------------- | --------------------------------------------------------------- |
        | [`size`](./api/size.md) | Returns the _(`size` / `capacity`)_ of the string.              |
        | [`len`](./api/len.md)   | Returns the number of _(`bytes` / `characters`)_ in the string. |
        | [`src`](./api/src.md)   | Returns the source of the string.                               |

   - #### ❱ Play with memory.

        | Method                    | Description                                             |
        | ------------------------- | ------------------------------------------------------- |
        | [`alloc`](./api/alloc.md) | Allocate or reallocate the string string to a new size. |
        | [`free`](./api/free.md)   | Deallocate the allocated memory and reset the string.   |

<div align="center">
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Types

    > **_See [Types of `Bytes` Module](../Bytes/Bytes.md#types) for more information._**

<div align="center">
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<p align="center" style="color:grey;">Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>
