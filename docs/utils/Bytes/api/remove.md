# [←](../Bytes.md) `Bytes`.`remove`

> Removes a byte from the `dest`.

```zig
pub fn remove(dest: []u8, dest_wlen: usize, pos: usize) removeError!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧩 Parameters

    | Parameter   | Type    | Description                         |
    | ----------- | ------- | ----------------------------------- |
    | `dest`      | `[]u8`  | The destination to remove from.     |
    | `dest_wlen` | `usize` | The write length of `dest`.         |
    | `pos`       | `usize` | The position of the byte to remove. |

- #### 🚫 Errors

    | Error        | Reason                                 |
    | ------------ | -------------------------------------- |
    | `OutOfRange` | The `pos` is greater than `dest_wlen`. |

- #### ✨ Returns : `void`

    > Modifies `dest` in place.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### 🧪 Examples

    ```zig
    const Bytes = @import("io").utils.Bytes;
    var array = try Bytes.init(7, "Hello !");
    ```

    - ##### 🟢 Success Cases

        ```zig
        try Bytes.remove(&array, 7, 0); // 👉 "ello !"
        try Bytes.remove(&array, 6, 5); // 👉 "ello "
        try Bytes.remove(&array, 5, 3); // 👉 "ell "
        try Bytes.remove(&array, 4, 1); // 👉 "el "
        try Bytes.remove(&array, 3, 0); // 👉 "l "
        try Bytes.remove(&array, 2, 0); // 👉 " "
        try Bytes.remove(&array, 1, 0); // 👉 ""
        ```

    - ##### 🔴 Failure Cases

        > **_OutOfRange._**

        ```zig
        _ = Bytes.remove(&array, 0, 1); // 👉 error.OutOfRange
        ```

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### 🔗 Related

  > [`Bytes.init`](./init.md)

  > [`Bytes.removeRange`](./removeRange.md)

  > [`Bytes.removeVisual`](./removeVisual.md)

  > [`Bytes.removeVisualRange`](./removeVisualRange.md)

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>