
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(setq load-path (append load-path '("/Users/evand/lisp")))

; All the real initialization happens in these files
(load "common-init")
(load "unix-init")
