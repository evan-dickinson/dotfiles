; Have to tell emacs to look for macports' files.
; Don't have to tell xemacs, because it gets run from inside
; a shell.
(setq exec-path
      (append '("/opt/local/bin" "/opt/local/sbin") exec-path))

(setq load-path (append load-path '("/Users/evand/lisp")))

; All the real initialization happens in these files
(load "common-init")
(load "unix-init")
