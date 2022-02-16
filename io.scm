(define-module (io)
  #:use-module (sdl2)
  #:use-module (sdl2 mixer))

(define (init)
  (sdl-init)
  (open-audio #:frequency 96000))

(init)

(define music (load-music "/home/sbv/Music/chill.mp3"))

(set-music-volume! 16)

(play-music! music)
