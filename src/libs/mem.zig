// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub inline fn eql
    ( _type: type, _one: []const _type, _two: []const _type )
    bool
    {
        if (_one.len - 1 != _two.len) {
            return false;
        }

        for (0.._one.len - 1) |i| {
            if (_one[i] != _two[i]) {
                return false;
            }
        }

        return true;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
