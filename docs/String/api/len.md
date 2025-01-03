# [←](../String.md) `String`.`len`

> Returns the number of _(`bytes` / `characters`)_ in the string.

```zig
pub fn len(_self: String) Types.len
```


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `String`

        > The `String` structure to handle.


<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `Types.len`

    > Returns the number of bytes in the string.

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const String = @import("io").String;
    ```

    ```zig
    const str = try String.clone("");
    _ = str.len();  // 👉 0
    ```

    ```zig
    const str = try String.clone("Hello 🌍!");
    _ = str.size(); // 👉 11
    _ = str.len();  // 👉 11
    ```

    ```zig
    const str = try String.makeWith("Hello 🌍!");
    _ = str.size(); // 👉 22
    _ = str.len();  // 👉 11
    ```

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.size`](./size.md)

  > [`String.src`](./src.md)

  > [`String.clone`](./clone.md)

<div align="center">
<img src="https://super-zig.github.io/io/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>