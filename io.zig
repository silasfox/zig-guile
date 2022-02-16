const scm = @cImport(@cInclude("libguile.h"));

pub var guile: [*c]const u8 = "(define-module (io)  #:use-module (sdl2)  #:use-module (sdl2 mixer))(define (init)  (sdl-init)  (open-audio #:frequency 96000))(init)(define music (load-music \"/home/sbv/Music/chill.mp3\"))(set-music-volume! 16)(play-music! music)";

pub fn inner_main(arg_data: ?*anyopaque, arg_argc: c_int, arg_argv: [*c][*c]u8) callconv(.C) void {
    _ = arg_data;
    _ = scm.scm_eval_string(scm.scm_from_locale_string(guile));
    _ = scm.scm_shell(arg_argc, arg_argv);
}
pub export fn main(arg_argc: c_int, arg_argv: [*c][*c]u8) c_int {
    _ = scm.scm_boot_guile(arg_argc, arg_argv, inner_main, null);
    return 0;
}

