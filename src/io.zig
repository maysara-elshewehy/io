// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const       std                         = @import("std");
    const       builtin                     = @import("builtin");
    pub const   types                       = @import("./types/_.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ DATA ══════════════════════════════════════╗

    /// Global buffer for General purposes.
    var         g_buff_1024 : [1024]u8      = undefined;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ OUTPUT ═════════════════════════════════════╗

    /// Outputs a simple message followed by a newline.
    pub inline fn out
    ( comptime _msg: []const u8 ) 
    !void 
    {
        try outWith(_msg ++ "\n", .{});
    }

    /// Outputs a formatted message to the console.
    pub inline fn outWith
    ( comptime _fmt: []const u8, _args: anytype ) 
    !void 
    {
        try nosuspend std.io.getStdOut().writer().print(_fmt, _args);
    }

    /// Outputs a simple message followed by a newline to a specific writer.
    pub inline fn outWriter
    ( comptime _msg: []const u8, _writer: anytype ) 
    !void 
    {
        try _writer.print("{s}", .{_msg});
    }

    /// Outputs a formatted message followed by a newline to a specific writer.
    pub inline fn outWriterWith
    ( comptime _fmt: []const u8, _args: anytype, _writer: anytype ) 
    !void 
    {
        try _writer.print(_fmt, _args);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ INPUT ══════════════════════════════════════╗

    /// Reads input from the user until a newline character is encountered.
    pub inline fn in
    () 
    ![]const u8 
    {
        const l_res = try std.io.getStdIn().reader().readUntilDelimiterOrEof(&g_buff_1024, '\n');
        return l_res orelse unreachable;
    }

    /// Reads input from the user until a newline character is encountered using custom buffer.
    pub inline fn inBuff
    ( _buff: []u8 )
    !void
    {
        // set zeros (maybe set all buffer to zeros using std ?)
        for (_buff) |*l_byte|
        {
            l_byte.* = 0;
        }

        _ = try std.io.getStdIn().reader().readUntilDelimiterOrEof(_buff, '\n');
    }

    /// Displays a message and waits for the user to respond.
    pub inline fn ask
    ( comptime _msg: []const u8 ) 
    ![]const u8 
    {
        try         out (_msg);
        return try  in  ();
    }

    /// Displays a message and waits for the user to respond using custom buffer.
    pub inline fn askBuff
    ( comptime _msg: []const u8, _buff: []u8 ) 
    !void
    {
        try out     (_msg);
        try inBuff  (_buff);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔════════════════════════════════════ EVENTS ══════════════════════════════════════╗

    /// Listens for key input.
    pub inline fn once
    ( _call: anytype ) 
    !void 
    {
        if (builtin.os.tag == .windows) 
        {
            return @import("./func/on/windows.zig").once(_call);
        } 

        else if (builtin.os.tag == .linux) 
        {
            return @import("./func/on/linux.zig").once(_call);
        } 
        
        else 
        {
            try outWith("OS not supported : {}\n", .{builtin.os.tag});
            unreachable;
        }
    }

    /// Listens for key input until the condition is met.
    pub inline fn on
    ( _cond: anytype, _call: anytype ) 
    !void 
    {
        if (builtin.os.tag == .windows) 
        {
            return @import("./func/on/windows.zig").on(_cond, _call);
        } 

        else if (builtin.os.tag == .linux) 
        {
            return @import("./func/on/linux.zig").on(_cond, _call);
        } 

        else 
        {
            try outWith("OS not supported : {}\n", .{builtin.os.tag});
            unreachable;
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MORE ══════════════════════════════════════╗

    /// Clears the terminal(Screen).
    pub inline fn cls
    () 
    !void 
    {
        _ = try out("\x1b[2J\x1b[H");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
