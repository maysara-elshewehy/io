<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Viewer/logo.png" alt="Viewer" width="1000" />
</p>

<p align="center">
     <a href="#">
        <img src="https://img.shields.io/badge/under--development-yellow.svg" alt="Under Development" />
    </a>
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
    <b> Immutable fixed-size string type that supports unicode. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://github.com/Super-ZIG/io/string/">SuperZIG/io/string</a> module.</sup>
    </i></b>
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Example

```zig
const Viewer = @import("io").Viewer;

pub fn main() void {
    // Init with slice.
    var viewer = Viewer.initWithSlice("Hello 👨‍🏭!");

    // Fast printing
    viewer.print(); // "true!=false👨‍🏭"

    // Detect the correct data.
    _ = viewer.len(); // 18 (👨‍🏭 = 11 byte)
    _ = viewer.vlen(); // 8 (👨‍🏭 = 1 character)

    // and more ..
}
```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

| Function           | Description                                               |
| ------------------ | --------------------------------------------------------- |
| init               | Initializes a `Viewer` instance with anytype.             |
| initEmpty          | Initializes a new empty `Viewer` instance.                |
| initWithSelf       | Initializes a new `Viewer` instance with the specified initial `Viewer`. |
| initWithSlice      | Initializes a new `Viewer` instance with the specified initial `bytes`. |
| size               | Returns the number of bytes that can be written.          |
| len                | Returns the total number of written bytes.                |
| vlen               | Returns the total number of visual characters.            |
| src                | Returns a slice containing only the written part.         |
| sub                | Returns a sub-slice of the `Viewer`.                      |
| charAt             | Returns a character at the specified index.               |
| atVisual           | Returns a character at the specified visual position.     |
| iterator           | Creates an iterator for traversing the Unicode bytes.     |
| find               | Finds the position of the first occurrence of the target slice. |
| findVisual         | Finds the visual position of the first occurrence of the target slice. |
| findLast           | Finds the position of the last occurrence of the target slice. |
| findLastVisual     | Finds the visual position of the last occurrence of the target slice. |
| includes           | Returns `true` if the `Viewer` instance contains the target slice. |
| startsWith         | Returns `true` if the `Viewer` instance starts with the target slice. |
| endsWith           | Returns `true` if the `Viewer` instance ends with the target slice. |
| isEqual            | Returns `true` if the `Viewer` instance equals the given target slice. |
| isEmpty            | Returns `true` if the `Viewer` instance is empty.         |
| split              | Splits the written portion into substrings separated by the specified delimiters. |
| splitAll           | Splits the written portion into all substrings separated by the specified delimiters. |
| splitToSelf        | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `Viewer` instance. |
| splitAllToSelf     | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `Viewer` instances. |
| clone              | Returns a deep copy of the `Viewer` instance.             |
| clear              | Clears the contents of the `Viewer`.                      |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Related Links

- [Buffer](./buffer.md)
- [String](./string.md)
- [uString](./ustring.md)
