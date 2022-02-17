const scm = @cImport(@cInclude("libguile.h"));
const std = @import("std");

pub var guile: [*c]const u8 = @embedFile("io.scm");

fn fibonacci(x: u32) u32 {
    var a: u32 = 0;
    var b: u32 = 1;
    var c: u32 = 0;
    while (c != x) {
        b += a;
        a = b - a;
        c += 1;
    }
    return a;
}

fn foo () void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

fn c_foo() callconv(.C) scm.SCM {
    foo();
    return scm.SCM_BOOL_F;
}

fn c_fib(n: scm.SCM) callconv(.C) scm.SCM {
    return scm.scm_from_unsigned_integer(@as(c_uint, fibonacci(@as(u32, scm.scm_to_uint(n)))));
}

pub fn inner_main(arg_data: ?*anyopaque, arg_argc: c_int, arg_argv: [*c][*c]u8) callconv(.C) void {
    var c_foo_var = @intToPtr(?*anyopaque, @ptrToInt(c_foo));
    var c_fib_var = @intToPtr(?*anyopaque, @ptrToInt(c_fib));
    _ = scm.scm_c_define_gsubr("foo", 0, 0, 0, c_foo_var);
    _ = scm.scm_c_define_gsubr("fib", 1, 1, 0, c_fib_var);
    _ = arg_data;
    _ = scm.scm_eval_string(scm.scm_from_locale_string(guile));
    _ = scm.scm_shell(arg_argc, arg_argv);
}

pub export fn main(arg_argc: c_int, arg_argv: [*c][*c]u8) c_int {
    _ = scm.scm_boot_guile(arg_argc, arg_argv, inner_main, null);
    return 0;
}
