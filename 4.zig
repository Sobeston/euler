const std = @import("std");

pub fn main() !void {
    var largest_found: u32 = 0;
    var fmt_buf: [7]u8 = undefined;

    var i: u32 = 100;
    while (i < 1000) : (i += 1) {
        var j: u32 = 100;
        while (j < 1000) : (j += 1) {
            const str = std.fmt.bufPrint(&fmt_buf, "{}", .{i * j}) catch unreachable;
            var start: u8 = 0;
            var end: u8 = @intCast(u8, str.len)  - 1;

            const is_palindrome = while (start < end) : ({start += 1; end -= 1;}) {
                if (str[start] != str[end]) break false;
            } else true;

            if (is_palindrome and i * j > largest_found) largest_found = i * j;
        }
    }

    try std.io.getStdOut().writer().print("{}\n", .{largest_found});
}