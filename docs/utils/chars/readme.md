# [←](../../readme.md) `io`.`utils`.`chars`

<center>
<img src="../../dist/img/logo/chars/logo.png" alt="chars" style="display: block; max-width: 100%;" />
<b style="font-style: italic;color:gray;">simplified and perfected.</b>

<div style="margin-top:20px; margin-bottom:0px;">
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</div>

<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px; max-width:50%;"/>
</center>

> ..?

<center>
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px; max-width:50%;"/>
</center>

- ### API

   - #### ❱ Basics

        | Method                  | Description                                                   |
        | ----------------------- | ------------------------------------------------------------- |
        | [`size`](./api/size.md) | Returns the size of a _(`string` or `char`)_                  |
        | [`calc`](./api/calc.md) | Returns the number of characters in the string.               |
        | [`make`](./api/make.md) | Returns a _(`fixed-string`)_ with specified size and content. |
        | [`get`](./api/get.md) | Returns the (`unicode` or `char`) at the specified position_(`non-real`)_ in the string. |

   - #### ➕ Insertion

        | Method                        | Description                                                                |
        | ----------------------------- | -------------------------------------------------------------------------- |
        | [`append`](./api/append.md)   | Inserts a _(`string` or `char`)_ into the `end` of the string.             |
        | [`prepend`](./api/prepend.md) | Inserts a _(`string` or `char`)_ into the `beg` of the string.             |
        | [`insert`](./api/insert.md)   | Inserts a _(`string` or `char`)_ into a `specific position` in the string. |

   - #### ➖ Deletion

        | Method                            | Description                                                             |
        | --------------------------------- | ----------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)       | Removes a _(`range` or `position`)_ from the string.                    |
        | [`shift`](./api/shift.md)         | Removes a _(`N` bytes)_ from the beg of the string.                     |
        | [`pop`](./api/pop.md)             | Removes a _(`N` bytes)_ from the end of the string _(using `/0`)_.      |
        | [`trim`](./api/trim.md)           | Removes all matching characters fromt both start and end of the string. |
        | [`trimEnd`](./api/trimEnd.md)     | Removes all matching characters at the end of the string.               |
        | [`trimStart`](./api/trimStart.md) | Removes all matching characters at the beg of the string.               |
        | [`zeros`](./api/zeros.md)         | Fills a string with _(`\0` character)_.                                 |

    - #### ➷ Find

        | Method                    | Description                                                           |
        | ------------------------- | --------------------------------------------------------------------- |
        | [`find`](./api/find.md)   | Returns the first occurrence of a _(`string` or `char`)_ in a string. |
        | [`rfind`](./api/rfind.md) | Returns the last occurrence of a _(`string` or `char`)_ in a string.  |

    - #### ℀ Case

        | Method                        | Description                                     |
        | ----------------------------- | ----------------------------------------------- |
        | [`toLower`](./api/toLower.md) | Converts all (ASCII) letters to _`lower` case_. |
        | [`toUpper`](./api/toUpper.md) | Converts all (ASCII) letters to _`upper` case_. |
        | [`toTitle`](./api/toTitle.md) | Converts all (ASCII) words to _`title` case_.   |

    - #### ⚌ Check

        | Method                              | Description                                                   |
        | ----------------------------------- | ------------------------------------------------------------- |
        | [`eql`](./api/eql.md)               | Returns true if the given strings are equivalent.             |
        | [`includes`](./api/includes.md)     | Returns true if the string contains a _(`string` or `char`)_. |
        | [`endsWith`](./api/endsWith.md)     | Returns true if the string ends with the given substring.     |
        | [`startsWith`](./api/startsWith.md) | Returns true if the string starts with the given substring.   |

    - #### ⚌ Replace

        | Method                          | Description                                                                                                    |
        | ------------------------------- | -------------------------------------------------------------------------------------------------------------- |
        | [`replace`](./api/replace.md)   | Replaces the first `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements. |
        | [`rreplace`](./api/rreplace.md) | Replaces the last `N` occurrences of _(`string` or `char`)_ with another, Returns the number of replacements.  |

    - #### ⚌ More

        | Method                        | Description                                                                |
        | ----------------------------- | -------------------------------------------------------------------------- |
        | [`repeat`](./api/repeat.md)   | Repeats the _(`string` or `char`)_ `N` times.                              |
        | [`reverse`](./api/reverse.md) | Reverses the characters in the string.                                     |
        | [`split`](./api/split.md)     | Splits the string into a slice based on a delimiter and a target position. |

<center>
<img src="../../dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px; max-width:50%;"/>
</center>

<center>
<p style="color:grey;">Made with ❤️ by <a style="background: rgb(241,196,80); background: linear-gradient(90deg, rgba(241,196,80,1) 38%, rgba(255,207,115,1) 52%, rgba(246,192,70,1) 62%);-webkit-background-clip: text; -webkit-text-fill-color: transparent;" href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>
</center>