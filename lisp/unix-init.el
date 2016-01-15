; $Header: /login/evand/lisp/RCS/unix-init.el,v 1.5 2007/09/12 20:55:28 evand Exp $
; 
; xemacs initializations that are specific to unix & linux


; This is the only way I could figure out to make global-set-key
; scroll a custom number of lines.  It won't take a lambda as
; its argument.
(defvar mwheel-scroll-lines 6 "Number of lines to scroll when turning the mouse wheel")

(defun mwheel-scroll-up ()
  "Scroll up with the mouse wheel"
  (interactive)  
  ; different versions of emacs have different functions to scroll.
  (let* ( (scroll-fxn   (cond 
                         ((functionp 'scroll-up-command) 'scroll-up-command)
                         ((functionp 'scroll-up)         'scroll-up)
                         )
                        ) )
    (funcall scroll-fxn mwheel-scroll-lines)
   )
)
(defun mwheel-scroll-down ()
  "Scroll down with the mouse wheel"
  (interactive)  
  ; different versions of emacs have different functions to scroll.
  (let* ( (scroll-fxn   (cond 
                         ((functionp 'scroll-down-command) 'scroll-down-command)
                         ((functionp 'scroll-down)         'scroll-down)
                         )
                        ) )
    (funcall scroll-fxn mwheel-scroll-lines)
   )
)

(global-set-key [button3] 'popup-buffer-menu) ; button 3 is the right button.
; Make the mouse wheel work
(global-set-key [button5] 'mwheel-scroll-up)
(global-set-key [button4] 'mwheel-scroll-down)


(setq auto-mode-alist
      (append
       '(("\\.pm4$"   .  c-mode)
	 ; Edit Menutree files
	 ("[uU][iI].*\\.def\\'" . menutree-mode)
         ; Edit GPIB grammar files
         (".gg$"     . gpib-def-mode)
	 ) auto-mode-alist))


;(load "route66")
;(load "gid") ;Load gid.el (the extension isn't needed).
;(load "tags")
;(load "gdb-front-end")

(load "yow")

;(load "plist")
;(load "todo-mode")
;(load "quickpeek")
;(load "qp-c")
;(load "qp-elisp")
;(load "menutree")
;(require 'menutree-mode)
;(load "gpib-def")
;(require 'gpib-def-mode)

; support clearcase
;(load "clearcase")

;(load "next-error")

;
; Printing stuff
; Copied enscript parameters from Craig Nelson
;(setq lpr-command "enscript")
; The tekadm6... part was added for use under Linux.
; I hope it also works under Solaris
;(setq lpr-switches '("-G2r" "-Pq391nwd@tekadm6.cse.tek.com"))


; Zippy
;(setq yow-file "/login/evand/lisp/yow.lines")


; Make compile history entries for the various styles of build.
;(setq compile-history
;      '("cd /vobs/cm/route66/software/code/2k/build; ./buildFusion ppc8xx_partial_dist"
;        "cd /vobs/cm/route66/software/code/3k/build; ./buildMalibu ppcep_partial_dist"
;        "cd /vobs/cm/route66/software/code/4k/build; ./buildCatalina ppcep_partial_dist"
;        )
;      )

;(setq compile-command (car compile-history))

; Get confirmation before printing
(put 'print-buffer 'disabled t)

; Fix backspace over a remote connection
(defun fix-backspace ()
  (interactive)
  (define-key global-map "\C-h" 'backward-delete-char)
  )

; Set up tags files to use
;(setq tag-table-alist
;      '(("/vobs/cm/route66/software/code/2k/" . "/login/etasw/route66/links/2k")
;        ("/vobs/cm/route66/software/code/3k/" . "/login/etasw/route66/links/3k")
;        ("/vobs/cm/route66/software/code/4k/" . "/login/etasw/route66/links/4k")
;        ("/vobs/cm/route66/software/code/common/" . "/login/etasw/route66/links/common")
;        ; Use common for fontMgr, I guess
;        ("/vobs/shared/fontMgr/" . "/login/etasw/route66/links/common")
;        )
;      )
