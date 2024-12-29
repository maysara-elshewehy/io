# [←](../readme.md) `io`.`types`.`buffer`.`Iterator`

> The underlying type of the Iterator returned by `iterator()`.

```zig
pub const Iterator = struct {
    m_string: *const Self,
    m_index: types.len,

    pub fn next(_it: *Iterator) ?types.cstr
};
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Fields

    - `m_string` : `*const Self`

        > String to iterate.

    - `m_index` : `types.len`

        > Current index.

- #### Methods

    - `pub fn next(_it: *Iterator) ?types.cstr`

        > Returns the next character in the string.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const buffer = @import("io").types.buffer;
    ```

    ```zig
    var str = try string.initWith(alloc, "Hello 🌍!");
    defer str.deinit();

    var i: usize = 0;
    var iter : str.Iterator = str.iterator();
    while (iter.next()) |c| {
        if (i == 5) // 👉 "🌍"
        i += 1;
    }
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.buffer.iterator`](./iterator.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>