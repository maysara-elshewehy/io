<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/uString/logo.png" alt="uString" width="1000" />
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
    <b> Unmanaged dynamic-size string type that supports unicode. </b>
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
const uString = @import("io").uString;

pub fn main() void {
    // Init with any-value from any-type you want!
    var ustring = try uString.init(allocator, true);
    defer ustring.deinit(allocator);

    // Append any-value from any-type you have! xD
    try ustring.append(allocator, '!');
    try ustring.append(allocator, '=');
    try ustring.append(allocator, false);
    try ustring.append(allocator, "👨‍🏭");

    // Fast printing
    ustring.print(); // "true!=false👨‍🏭"

    // Detect the correct data.
    _ = ustring.len(); // 22 (👨‍🏭 = 11 byte)
    _ = ustring.vlen(); // 12 (👨‍🏭 = 1 character)

    // Correct unicode (codePoint/graphemeCluster) handling.
    _ = ustring.pop(); // "👨‍🏭" removed.

    // and more ..
}
```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

| Function           | Description                                               |
| ------------------ | --------------------------------------------------------- |
| init               | Initializes a `uString` instance with anytype.            |
| initEmpty          | Initializes a new empty `uString` instance.               |
| initWithSelf       | Initializes a new `uString` instance with the specified initial `uString`. |
| initWithSlice      | Initializes a new `uString` instance with the specified initial `bytes`. |
| initWithByte       | Initializes a new `uString` instance with the specified initial `byte`. |
| initWithFmt        | Initializes a `uString` instance with a formatted string. |
| initWithAllocator  | Initializes a new empty `uString` instance with the specified allocator. |
| initWithCapacity   | Initializes a new `uString` instance with the specified allocator and initial `capacity`. |
| deinit             | Releases all allocated memory associated with the `uString` instance. |
| size               | Returns the number of bytes that can be written.          |
| len                | Returns the total number of written bytes.                |
| vlen               | Returns the total number of visual characters.            |
| src                | Returns a slice containing only the written part.         |
| sub                | Returns a sub-slice of the `uString`.                     |
| charAt             | Returns a character at the specified index.               |
| atVisual           | Returns a character at the specified visual position.     |
| iterator           | Creates an iterator for traversing the Unicode bytes.     |
| writer             | Initializes a Writer which will append to the list.       |
| insertSlice        | Inserts a slice into the `uString` instance at the specified position. |
| insertByte         | Inserts a byte into the `uString` instance at the specified position. |
| insertSelf         | Inserts a `uString` into the `uString` instance at the specified position. |
| insertFmt          | Inserts a formatted string into the `uString` instance at the specified position. |
| visualInsertSlice  | Inserts a slice into the `uString` instance at the specified visual position. |
| visualInsertByte   | Inserts a byte into the `uString` instance at the specified visual position. |
| visualInsertSelf   | Inserts a `uString` into the `uString` instance at the specified visual position. |
| visualInsertFmt    | Inserts a formatted string into the `uString` instance at the specified visual position. |
| appendSlice        | Appends a slice to the `uString` instance.                |
| appendByte         | Appends a byte to the `uString` instance.                 |
| appendSelf         | Appends a `uString` to the `uString` instance.            |
| appendFmt          | Appends a formatted string to the `uString` instance.     |
| prependSlice       | Prepends a slice to the `uString` instance.               |
| prependByte        | Prepends a byte to the `uString` instance.                |
| prependSelf        | Prepends a `uString` to the `uString` instance.           |
| prependFmt         | Prepends a formatted string to the `uString` instance.    |
| removeIndex        | Removes a byte from the `uString` instance at the specified position. |
| removeVisualIndex  | Removes a byte from the `uString` instance by the specified visual position. |
| removeRange        | Removes a range of bytes from the `uString` instance.     |
| removeVisualRange  | Removes a range of bytes from the `uString` instance by the specified visual position. |
| pop                | Removes the last grapheme cluster from the `uString` instance. |
| shift              | Removes the first grapheme cluster from the `uString` instance. |
| trim               | Trims whitespace from both ends of the `uString` instance.|
| trimStart          | Trims whitespace from the start of the `uString` instance.|
| trimEnd            | Trims whitespace from the end of the `uString` instance.  |
| replaceRange       | Replaces a range of bytes with another slice in the `uString`. |
| replaceVisualRange | Replaces a visual range of bytes with another slice in the `uString`. |
| replaceFirst       | Replaces the first occurrence of a slice with another slice in the `uString`. |
| replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `uString`. |
| replaceLast        | Replaces the last occurrence of a slice with another slice in the `uString`. |
| replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `uString`. |
| replaceAll         | Replaces all occurrences of a slice with another slice in the `uString`. |
| replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `uString`. |
| repeat             | Repeats a byte `count` times and appends it to the `uString` instance. |
| find               | Finds the position of the first occurrence of the target slice. |
| findVisual         | Finds the visual position of the first occurrence of the target slice. |
| findLast           | Finds the position of the last occurrence of the target slice. |
| findLastVisual     | Finds the visual position of the last occurrence of the target slice. |
| includes           | Returns `true` if the `uString` instance contains the target slice. |
| startsWith         | Returns `true` if the `uString` instance starts with the target slice. |
| endsWith           | Returns `true` if the `uString` instance ends with the target slice. |
| toLower            | Converts all (ASCII) letters in the `uString` instance to lowercase. |
| toUpper            | Converts all (ASCII) letters in the `uString` instance to uppercase. |
| toTitle            | Converts all (ASCII) letters in the `uString` instance to title case. |
| isEqual            | Returns `true` if the `uString` instance equals the given target slice. |
| isEmpty            | Returns `true` if the `uString` instance is empty.        |
| split              | Splits the written portion into substrings separated by the specified delimiters. |
| splitAll           | Splits the written portion into all substrings separated by the specified delimiters. |
| splitToSelf        | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `uString` instance. |
| splitAllToSelf     | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `uString` instances. |
| clone              | Returns a deep copy of the `uString` instance.            |
| clear              | Clears the contents of the `uString`.                     |
| reverse            | Reverses the order of the characters in the `uString` instance (considering Unicode). |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Related Links

- [Viewer](./viewer.md)
- [Buffer](./buffer.md)
- [String](./string.md)
