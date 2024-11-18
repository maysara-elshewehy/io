// ═══════════════════════════════════════ LOAD ═══════════════════════════════════════  //

    const std = @import("std");

// ════════════════════════════════════════════════════════════════════════════════════  //



// ═══════════════════════════════════════ DATA ═══════════════════════════════════════  //

    var GLOB_BUFF : [1024]u8 = undefined;

// ════════════════════════════════════════════════════════════════════════════════════  //



// ═══════════════════════════════════════ CORE ═══════════════════════════════════════  //
    
    pub inline fn outFMT    (comptime _fmt: []const u8, _args: anytype)             void
    {
        nosuspend std.io.getStdOut().writer().print(_fmt, _args) catch return;
    }

    pub inline fn out       (comptime _msg: []const u8)                             void
    {
        outFMT(_msg ++ "\n", .{});
    }

    pub inline fn get       ()                                                      []const u8
    {
        const result = std.io.getStdIn().reader().readUntilDelimiterOrEof(&GLOB_BUFF, '\n') catch unreachable;
        return result orelse unreachable;
    }

    pub inline fn ask       (comptime _msg: []const u8)                             []const u8
    {
        out(_msg);
        return get();
    }

    pub inline fn eql       (_type: type, _one: []const _type, _two: []const _type)       bool
    {
        if(_one.len-1 != _two.len)
        {
            return false;
        }

        for (0.._one.len-1) |i|
        {
            if (_one[i] != _two[i])
            {
                return false;
            }
        }

        return true;
    }

// ════════════════════════════════════════════════════════════════════════════════════  //