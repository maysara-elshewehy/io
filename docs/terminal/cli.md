<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/CLI/logo.png" alt="CLI" width="1000" />
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
    <b> Easy CLI in ZIG. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://super-zig.github.io/io/terminal">SuperZIG/io/terminal</a> module.</sup>
    </i></b>
</div>


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center">
    <b><i>
        <sup> 🔥 Built for power. Designed for speed. Ready for production. 🔥 </sup>
    </i></b>
</div>
<br>


- ### 🚀 Features 🚀

  - **📋 Command Management**
      > Define and handle commands with ease.

  - **🛠️ Option Parsing**
      > Support for short and long options, with or without values.

  - **❗ Required Options**
      > Enforce the presence of required options for commands.

  - **⚙️ Optional Options**
      > Provide flexibility to commands by allowing additional configuration without being mandatory.

  - **🌍 Platform Compatibility**
      > Supports Windows, Linux and macOS.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🛠 API Reference](#api) – Detailed documentation of available functions.

    🔹 [🌍 Comparisons](#comparisons) – Detailed comparison with other libraries.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const cli = @import("io").terminal.cli;
    ```

    1. #### Define Commands and Options

        > Now let's create our **command line application**, but before that we need to define the `commands` and `options` used to handle the user input arguments in the terminal, for example:

        ```zig
        const commands = [_]types.command {

            types.command {
                .name   = "test",                           // Name of the command
                .func   = &methods.commands.testFN,         // Function associated with the command
                .req    = &.{ "option1", "option2" },       // Required options for 'test' command
                .opt    = &.{ "option3" },                  // Optional options for 'test' command
            },

            types.command {
                .name   = "help",                           // Name of the command
                .func   = &methods.commands.helpFN,         // Function associated with the command
            }
        };
        ```

        > now we have two commands (`test` and `help`),
        > the `help` command can be used without any options but the `test` command required (`option1` and `option2`) and optionally `option3`.

        > Now lets define the command options.

        ```zig
        const options = [_]types.option {

            types.option {
                .name   = "option1",
                .short  = '1',
                .long   = "option1",
            },

            types.option {
                .name   = "option2",
                .short  = '2',
                .long   = "option2",
            },

            types.option {
                .name   = "option3",
                .short  = '3',
                .long   = "option3",
                .func   = &methods.options.option3FN
            },
        };
        ```

        > After defining the commands and its options, we need to define the handlers.

        ```zig
        const methods = struct {

            pub const commands = struct {

                pub fn testFN(_options: []const types.option) bool {
                    return true;
                }

                pub fn helpFN(_: []const types.option) bool {
                    return true;
                }
            };

            pub const options = struct {
                pub fn option3FN(_val : []const u8) bool {
                    return true;
                }
            };
        };
        ```

    2. #### Start the CLI Application

        > Pass your commands, options, and enable/disable debugging.

        ```zig
        pub fn main() !void {
            try cli.start(&commands, &options, true);
        }
        ```

    3. #### Run Your CLI

        > Compile and execute your application.

        ```bash
        ./your_app test -1 valOne -2 valTwo -3 valThree
        ```


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API

    > TODO

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Comparisons

    > TODO


- ### 🔗 Related

    - [Prompts](#)

        > Interactive prompts for user input.

    - [Events](./events.md)

        > Event handling for terminal input.


    - [Ansi](./ansi.md)

        > ANSI escape codes handling.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>