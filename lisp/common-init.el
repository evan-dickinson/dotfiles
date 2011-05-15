; $Header: /login/evand/lisp/RCS/common-init.el,v 1.10 2008/04/16 18:18:06 evand Exp $
;
; xemacs initializations that are common under unix & windows

(load "alignify")

(line-number-mode 1)
(column-number-mode 1)

;; Stuff to make C mode not suck
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				   (class-close       . 0)
				   (class-open        . 0)
                                   (defun-block-intro . 4)
				   (inline-close      . 0)
				   (inline-open       . 0)
                                   (block-open        . 0)
                                   (case-label        . 4)
                                   (knr-argdecl-intro . -)
                                   (substatement-open . 0)))
    (c-echo-syntactic-information-p . nil)
    )
  "My C Programming Style")

;
; C style for Editing code Leif wrote
(defconst leif-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (brace-list-intro  . 2)
				   (class-close       . 0)
				   (class-open        . 0)
                                   (defun-block-intro . 2)
				   (inline-close      . 0)
				   (inline-open       . 0)
				   (statement-block-intro . 0)
                                   (statement-case-intro  . 2)
				   (substatement      . +)
                                   (block-open        . 0)
                                   (case-label        . 0)
                                   (knr-argdecl-intro . -)
                                   (substatement-open . 2)))
    (c-echo-syntactic-information-p . nil)
    )
  "Leif's C Programming Style")

(defun leif-c-mode ()
  "Make Emacs use Leif's indentation style"
  (interactive)
  (c-add-style "LEIF" leif-c-style t))

(defun evan-c-mode ()
  "Make Emacs use Evan's indentation style"
  (interactive)
  (c-add-style "EVAN" my-c-style t))

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c-mode-common-hook ()
  (font-lock-mode)
  (hide-ifdef-mode 1) ; Doc says to use a number, not 't
  ;; add my personal style and set it for the current buffer
  (if (string= (substring (buffer-name) 0 3) "SM_")
      ; If editing cmd subsystem, use Leif's style
      (c-add-style "LEIF"     leif-c-style t)
    ; Otherwise use my style
    (c-add-style "PERSONAL" my-c-style t)
    )
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '++)
  ;; other customizations
  (setq tab-width 8)
  ;; this will make sure spaces are used instead of tabs
  (setq indent-tabs-mode nil)

  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map "\C-j" 'fill-paragraph)
  ; Make M-f and M-b work with MixedCase words
  (define-key c-mode-base-map "\M-b" 'c-backward-into-nomenclature)
  (define-key c-mode-base-map "\M-f" 'c-forward-into-nomenclature)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;
; Make navigating filenames in the minibuffer easier.
(define-key minibuffer-local-map "\M-b" 'c-backward-into-nomenclature)
(define-key minibuffer-local-map "\M-f" 'c-forward-into-nomenclature)

(setq minibuffer-max-depth nil)

(put 'eval-expression 'disabled nil)
(custom-set-variables
 '(blink-matching-paren t)
 '(clearcase-display-status nil)
 '(recent-files-menu-path nil)
 '(all-christian-calendar-holidays t)
 '(remote-compile-user "evand")
 '(delete-key-deletes-forward t)
 '(clearcase-checkout-switches "-unreserved")
 '(load-home-init-file t t)
 '(clearcase-suppress-checkout-comments t)
 '(recent-files-permanent-submenu t)
 '(remote-compile-run-before ".cshrc")
 '(recent-files-commands-submenu t)
 '(remote-compile-host "tekcs4")
 '(recent-files-add-menu-before "Edit")
 '(mark-holidays-in-calendar t)
; '(user-mail-address "evan.a.dickinson@tek.com")
 '(query-user-mail-address nil)
; '(paren-mode (quote paren) nil (paren))
 '(recent-files-include-save-now t))
(custom-set-faces)


; Text mode stuff
; Automatically run auto fill mode in text mode,
; and set C-j to fill-paragraph (like in Pico/Pine)
(defun my-text-mode-hook ()
  (interactive)
  (turn-on-auto-fill)
  (local-set-key "\C-j" 'fill-paragraph)
  )
(add-hook 'text-mode-hook 'my-text-mode-hook)


; XML mode stuff
; turn *off* auto-fill mode (don't do unexpected line breaks).
;
; Grr.  This didn't seem to work. 
(defun my-xml-mode ()
  (interactive)
  (auto-fill-mode 0) ; 0 = off
  )
(add-hook 'psgml-xemacs-load-hook 'my-xml-mode)

; Require a newline at the end of each file
(setq require-final-newline 't)

; Make Emacs silent
(setq bell-volume 0)
(setq sound-alist nil)
; Flash instead of beep
(setq visible-bell 't)

(defun undosify ()
  "Remove DOS line breaks from a file."
  (interactive)
  (replace-string "\r\n" "\n")
  )

(defun dosify ()
  "Add DOS line breaks to a file."
  (interactive)
  (replace-string "\n" "\r\n")
  )


;
; Use for editing files with a tab width of 8
(defun tab8 ()
  "Sets tab with to 8"
  (interactive)
  (setq tab-width 8))

;
; Use for editing files with a tab width of 4
(defun tab4 ()
  "Sets tab with to 4"
  (interactive)
  (setq tab-width 4))

; Indent by 4 in Perl code
(setq cperl-indent-level 4)

; Turn off highlight of trailing spaces
(setq cperl-invalid-face nil)

; better buffer switching
;
; GNU Emacs needs to call iswitchb-mode
; XEmacs needs to call iswitchb-default-keybindings
(if (functionp 'iswitchb-mode)
    (iswitchb-mode)
  (iswitchb-default-keybindings))
; Never change the frame with C-x b
(setq iswitchb-default-method 'samewindow)

(global-set-key "\C-l" 'query-replace)
(global-set-key "\M-l" 'query-replace-regexp)

(global-set-key "\M-s" 'isearch-forward-regexp)
; M-r was move-window-to-line, which I've never ever used.
(global-set-key "\M-r" 'isearch-backward-regexp)

; Match the Windows keystrokes for deleting one word
(global-set-key [(control backspace)] 'backward-kill-word)
(global-unset-key [(meta backspace)]) ; was backward-kill-word

; Don't minimize xemacs when it's running non-console
(defun suspend-emacs-or-do-nothing ()
  "If emacs is running in a window system, do nothing.  If it's running in a console,
suspend the frame.

Analagous to suspend-emacs-or-iconify-frame."
  (interactive)
  (if (not (console-on-window-system-p))
      (suspend-emacs)
    )
  )
(global-set-key "\C-z" 'suspend-emacs-or-do-nothing)

; Oops.  This is bound to C-w.  Didn't need to reinvent it.
;
;(defun kill-region-or-line ()
;  "If text is selected, kill it.  Otherwise kill the rest of the current line."
;  (interactive)
;  (if (region-active-p)
;      (kill-region (point) (mark))
;    (kill-line)
;    )
;  )
;(global-set-key "\C-k" 'kill-region-or-line)

(defun indent-region-or-line (indent)
  "If a region is selected, indent it.  Otherwise indent the current line."
  (if (region-active-p)
      ; a region is active.  indent the whole region.
      (let* ((start (min (point) (mark)))
             (end   (max (point) (mark)))
             )
        (indent-rigidly start end indent)
        )

    ; No region is active, indent the current line.
    ; 
    ; save-excursion lets us move the point & it will restore it when
    ; we're done.
    (save-excursion
      (let* ((start (progn (beginning-of-line) (point)))
             (end   (progn (end-of-line)       (point)))
             )
        (indent-rigidly start end indent)                    
        )
      )
    )
  )

(defun indent-region-or-line-4 ()
  "Indent the region or line by 4 spaces"
  ; In xemacs:
  ; the "_" flag to interactive keeps the region selected after
  ; this command finishes.  See documentation for zmacs-region-stays
  ;
  ; In gnu emacs:
  ; "_" is not supported. Instead, do C-x C-x to re-select the buffer
  ; See: http://stackoverflow.com/q/1041332
  ;(interactive "_")
  (interactive)
  (indent-region-or-line 4)
  )

(defun outdent-region-or-line-4 ()
  "Outdent the region or line by 4 spaces (or indent by -4 spaces)"
  ; See above for discussion of interactive
  (interactive)
  (indent-region-or-line -4)
  )

(global-set-key "\C-c]" 'indent-region-or-line-4)
(global-set-key "\C-c[" 'outdent-region-or-line-4)

; Autoinsert stuff
; Automatically put the appropriate header on .c and .h files
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-alist
      '((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header")
	 (upcase (concat (file-name-nondirectory
			  (substring buffer-file-name 0 (match-beginning 0)))
			 "_"
			 (substring buffer-file-name (1+ (match-beginning 0)))))
	 "/**************************************\n"
	 " * $Header: /login/evand/lisp/RCS/common-init.el,v 1.10 2008/04/16 18:18:06 evand Exp $\n"
	 " * Copyright (c) " (substring (current-time-string) -4) " Tektronix, Inc.  All rights reserved.\n"
	 " * \n"
	 " * Description: \n"
	 " * \n"
	 " * Original author: " (user-full-name) " (" (getenv "USER") ")\n"
	 " **************************************/\n\n"
	 "#ifndef " str \n
	 "#define " str "\n\n"
	 _ "\n\n#endif /* ifndef " str " */\n")
	
	(("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program")
	 nil
	 "/**************************************\n"
	 " * $Header: /login/evand/lisp/RCS/common-init.el,v 1.10 2008/04/16 18:18:06 evand Exp $\n"
	 " * Copyright (c) " (substring (current-time-string) -4) " Tektronix, Inc.  All rights reserved.\n"
	 " * \n"
	 " * Description: \n"
	 " * \n"
	 " * Original author: " (user-full-name) " (" (getenv "USER") ")\n"
	 " **************************************/\n\n"

	)))


; Spaces, not tabs
(setq-default indent-tabs-mode nil)


; Use mercurial
(if (featurep 'xemacs)
    (load "mercurial") ;xemacs
  (load "vc-hg")) ;gnu emacs

; Instead of hg-ediff, I should be able to do the following:
; http://stackoverflow.com/questions/3712834/getting-vc-diff-to-use-ediff-in-emacs-23-2

; New function, added by Evan
(defun hg-ediff ()
  (interactive)
  (let* ((buffer-new   (current-buffer) )
         (buffer-old   (generate-new-buffer "old revision"))
         (filename     (buffer-file-name buffer-new))
         (diff-command (concat "hg cat " filename))
         )

         (shell-command diff-command buffer-old)
         (ediff-buffers buffer-old buffer-new)
    )
  )

; This fixes an incompatiblity in ediff between
; GNU emacs & xemacs.
;
; See http://groups.google.com/group/comp.emacs.xemacs/browse_thread/thread/832455580710d8ae
(if (featurep 'xemacs) ;; error in ediff-init.el 
    (eval-after-load "ediff-init" 
      '(if (equal ediff-coding-system-for-write 'emacs-internal) 
           (setq ediff-coding-system-for-write 'escape-quoted)))) 
