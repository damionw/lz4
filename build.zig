const std = @import("std");

pub fn build(b: *std.Build) void {
    const entry = b.path("src/lib.zig");
    // Expose to zig dependents
    const lib = b.addModule("lz4", .{ .root_source_file = entry });
    _ = lib;

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Run unit tests");
    const run_tests = b.addRunArtifact(b.addTest(.{
        .root_source_file = entry,
        .target = target,
        .optimize = optimize,
    }));
    test_step.dependOn(&run_tests.step);
}
