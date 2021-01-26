const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = &gpa.allocator;

    var known_primes = try std.ArrayList(u64).initCapacity(allocator, 2);
    defer known_primes.deinit();
    known_primes.appendSliceAssumeCapacity(&[_]u64{ 2, 3 });

    var prime_factors = std.ArrayList(u64).init(allocator);
    defer prime_factors.deinit();

    var n: u64 = 600851475143;
    var i: usize = 0;
    while (n > 1)
        n = while (i < known_primes.items.len) : (i += 1) {
            // if known primes exhausted, find next prime
            if (i == known_primes.items.len - 1) {
                var prime_attempt = known_primes.items[known_primes.items.len - 1] + 2;
                while (!for (known_primes.items) |prime| {
                    if (prime_attempt % prime == 0) break false;
                } else true) prime_attempt += 2;
                try known_primes.append(prime_attempt);
            }
            // store found prime factor, continue otherwise
            const tmp = std.math.divExact(u64, n, known_primes.items[i]) catch {
                continue;
            };
            try prime_factors.append(known_primes.items[i]);
            break tmp;
        } else unreachable;

    try std.io.getStdOut().writer().print(
        "factors: {}\nlargest: {}\n",
        .{ prime_factors.items, std.mem.max(u64, prime_factors.items) },
    );
}
