<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/logo/String/logo.png" alt="String" width="1000" />
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
    <b> Managed dynamic-size string type that supports unicode. </b>
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
const String = @import("io").String;

pub fn main() void {
    // Init with any-value from any-type you want!
    var string = try String(u8).init(allocator, true);
    defer string.deinit();

    // Append any-value from any-type you have! xD
    try string.append('!');
    try string.append('=');
    try string.append(false);
    try string.append("👨‍🏭");

    // Fast printing
    string.print(); // "true!=false👨‍🏭"

    // Detect the correct data.
    _ = string.len(); // 22 (👨‍🏭 = 11 char)
    _ = string.vlen(); // 12 (👨‍🏭 = 1 character)

    // Correct unicode (codePoint/graphemeCluster) handling.
    _ = string.pop(); // "👨‍🏭" removed.

    // and more ..
}
```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### API

| Function           | Description                                               |
| ------------------ | --------------------------------------------------------- |
| init               | Initializes a `String` instance with anytype.             |
| initEmpty          | Initializes a new empty `String` instance.                |
| initWithSelf       | Initializes a new `String` instance with the specified initial `String`. |
| initWithSlice      | Initializes a new `String` instance with the specified initial `chars`. |
| initWithChar       | Initializes a new `String` instance with the specified initial `char`. |
| initWithFmt        | Initializes a `String` instance with a formatted string.  |
| initWithAllocator  | Initializes a new empty `String` instance with the specified allocator. |
| initWithCapacity   | Initializes a new `String` instance with the specified allocator and initial `capacity`. |
| deinit             | Releases all allocated memory associated with the `String` instance. |
| size               | Returns the number of chars that can be written.          |
| len                | Returns the total number of written chars.                |
| vlen               | Returns the total number of visual characters.            |
| src                | Returns a slice containing only the written part.         |
| sub                | Returns a sub-slice of the `String`.                      |
| charAt             | Returns a character at the specified index.               |
| atVisual           | Returns a character at the specified visual position.     |
| iterator           | Creates an iterator for traversing the Unicode chars.     |
| writer             | Initializes a Writer which will append to the list.       |
| insertSlice        | Inserts a slice into the `String` instance at the specified position. |
| insertChar         | Inserts a char into the `String` instance at the specified position. |
| insertSelf         | Inserts a `String` into the `String` instance at the specified position. |
| insertFmt          | Inserts a formatted string into the `String` instance at the specified position. |
| visualInsertSlice  | Inserts a slice into the `String` instance at the specified visual position. |
| visualInsertChar   | Inserts a char into the `String` instance at the specified visual position. |
| visualInsertSelf   | Inserts a `String` into the `String` instance at the specified visual position. |
| visualInsertFmt    | Inserts a formatted string into the `String` instance at the specified visual position. |
| appendSlice        | Appends a slice to the `String` instance.                 |
| appendChar         | Appends a char to the `String` instance.                  |
| appendSelf         | Appends a `String` to the `String` instance.              |
| appendFmt          | Appends a formatted string to the `String` instance.      |
| prependSlice       | Prepends a slice to the `String` instance.                |
| prependChar        | Prepends a char to the `String` instance.                 |
| prependSelf        | Prepends a `String` to the `String` instance.             |
| prependFmt         | Prepends a formatted string to the `String` instance.     |
| removeIndex        | Removes a char from the `String` instance at the specified position. |
| removeVisualIndex  | Removes a char from the `String` instance by the specified visual position. |
| removeRange        | Removes a range of chars from the `String` instance.      |
| removeVisualRange  | Removes a range of chars from the `String` instance by the specified visual position. |
| pop                | Removes the last grapheme cluster from the `String` instance. |
| shift              | Removes the first grapheme cluster from the `String` instance. |
| trim               | Trims whitespace from both ends of the `String` instance. |
| trimStart          | Trims whitespace from the start of the `String` instance. |
| trimEnd            | Trims whitespace from the end of the `String` instance.   |
| replaceRange       | Replaces a range of chars with another slice in the `String`. |
| replaceVisualRange | Replaces a visual range of chars with another slice in the `String`. |
| replaceFirst       | Replaces the first occurrence of a slice with another slice in the `String`. |
| replaceFirstN      | Replaces the first N(count) occurrence of a slice with another slice in the `String`. |
| replaceLast        | Replaces the last occurrence of a slice with another slice in the `String`. |
| replaceLastN       | Replaces the last N(count) occurrence of a slice with another slice in the `String`. |
| replaceAll         | Replaces all occurrences of a slice with another slice in the `String`. |
| replaceNth         | Replaces the `nth` occurrence of a slice with another slice in the `String`. |
| repeat             | Repeats a char `count` times and appends it to the `String` instance. |
| find               | Finds the position of the first occurrence of the target slice. |
| findVisual         | Finds the visual position of the first occurrence of the target slice. |
| findLast           | Finds the position of the last occurrence of the target slice. |
| findLastVisual     | Finds the visual position of the last occurrence of the target slice. |
| includes           | Returns `true` if the `String` instance contains the target slice. |
| startsWith         | Returns `true` if the `String` instance starts with the target slice. |
| endsWith           | Returns `true` if the `String` instance ends with the target slice. |
| toLower            | Converts all (ASCII) letters in the `String` instance to lowercase. |
| toUpper            | Converts all (ASCII) letters in the `String` instance to uppercase. |
| toTitle            | Converts all (ASCII) letters in the `String` instance to title case. |
| isEqual            | Returns `true` if the `String` instance equals the given target slice. |
| isEmpty            | Returns `true` if the `String` instance is empty.         |
| split              | Splits the written portion into substrings separated by the specified delimiters. |
| splitAll           | Splits the written portion into all substrings separated by the specified delimiters. |
| splitToSelf        | Splits the written portion into substrings separated by the specified delimiters, returning the substring at the specified index as a new `String` instance. |
| splitAllToSelf     | Splits the written portion into all substrings separated by the specified delimiters, returning an array of new `String` instances. |
| clone              | Returns a deep copy of the `String` instance.             |
| clear              | Clears the contents of the `String`.                      |
| reverse            | Reverses the order of the characters in the `String` instance (considering Unicode). |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/io-bench/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

### Related Links

- [Viewer](./viewer.md)
- [Buffer](./buffer.md)
- [uString](./ustring.md)
