const std = @import("std");

pub fn main() !void {
    var sum: u64 = 0;
    var i: u32 = 0;
    while (i < 1000) : (i += 1) {
        if (i % 3 == 0 or i % 5 == 0) sum += i;
    }
    try std.io.getStdOut().writer().print("{}\n", .{sum});
}