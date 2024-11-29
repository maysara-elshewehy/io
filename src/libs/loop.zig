// This is a min version of https://github.com/Super-ZIG/loop library.
// I created this file to use this library without the need to install it via Zig. 
// Simply drag this single file into your project and import it.
//
// Made with ❤️ by Maysara.
//
// Email    : Maysara.Elshewehy@gmail.com
// GitHub   : https://github.com/maysara-elshewehy


pub inline fn untilWith ( _cond: anytype, _call: anytype, _args: anytype ) !void {
    while (true) {
        try @call(.auto, _call, _args);
        if (!try _cond()) break; } }