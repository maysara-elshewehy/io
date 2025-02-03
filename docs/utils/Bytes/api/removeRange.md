# [←](../Bytes.md) `Bytes`.`removeRange`

> Removes a `range` of bytes from the `dest`.

```zig
pub fn removeRange(dest: []u8, dest_wlen: usize, pos: usize, len: usize) removeError!void
```


<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                         |
    | ----------- | ------- | ----------------------------------- |
    | `dest`      | `[]u8`  | The destination to remove from.     |
    | `dest_wlen` | `usize` | The write length of `dest`.         |
    | `pos`       | `usize` | The position of the byte to remove. |
    | `len`       | `usize` | The length to remove.               |

- #### 🚫 Errors

    | Error        | Reason                                 |
    | ------------ | -------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `dest_wlen`. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(7, "Hello !");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.removeRange(&array, 7, 0, 1); // 👉 "ello !"
        try Bytes.removeRange(&array, 6, 5, 1); // 👉 "ello "
        try Bytes.removeRange(&array, 5, 3, 1); // 👉 "ell "
        try Bytes.removeRange(&array, 4, 1, 1); // 👉 "el "
        try Bytes.removeRange(&array, 3, 0, 1); // 👉 "l "
        try Bytes.removeRange(&array, 2, 0, 1); // 👉 " "
        try Bytes.removeRange(&array, 1, 0, 1); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.removeRange(&array, 0, 1, 1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.remove`](./remove.md)

  > [`Bytes.removeVisual`](./removeVisual.md)

  > [`Bytes.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://github.com/maysara-elshewehy/io-bench/tree/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>