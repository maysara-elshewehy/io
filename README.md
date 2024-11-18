# **SuperZIG IO**  

A lightweight and easy-to-use solution for terminal input and output operations, featuring inline functions for quick integration.  

- ## **Why ?**  

    - **Lightweight:** Focused on simplicity and efficiency.  

    - **Convenient Functions:** Handles common terminal I/O tasks with minimal code.

    - **Format Support:** Easily print formatted messages.  

> Enjoy writing cleaner, faster Zig programs with **SuperZIG IO** 🔥❤️ !  

---

## **Overview**  

Here’s a quick example to get started:  

```zig
const io = @import("io");

pub fn main() !void {
    io.out("Hi:");                                          // Print a message

    const name = io.ask("> What is your name? ");           // Prompt and read user input

    io.outFMT("> Nice to meet you, Mr.{s}!\n", .{name});    // Print formatted message

    io.out("Bye.");                                         // Print another message
}
```

**Expected Output:**  

```bash
Hi:                                                         # Using io.out
> What is your name?                                        # Using io.ask/io.out
Maysara                                                     # Using io.ask/io.get
> Nice to meet you, Mr.Maysara!                             # Using io.outFMT
Bye.                                                        # Using io.out
```

---

## **Functions**  

- **`out`**

  Prints a message to the terminal.
  ```zig
  pub inline fn out(comptime _msg: []const u8) void
  ```

- **`outFMT`**  
  Prints a formatted message with arguments.
  ```zig
  pub inline fn outFMT(comptime _fmt: []const u8, _args: anytype) void
  ```

- **`get`**  
  Reads input from the terminal without printing a prompt.
  ```zig
  pub inline fn get () []const u8
  ```

- **`ask`**  
  Prints a message and waits for user input.
  ```zig
  pub inline fn ask(comptime _msg: []const u8) []const u8
  ```

- **`eql`**  
  Compares two arrays of a specific type and returns a boolean.
  ```zig
  pub inline fn eql (_type: type, _one: []const u8, _two: []const u8) bool
  ```

---

## **Installation**  

To use **SuperZIG IO** in your project, follow these steps:  

### 1. Add the dependency to `build.zig.zon`  

```zig
.dependencies = .{
    .io = .{
        .url = "https://github.com/Super-ZIG/io/archive/refs/tags/0.0.0.tar.gz",
        // Replace with the correct hash (provided by Zig after the first build).
    },
};
```

### 2. Modify your `build.zig` file  

Add the following **after** declaring the executable:  

```zig
const io = b.dependency("io", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("io", io.module("io"));
```

### 3. Import the library in your Zig code  

```zig
const io = @import("io");
```

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).