# [←](../String.md) `String`.`makeWith`

> Creates a new string and copies the bytes into it.

```zig
pub fn makeWith(_it: Types.cbytes) !String
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_it` : `Types.cbytes`

        > The input to copy.

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

    > Empty String

    ```zig
    _ = try String.makeWith("");           // 👉 "", size: 0, length: 0
    ```

    > Non-Empty String

    ```zig
    _ = try String.makeWith("Hello 🌍!");  // 👉 "Hello 🌍!", size: 22, length: 11
    ```

    > Constant String.

    ```zig
    const src = "Hello 🌍!";
    _ = try String.makeWith(src);          // 👉 "Hello 🌍!", size: 22, length: 11
    ```

    > Mutable String.

    ```zig
    var src = "Hello 🌍!";
    _ = try String.makeWith(src[0..]);     // 👉 "Hello 🌍!", size: 22, length: 11
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`String.makeWithAlloc`](./makeWithAlloc.md)

  > [`String.make`](./make.md)

  > [`String.src`](./src.md)

  > [`String.clone`](./clone.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>