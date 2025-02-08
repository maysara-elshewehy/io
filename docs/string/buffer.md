<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/Buffer/logo.png" alt="Buffer" width="1000" />
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
    <b> Mutable fixed-size string type that supports unicode. </b>
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
const Buffer = @import("io").Buffer;

pub fn main() void {
    // Init with any-value from any-type you want!
    var buffer = try Buffer(100).init(true);

    // Append any-value from any-type you have! xD
    try buffer.append('!');
    try buffer.append('=');
    try buffer.append(false);
    try buffer.append("👨‍🏭");

    // Fast printing
    buffer.print(); // "true!=false👨‍🏭"

    // Detect the correct data.
    _ = buffer.len(); // 22 (👨‍🏭 = 11 byte)
    _ = buffer.vlen(); // 12 (👨‍🏭 = 1 character)

    // Correct unicode (codePoint/graphemeCluster) handling.
    _ = buffer.pop(); // "👨‍🏭" removed.

    // and more ..
}
```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

| Function           | Description                                               |
| ------------------ | --------------------------------------------------------- |
| init               | Initializes a `Buffer` instance with anytype.             |
| initEmpty          | Initializes a new empty `Buffer` instance.                |
| initWithSelf       | Initializes a new `Buffer` instance with the specified initial `Buffer`. |
| initWithSlice      | Initializes a new `Buffer` instance with the specified initial `bytes`. |
| initWithByte       | Initializes a new `Buffer` instance with the specified initial `byte`. |
| initWithFmt        | Initializes a `Buffer` instance with a formatted string.  |
| size               | Returns the number of bytes that can be written.          |
| len                | Returns the total number of written bytes.                |
| vlen               | Returns the total number of visual characters.            |
| src                | Returns a slice containing only the written part.         |
| sub                | Returns a sub-slice of the `Buffer`.                      |
| charAt             | Returns a character at the specified index.               |
| atVisual           | Returns a character at the specified visual position.     |
| iterator           | Creates an iterator for traversing the Unicode bytes.     |
| writer             | Initializes a Writer which will append to the list.       |
| insertSlice        | Inserts a slice into the `Buffer` instance at the specified position. |
| insertByte         | Inserts a byte into the `Buffer` instance at the specified position. |
| insertSelf         | Inserts a `Buffer` into the `Buffer` instance at the specified position. |
| insertFmt          | Inserts a formatted string into the `Buffer` instance at the specified position. |
| visualInsertSlice  | Inserts a slice into the `Buffer` instance at the specified visual position. |
| visualInsertByte   | Inserts a byte into the `Buffer` instance at the specified visual position. |
| visualInsertSelf   | Inserts a `Buffer` into the `Buffer` instance at the specified visual position. |
| visualInsertFmt    | Inserts a formatted string into the `Buffer` instance at the specified visual position. |
| appendSlice        | Appends a slice to the `Buffer` instance.                 |
| appendByte         | Appends a byte to the `Buffer` instance.                  |
| appendSelf         | Appends a `Buffer` to the `Buffer` instance.              |
| appendFmt          | Appends a formatted string to the `Buffer` instance.      |
| prependSlice       | Prepends a slice to the `Buffer` instance.                |
| prependByte        | Prepends a byte to the `Buffer` instance.                 |
| prependSelf        | Prepends a `Buffer` to the `Buffer` instance.             |
| prependFmt         | Prepends a formatted string to the `Buffer` instance.     |
| removeIndex        | Removes a byte from the `Buffer` instance at the specified position. |
| removeVisualIndex  | Removes a byte from the `Buffer` instance by the specified visual position. |
| removeRange        | Removes a range of bytes from the `Buffer` instance.      |
| removeVisualRange  | Removes a range of bytes from the `Buffer` instance by the specified visual position. |
| pop                | Removes the last grapheme cluster from the `Buffer` instance. |
| shift              | Removes the first grapheme cluster from the `Buffer` instance. |
| trim               | Trims whitespace from both ends of the `Buffer` instance. |
| trimStart          | Trims whitespace from the start of the `Buffer` instance. |
| trimEnd            | Trims whitespace from the end of the `Buffer` instance.   |
| replaceRange       | Replaces a range of bytes with another slice in the `Buffer`. |
| replaceVisualRange | Replaces a visual range of bytes with another slice in the `Buffer`. |
| replaceFirst       | Replaces the first occurrence of a slice with another slice in the `Buffer`. |
| replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `Buffer`. |
| replaceLast        | Replaces the last occurrence of a slice with another slice in the `Buffer`. |
| replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `Buffer`. |
| replaceAll         | Replaces all occurrences of a slice with another slice in the `Buffer`. |
| replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `Buffer`. |
| repeat             | Repeats a byte `count` times and appends it to the `Buffer` instance. |
| find               | Finds the position of the first occurrence of the target slice. |
| findVisual         | Finds the visual position of the first occurrence of the target slice. |
| findLast           | Finds the position of the last occurrence of the target slice. |
| findLastVisual     | Finds the visual position of the last occurrence of the target slice. |
| includes           | Returns `true` if the `Buffer` instance contains the target slice. |
| startsWith         | Returns `true` if the `Buffer` instance starts with the target slice. |
| endsWith           | Returns `true` if the `Buffer` instance ends with the target slice. |
| toLower            | Converts all (ASCII) letters in the `Buffer` instance to lowercase. |
| toUpper            | Converts all (ASCII) letters in the `Buffer` instance to uppercase. |
| toTitle            | Converts all (ASCII) letters in the `Buffer` instance to title case. |
| isEqual            | Returns `true` if the `Buffer` instance equals the given target slice. |
| isEmpty            | Returns `true` if the `Buffer` instance is empty.         |
| split              | Splits the written portion into substrings separated by the specified delimiters. |
| splitAll           | Splits the written portion into all substrings separated by the specified delimiters. |
| splitToSelf        | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `Buffer` instance. |
| splitAllToSelf     | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `Buffer` instances. |
| clone              | Returns a deep copy of the `Buffer` instance.             |
| clear              | Clears the contents of the `Buffer`.                      |
| reverse            | Reverses the order of the characters in the `Buffer` instance (considering Unicode). |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Related Links

- [Viewer](./viewer.md)
- [String](./string.md)
- [uString](./ustring.md)
