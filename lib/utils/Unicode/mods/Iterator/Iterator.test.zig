// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const mem = std.mem;
    const Iterator = @import("./Iterator.zig").Iterator;

    const expect = std.testing.expect;
    const expectEqual = std.testing.expectEqual;
    const expectError = std.testing.expectError;
    const expectStrings = std.testing.expectEqualStrings;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    fn testCodepointIterator() !void {
        var it1 = try Iterator.init("Hello 🌍");
        try expect(mem.eql(u8, "H", it1.nextSlice().?));
        try expect(mem.eql(u8, "e", it1.nextSlice().?));
        try expect(mem.eql(u8, "l", it1.nextSlice().?));
        try expect(mem.eql(u8, "l", it1.nextSlice().?));
        try expect(mem.eql(u8, "o", it1.nextSlice().?));
        try expect(mem.eql(u8, " ", it1.nextSlice().?));
        try expect(mem.eql(u8, "🌍", it1.nextSlice().?));
        try expect(it1.nextSlice() == null);

        // next
        var it2 = try Iterator.init("Hello 🌍");
        try expect(it2.next().? == 'H');
        try expect(it2.next().? == 'e');
        try expect(it2.next().? == 'l');
        try expect(it2.next().? == 'l');
        try expect(it2.next().? == 'o');
        try expect(it2.next().? == ' ');
        try expect(it2.next().? == '🌍');
        try expect(it2.next() == null);

        // peek
        var it3 = try Iterator.init("Hello 🌍");
        try expectStrings("He", it3.peek(2).?);
    }

    fn testGraphemeClusterIterator() !void {
        @setEvalBranchQuota(2000);

        // nextSlice
        var it1 = try Iterator.init("👨‍🏭مرحبا");
        try expect(mem.eql(u8, "👨‍🏭", it1.nextGraphemeCluster().?));
        try expect(mem.eql(u8, "م",  it1.nextGraphemeCluster().?));
        try expect(mem.eql(u8, "ر",  it1.nextGraphemeCluster().?));
        try expect(mem.eql(u8, "ح",  it1.nextGraphemeCluster().?));
        try expect(mem.eql(u8, "ب",  it1.nextGraphemeCluster().?));
        try expect(mem.eql(u8, "ا",  it1.nextGraphemeCluster().?));
        try expect(it1.nextGraphemeCluster() == null);

        // TODO: improve (next and peek) functions to use specific mode like (graphemeCluster) not just (codepoint).

        // next
        var it2 = try Iterator.init("👨‍🏭مرحبا");
        _ = it2.next().?; // "👨‍🏭"[0..4][0]
        _ = it2.next().?; // "👨‍🏭"[4..7][0]
        _ = it2.next().?; // "👨‍🏭"[7..11][0]
        try expect(it2.next().? == 'م');
        try expect(it2.next().? == 'ر');
        try expect(it2.next().? == 'ح');
        try expect(it2.next().? == 'ب');
        try expect(it2.next().? == 'ا');
        try expect(it2.next() == null);

        // peek
        var it3 = try Iterator.init("👨‍🏭مرحبا");
        try expectStrings("👨‍🏭", it3.peek(3).?);
    }

    test "Iterator" {
        try comptime testCodepointIterator();
        try testCodepointIterator();

        try comptime testGraphemeClusterIterator();
        try testGraphemeClusterIterator();
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝