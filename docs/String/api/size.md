# [←](../String.md) `String`.`size`

> Returns the size of the string.

```zig
pub fn size(_self: String) Types.len
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `String`

        > The `String` structure to handle.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Types.len`

    > Returns the number of bytes in the string.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const String = @import("io").String;
    ```

    ```zig
    const str = try String.clone("");
    _ = str.size(); // 👉 0
    ```

    ```zig
    const str = try String.clone("Hello 🌍!");
    _ = str.size(); // 👉 11
    ```

    ```zig
    const str = try String.makeWith("Hello 🌍!");
    _ = str.size(); // 👉 22 (11 * 2) (To reduce the number of allocations)
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.len`](./len.md)

  > [`String.src`](./src.md)

  > [`String.clone`](./clone.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>