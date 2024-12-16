const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

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
    var total_dist: i32 = 0;
    for (list_a, list_b) |a, b| {
        if (a > b) {
            total_dist += a - b;
        } else {
            total_dist += b - a;
        }
    }
    print("total_dist: {d}\n", .{total_dist});
}
