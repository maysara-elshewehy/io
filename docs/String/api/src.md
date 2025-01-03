# [←](../String.md) `String`.`src`

> Returns the source of the string.

```zig
pub fn src(_self: String) Types.cbytes
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

- #### Returns : `Types.cbytes`

    > Returns source of the string as a constant array of bytes.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const String = @import("io").String;
    ```

    ```zig
    const str = try String.clone("");
    _ = str.src(); // 👉 ""
    ```

    ```zig
    const str = try String.clone("Hello 🌍!");
    _ = str.src(); // 👉 "Hello 🌍!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.clone`](./clone.md)

  > [`String.size`](./size.md)

  > [`String.len`](./len.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>