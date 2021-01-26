const std = @import("std");

pub fn main() !void {
    var sum: u64 = 0;

    var a: u32 = 1;
    var b: u32 = 2;
    while (a < 4_000_000) {
        if (a % 2 == 0) sum += a;
        const a_b = a + b;
        a = b;
        b = a_b;
    }

    try std.io.getStdOut().writer().print("{}\n", .{sum});
}