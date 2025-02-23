// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std = @import("std");
    const StringModule = @import("../../string/string.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Represents an event in the terminal.
    pub const Event = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// -
            key : Key = .{},

            /// -
            mouse : Mouse = .{},

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐


        // └──────────────────────────────────────────────────────────────┘

    };

    /// Represents a key event in the terminal.
    pub const Key = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            m_read      : []const u8 = undefined,   // full sequence.
            m_key       : [4]u8 = [_]u8{0} ** 4,    // UTF-8 character can be up to 4 bytes.
            m_mask      : u32 = 0,                  // Bitmask for non(Alphabeti/Numeric) keys.

            pub const Bitmask = struct {
                // modifier keys
                pub const Alt   : u32 = 1 << 0;
                pub const Ctrl  : u32 = 1 << 1;
                pub const Shift : u32 = 1 << 2;

                // arrow keys
                pub const Up    : u32 = 1 << 3;
                pub const Down  : u32 = 1 << 4;
                pub const Right : u32 = 1 << 5;
                pub const Left  : u32 = 1 << 6;

                // function keys
                pub const F1    : u32 = 1 << 7;
                pub const F2    : u32 = 1 << 8;
                pub const F3    : u32 = 1 << 9;
                pub const F4    : u32 = 1 << 10;
                pub const F5    : u32 = 1 << 11;
                pub const F6    : u32 = 1 << 12;
                pub const F7    : u32 = 1 << 13;
                pub const F8    : u32 = 1 << 14;
                pub const F9    : u32 = 1 << 15;
                pub const F10   : u32 = 1 << 16;
                pub const F11   : u32 = 1 << 17;
                pub const F12   : u32 = 1 << 18;

                // special keys
                pub const Home      : u32 = 1 << 19;
                pub const End       : u32 = 1 << 20;
                pub const PageUp    : u32 = 1 << 21;
                pub const PageDown  : u32 = 1 << 22;
                pub const Insert    : u32 = 1 << 23;
                pub const Delete    : u32 = 1 << 24;
                pub const Enter     : u32 = 1 << 25;
                pub const Escape    : u32 = 1 << 26;
                pub const Tab       : u32 = 1 << 27;
                pub const Backspace : u32 = 1 << 28;
                pub const Space     : u32 = 1 << 29;

                // Unknown key
                pub const Unknown   : u32 = 1 << 30;
            };

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Prints the key to the provided writer.
            pub fn printTo(self: Key, writer: anytype) !void {
                var allocator = std.heap.page_allocator;
                // We use an ArrayList to concatenate the string parts
                var parts = std.ArrayList([]const u8).init(allocator);
                defer parts.deinit();

                // Add modifier names if they exist
                if (self.isCtrl()) try parts.append("Ctrl");
                if (self.isShift()) try parts.append("Shift");
                if (self.isAlt())  try parts.append("Alt");

                // Determine the name of the main key
                var keyStr: []const u8 = "";
                if (self.isArrow()) {
                    if (self.isUp())                keyStr = "Up"
                    else if (self.isDown())         keyStr = "Down"
                    else if (self.isLeft())         keyStr = "Left"
                    else if (self.isRight())        keyStr = "Right";
                } else if (self.isFunction()) {
                    if (self.isF1())                keyStr = "F1"
                    else if (self.isF2())           keyStr = "F2"
                    else if (self.isF3())           keyStr = "F3"
                    else if (self.isF4())           keyStr = "F4"
                    else if (self.isF5())           keyStr = "F5"
                    else if (self.isF6())           keyStr = "F6"
                    else if (self.isF7())           keyStr = "F7"
                    else if (self.isF8())           keyStr = "F8"
                    else if (self.isF9())           keyStr = "F9"
                    else if (self.isF10())          keyStr = "F10"
                    else if (self.isF11())          keyStr = "F11"
                    else if (self.isF12())          keyStr = "F12";
                } else if (self.isSpecial()) {
                    if (self.isEnter())             keyStr = "Enter"
                    else if (self.isEscape())       keyStr = "Escape"
                    else if (self.isTab())          keyStr = "Tab"
                    else if (self.isBackspace())    keyStr = "Backspace"
                    else if (self.isSpace())        keyStr = "Space"
                    else if (self.isHome())         keyStr = "Home"
                    else if (self.isEnd())          keyStr = "End"
                    else if (self.isPageUp())       keyStr = "Page Up"
                    else if (self.isPageDown())     keyStr = "Page Down"
                    else if (self.isInsert())       keyStr = "Insert"
                    else if (self.isDelete())       keyStr = "Delete"
                    else                            keyStr = "Special";
                }
                else {
                    keyStr = StringModule.utils.chars.writtenSlice(u8, &self.m_key);
                }

                try parts.append(keyStr);

                // Join the parts using " + " as separators, like "Ctrl + Alt + A"
                const joined = try std.mem.join(allocator, " + ", try parts.toOwnedSlice());
                defer allocator.free(joined);
                try writer.print("{s}", .{joined});
            }

            /// Prints the key to the standard output.
            pub fn print(self: Key) !void {
                try self.printTo(std.io.getStdOut().writer());
            }

            /// Prints the key to the standard output with a newline.
            pub fn printWithNewline(self: Key) !void {
                try self.print();
                try std.io.getStdOut().writer().writeByte('\n');
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Checks ───────────────────────────┐

            /// Checks if the key is alphabetic.
            pub fn isAlphabetic(self: Key) bool {
                if(self.m_key.len == 0) return false;
                const c = self.m_key[0];
                return (c >= 'A' and c <= 'Z') or (c >= 'a' and c <= 'z');
            }

            /// Checks if the key is numeric.
            pub fn isNumeric(self: Key) bool {
                if(self.m_key.len == 0) return false;
                const c = self.m_key[0];
                return (c >= '0' and c <= '9');
            }

            /// Checks if the Shift key is pressed.
            pub fn isShift(self: Key) bool {
                return (self.m_mask & Bitmask.Shift) != 0;
            }

            /// Checks if the Alt key is pressed.
            pub fn isAlt(self: Key) bool {
                return (self.m_mask & Bitmask.Alt) != 0;
            }

            /// Checks if both Alt and Shift keys are pressed.
            pub fn isAltShift(self: Key) bool {
                return (self.m_mask & (Bitmask.Alt | Bitmask.Shift)) != 0;
            }

            /// Checks if both Alt and Ctrl keys are pressed.
            pub fn isAltCtrl(self: Key) bool {
                return (self.m_mask & (Bitmask.Alt | Bitmask.Ctrl)) != 0;
            }

            /// Checks if the Ctrl key is pressed.
            pub fn isCtrl(self: Key) bool {
                return (self.m_mask & Bitmask.Ctrl) != 0;
            }

            /// Checks if both Ctrl and Shift keys are pressed.
            pub fn isCtrlShift(self: Key) bool {
                return (self.m_mask & (Bitmask.Ctrl | Bitmask.Shift)) != 0;
            }

            /// Checks if Ctrl, Alt, and Shift keys are pressed.
            pub fn isCtrlAltShift(self: Key) bool {
                return (self.m_mask & (Bitmask.Ctrl | Bitmask.Alt | Bitmask.Shift)) != 0;
            }

            /// Checks if any modifier key (Ctrl, Alt, Shift) is pressed.
            pub fn isModifier(self: Key) bool {
                return self.isAlt() or self.isCtrl() or self.isShift();
            }

            /// Checks if any arrow key is pressed.
            pub fn isArrow(self: Key) bool {
                return self.isUp() or self.isDown() or self.isLeft() or self.isRight();
            }

            /// Checks if the Up arrow key is pressed.
            pub fn isUp(self: Key) bool {
                return (self.m_mask & Bitmask.Up) != 0;
            }

            /// Checks if the Down arrow key is pressed.
            pub fn isDown(self: Key) bool {
                return (self.m_mask & Bitmask.Down) != 0;
            }

            /// Checks if the Left arrow key is pressed.
            pub fn isLeft(self: Key) bool {
                return (self.m_mask & Bitmask.Left) != 0;
            }

            /// Checks if the Right arrow key is pressed.
            pub fn isRight(self: Key) bool {
                return (self.m_mask & Bitmask.Right) != 0;
            }
            /// Checks if any function key (F1-F12) is pressed.
            pub fn isFunction(self: Key) bool {
                return self.isF1() or self.isF2()  or self.isF3()  or self.isF4() or
                       self.isF5() or self.isF6()  or self.isF7()  or self.isF8() or
                       self.isF9() or self.isF10() or self.isF11() or self.isF12();
            }

            /// Checks if the F1 key is pressed.
            pub fn isF1(self: Key) bool {
                return (self.m_mask & Bitmask.F1) != 0;
            }

            /// Checks if the F2 key is pressed.
            pub fn isF2(self: Key) bool {
                return (self.m_mask & Bitmask.F2) != 0;
            }

            /// Checks if the F3 key is pressed.
            pub fn isF3(self: Key) bool {
                return (self.m_mask & Bitmask.F3) != 0;
            }

            /// Checks if the F4 key is pressed.
            pub fn isF4(self: Key) bool {
                return (self.m_mask & Bitmask.F4) != 0;
            }

            /// Checks if the F5 key is pressed.
            pub fn isF5(self: Key) bool {
                return (self.m_mask & Bitmask.F5) != 0;
            }

            /// Checks if the F6 key is pressed.
            pub fn isF6(self: Key) bool {
                return (self.m_mask & Bitmask.F6) != 0;
            }

            /// Checks if the F7 key is pressed.
            pub fn isF7(self: Key) bool {
                return (self.m_mask & Bitmask.F7) != 0;
            }

            /// Checks if the F8 key is pressed.
            pub fn isF8(self: Key) bool {
                return (self.m_mask & Bitmask.F8) != 0;
            }

            /// Checks if the F9 key is pressed.
            pub fn isF9(self: Key) bool {
                return (self.m_mask & Bitmask.F9) != 0;
            }

            /// Checks if the F10 key is pressed.
            pub fn isF10(self: Key) bool {
                return (self.m_mask & Bitmask.F10) != 0;
            }

            /// Checks if the F11 key is pressed.
            pub fn isF11(self: Key) bool {
                return (self.m_mask & Bitmask.F11) != 0;
            }

            /// Checks if the F12 key is pressed.
            pub fn isF12(self: Key) bool {
                return (self.m_mask & Bitmask.F12) != 0;
            }

            /// Checks if any special key (Enter, Tab, etc.) is pressed.
            pub fn isSpecial(self: Key) bool {
                return self.isEnter()   or self.isTab()     or self.isHome()    or self.isEnd() or
                       self.isEscape()  or self.isDelete()  or self.isSpace()   or self.isBackspace() or
                       self.isInsert()  or self.isPageUp()  or self.isPageDown();
            }

            /// Checks if the Home key is pressed.
            pub fn isHome(self: Key) bool {
                return (self.m_mask & Bitmask.Home) != 0;
            }

            /// Checks if the End key is pressed.
            pub fn isEnd(self: Key) bool {
                return (self.m_mask & Bitmask.End) != 0;
            }

            /// Checks if the Page Up key is pressed.
            pub fn isPageUp(self: Key) bool {
                return (self.m_mask & Bitmask.PageUp) != 0;
            }

            /// Checks if the Page Down key is pressed.
            pub fn isPageDown(self: Key) bool {
                return (self.m_mask & Bitmask.PageDown) != 0;
            }

            /// Checks if the Insert key is pressed.
            pub fn isInsert(self: Key) bool {
                return (self.m_mask & Bitmask.Insert) != 0;
            }

            /// Checks if the Delete key is pressed.
            pub fn isDelete(self: Key) bool {
                return (self.m_mask & Bitmask.Delete) != 0;
            }

            /// Checks if the Enter key is pressed.
            pub fn isEnter(self: Key) bool {
                return (self.m_mask & Bitmask.Enter) != 0;
            }

            /// Checks if the Escape key is pressed.
            pub fn isEscape(self: Key) bool {
                return (self.m_mask & Bitmask.Escape) != 0;
            }

            /// Checks if the Tab key is pressed.
            pub fn isTab(self: Key) bool {
                return (self.m_mask & Bitmask.Tab) != 0;
            }

            /// Checks if the Backspace key is pressed.
            pub fn isBackspace(self: Key) bool {
                return (self.m_mask & Bitmask.Backspace) != 0;
            }

            /// Checks if the Space key is pressed.
            pub fn isSpace(self: Key) bool {
                return (self.m_mask & Bitmask.Space) != 0;
            }

        // └──────────────────────────────────────────────────────────────┘

    };

    /// Represents a mouse event in the terminal.
    pub const Mouse = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐


        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐


        // └──────────────────────────────────────────────────────────────┘

    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝