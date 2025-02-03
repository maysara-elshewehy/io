// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const Unicode = @import("../../utils/Unicode/Unicode.zig");
    const Bytes = @import("../../utils/Bytes/Bytes.zig");
    const Allocator = std.mem.Allocator;
    pub const AllocatorError = Allocator.Error;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Immutable fixed-size string type that supports Unicode.
    pub const Viewer = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The unicode encoded bytes to be viewed.
            m_source: []const u8 = &.{},

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new `Viewer` instance with the given unicode bytes.
            pub fn init(value: []const u8) Self {
                if(value.len == 0) return Self { };
                return Self{ .m_source = value[0..Bytes.countWritten(value)] };
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the `position` of the **first** occurrence of `target`.
            pub fn find(self: Self, target: []const u8) ?usize {
                return Bytes.find(self.slice(), target);
            }

            /// Finds the `visual position` of the **first** occurrence of `target`.
            pub fn findVisual(self: Self, target: []const u8) ?usize {
                return Bytes.findVisual(self.slice(), target);
            }

            /// Finds the `position` of the **last** occurrence of `target`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return Bytes.rfind(self.slice(), target);
            }

            /// Finds the `visual position` of the **last** occurrence of `target`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return Bytes.rfindVisual(self.slice(), target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return Bytes.includes(self.slice(), target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return Bytes.startsWith(self.slice(), target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return Bytes.endsWith(self.slice(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Count ───────────────────────────┐

            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn length(self: Self) usize {
                return self.m_source.len;
            }

            /// Returns the total number of visual characters.
            pub fn vlength(self: Self) usize {
                return if(self.m_source.len == 0) 0 else Bytes.countVisual(self.m_source[0..]) catch unreachable;
            }

            /// Returns a slice containing only the written part.
            pub fn slice(self: Self) []const u8 {
                return if(self.m_source.len == 0) "" else self.m_source[0..];
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the unicode bytes.
            /// - `Unicode.Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) Unicode.Iterator.Error!Unicode.Iterator {
                return Unicode.Iterator.init(self.slice());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Split ───────────────────────────┐

            /// Splits the written portion of the string into substrings separated by the delimiter,
            /// returning the substring at the specified index.
            pub fn split(self: Self, delimiters: []const u8, index: usize) ?[]const u8 {
                return Bytes.split(self.slice(), self.length(), delimiters, index);
            }

            /// Splits the written portion of the string into all substrings separated by the delimiter,
            /// returning an array of slices. Caller must free the returned memory.
            /// `include_empty` controls whether empty strings are included in the result.
            pub fn splitAll(self: Self, allocator: Allocator, delimiters: []const u8, include_empty: bool) AllocatorError![]const []const u8 {
                return Bytes.splitAll(allocator, self.slice(), self.length(), delimiters, include_empty);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a copy of the `Viewer` instance.
            pub fn clone(self: Self) Self {
                return .{ .m_source = self.m_source };
            }

            /// Returns true if the `Viewer` instance equals the given `target`.
            pub fn equals(self: Self, target: []const u8) bool {
                return Bytes.equals(self.slice(), target);
            }

            /// Returns true if the `Viewer` instance is empty.
            pub fn isEmpty(self: Self) bool {
                return Bytes.isEmpty(self.slice());
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝