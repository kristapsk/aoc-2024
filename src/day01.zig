const std = @import("std");

const data = @embedFile("data/day01.txt");

const print = std.debug.print;

const parseInt = std.fmt.parseInt;

const asc = std.sort.asc;

const sort = std.mem.sort;
const tokenizeAny = std.mem.tokenizeAny;

pub fn main() !void {
    @setEvalBranchQuota(1_000_000);
    const nlines = comptime std.mem.count(u8, data, "\n") ;
    var list_a: [nlines]i32 = undefined;
    var list_b: [nlines]i32 = undefined;
    var flines = tokenizeAny(u8, data, "\n");
    var i: u32 = 0;
    while (flines.next()) |line| {
        var lparts = tokenizeAny(u8, line, " ");
        list_a[i] = try parseInt(i32, lparts.next().?, 10);
        list_b[i] = try parseInt(i32, lparts.next().?, 10);
        i += 1;
    }
    sort(i32, &list_a, {}, comptime asc(i32));
    sort(i32, &list_b, {}, comptime asc(i32));
    var total_dist: u32 = 0;
    for (list_a, list_b) |a, b| {
        total_dist += @abs(a - b);
    }
    print("total_dist: {d}\n", .{total_dist});
    var similarity_score: i32 = 0;
    for (list_a) |a| {
        var num_a_in_b: i32 = 0;
        for (list_b) |b| {
            if (a == b) {
                num_a_in_b += 1;
            }
            else if (a < b) {
                break;  // since the lists are sorted, we can break early
            }
        }
        similarity_score += a * num_a_in_b;
    }
    print("similarity_score: {d}\n", .{similarity_score});
}
