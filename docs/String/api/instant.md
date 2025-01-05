# [←](../String.md) `String`.`instant`

> Copies the value into a new string.

```zig
pub fn instant(_it: anytype) !String
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `Types.cbytes` or `Types.byte` or `String`

        > The input to instant.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `!String`

    > Returns `error.AllocationFailed` _if the allocation fails._

    > Returns `error.InvalidUTF8` _if the `_it` is not valid UTF-8._.

    > A new `String` initialized with the contents of `_it`.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const String = @import("io").String;
    ```

    > Empty value

    ```zig
    _ = String.instant("");            // 👉 "", size: 0, len
    ```

    > Non-Empty value

    ```zig
    _ = String.instant("Hello 🌍!");   // 👉 "Hello 🌍!", size: 11
    ```

    > Constant array of bytes.

    ```zig
    const src = "Hello 🌍!";
    _ = String.instant(src);           // 👉 "Hello 🌍!", size: 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.init`](./init.md)

  > [`String.initWith`](./initWith.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>