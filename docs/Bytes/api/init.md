# [←](../Bytes.md) `Bytes`.`init`

> Creates an array of `size` bytes.

```zig
pub fn init(comptime _size: Types.len) ![_size]Types.byte
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime _size` : `Types.len`

        > The specified size of the array.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `![_size]Types.byte`

    > Returns `error.ZeroValue` _if the `_size` is 0_.

    > A new array with specified size, initialized with `0`.

    > **You can use the `Unchecked` ~= `Bytes.initUnchecked` version for no checks/errors.**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    ```zig
    _ = try Bytes.init(0);  // 👉 error.ZeroValue
    ```

    ```zig
    _ = try Bytes.init(64); // 👉 "", size: 64
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.initWith`](./initWith.md)

  > [`Bytes.clone`](./clone.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>