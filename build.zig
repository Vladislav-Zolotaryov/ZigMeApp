// This tells the buildpack which version to install
// zig-release: zig-linux-x86_64-0.7.0+0bc9fd5e8.tar.xz
//
const std = @import("std");
const Builder = std.build.Builder;


pub fn build(b: *Builder) void {
    const exe = b.addExecutable("zhttpd", "main.zig");

    exe.setBuildMode(.ReleaseSafe);
    exe.addPackagePath("zhp", "zig-packages/zhp-0.9.0/src/zhp.zig");
    const run_cmd = exe.run();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}