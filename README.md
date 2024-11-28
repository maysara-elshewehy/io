# **[SuperZIG](https://github.com/Super-ZIG)** \ IO 🚀

A simple and efficient library for handling **input/output** operations in the **ZIG** programming language.

This library provides various methods to interact with the system, from reading input to writing output, and even listening to system events. 🎧

## Features ✨

- **🎤 Output Handling**
    > Output messages to the console easily with customizable formats.
  
- **📝 Input Handling**
    > Read inputs from the console, with flexible reading capabilities.
  
- **🌍 Platform Compatibility**
    > Supports Windows, Linux and macOS.
  
- **🖱️ Event Listening**
    > Listen to system events like key presses in real-time.

- **📦 Single File Usage**  
    > Use the lightweight version directly by dragging `io.lite.zig` into your project.

## Usage 📖

Here are some of the main methods you can use in **SuperZIG - IO** :

- ### [`out`](./docs/func/out.md) 📢

    Outputs a simple message followed by a newline to the console.

    ```zig
    io.out("Hello, World!");                    // print "Hello, World!\n"
    ```

- ### [`in`](./docs/func/in.md) 📥
    
    Reads input from the user until a newline character is encountered.

    ```zig
    const input = io.in();                      // wait for user input..
    io.outWith("Input: {s} \n", .{ input });    // print "Input: <input>\n"
    ```

- ### [`ask`](./docs/func/ask.md) ❓

    Displays a message and waits for the user to respond.

    ```zig
    const name = io.ask("What's your name?");   // print "What's your name?\n"
                                                // wait for user input..
    io.outWith("Welcome, {s} \n", .{ name });   // print "Welcome, <name>\n"
    ```

- ### [`on`](./docs/func/on.md) , [`once`](./docs/func/once.md) 👂

    Listens for key input.

    ```zig
    const example = struct
    {
        inline fn callback(key: io.types.key) !void
        {
            try io.outWith("code: {d} , char:  {c} , mod: {s}   \n"     , .{ key.code() , key.char() , key.mod() });
            try io.outWith("ctrl: {}  , shift: {}  , alt: {}    \n\n"   , .{ key.ctrl() , key.shift(), key.alt() });
        }

        inline fn condition ()
        !bool
        {
            return true;
        }

        inline fn run ()
        !void
        {
            try io.once (callback);                 // just one time.
            try io.on   (condition, callback);      // repeat until the condition is met.
        }
    };

    try example.run();
    ```

    _**RESULT**_

    > suppose i pressed `a` then `ctrl` `a` then `shift` `a` then `alt` `a` then `alt` `ctrl` `a` then `alt` `shift` `a` in order.

    ```ts
    code : 97        char  : 'a'      mod : "none"
    ctrl : false     shift : false    alt : false

    code : 1         char  : 'A'      mod : "ctrl"
    ctrl : true      shift : false    alt : false

    code : 65        char  : 'A'      mod : "shift"
    ctrl : false     shift : true     alt : false

    code : 97        char  : 'a'      mod : "alt"
    ctrl : false     shift : false    alt : true

    code : 1         char  : 'A'      mod : "alt + ctrl"
    ctrl : true      shift : false    alt : true

    code : 65        char  : 'A'      mod : "alt + shift"
    ctrl : false     shift : true     alt : true
    ```

---

- ## Installation 📦

    > You can use the library in two ways :

    - ### **Option 1: Single File Integration**

        - Download the [`io.lite.zig`](./dist/io.lite.zig) file.  
        - Add it to your project directory.  
        - Import it in your code:

        ```zig
        const io = @import("path/to/your/io.lite.zig");
        ```

    - ### **Option 2: Zig Dependency**

        1. Add the dependency to `build.zig.zon`:

            > **Replace** `_version` _with_ **last version**.

            > **Replace** `_hash` _with_ **hash provided by zig builder**.

            ```zig
            .dependencies = 
            .{
                .io = 
                .{
                    .url    = "https://github.com/Super-ZIG/io/archive/refs/tags/_version.tar.gz",
                    .hash   = "_hash"
                },
            };
            ```

        2. Modify your `build.zig` file:

            > Add the following after declaring the executable. 

            ```zig
            const io = b.dependency("io",
            .{
                .target     = target,
                .optimize   = optimize,
            });

            exe.root_module.addImport("io", io.module("io"));
            ```

        3. Import the library in your code:

            ```zig
            const io = @import("io");
            ```

- ## [Documentation 📚](./docs/readme.md)

    > For detailed information, visit the [`/docs`](./docs/readme.md) folder.

    ---

    - ### Support the Project ❤️

        > If you enjoy using **SuperZIG** and want to support its development, consider buying me a coffee or sending a small donation!
        
        > Your support helps me dedicate more time to improving this project and creating more amazing tools for the community :)

        - [Donate via **✨ PayPal**](https://www.paypal.me/MaysaraElshewehy)
          
          _OR_

        - [Buy me a coffee on **☕ Ko-fi**](https://ko-fi.com/codeguild)

        Thank you for your generosity and encouragement! 💖
    ---
    
    - ### Testing

        ```bash
        zig test test.zig     # run tests
        zig build try         # try examples
        ```

    - ### Contributing 🤝

        > Contributions are always welcome! Feel free to open issues, fork the repository, or submit pull requests.

        - Fork the project.
        - Create your feature branch.
        - Write tests and Testing.
        - Commit your changes.
        - Push to the branch.
        - Open a pull request.

    - ### Author 💻

        > If you encounter any problems or have any suggestions, please feel free to contact me at :

        - 📧 `Email` [maysara.elshewehy@gmail.com](mailto:mmaysara.elshewehy@gmail.com)  
        
        - 🌐 `GitHub` [github.com/maysara-elshewehy](https://github.com/maysara-elshewehy)  


    - ### License 📄

        This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

    - ##### TODO

        > .. ?

        - complete unit tests.
        - add custom writer with flush function.
        - more functions for terminal.
        - support files io.
        - . . . ?

    - ##### Related
        
        - [SuperZIG CLI](https://github.com/Super-ZIG/cli)

        - [SuperZIG ANSI](https://github.com/Super-ZIG/ansi)
      
---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).
