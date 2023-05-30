const std = @import("std");
const web = @import("zhp");


var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub const io_mode = .evented;

const MainHandler = struct {
    pub fn get(_: *MainHandler, _: *web.Request,
               response: *web.Response) !void {
        try response.headers.append("Content-Type", "text/plain");
        try response.stream.writeAll("Hello, World!");
    }
};

pub const routes = [_]web.Route{
    web.Route.create("hello", "/hello", MainHandler),
};


pub fn main() !void {
    defer std.debug.assert(!gpa.deinit());
    const allocator = &gpa.allocator;

    var app = web.Application.init(allocator, .{.debug=true});

    defer app.deinit();
    try app.listen("0.0.0.0", 5000);
    try app.start();
}