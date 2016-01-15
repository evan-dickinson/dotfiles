; $Header: /login/evand/lisp/RCS/alignify.el,v 1.4 2005/05/23 16:51:07 evand Exp $
;
; Horizontally align words in a region

(defun alignify-region ()
"Horizontaly align the words in the selected region so that the words on
each line are aligned in columns."
  (interactive)
  (let* ((begin     (region-beginning))
	 (end       (region-end))
	 (text      (buffer-substring begin end))
	 (lines     (split-string text "\n"))
	 (new-lines (line-splitter lines))
         (leading-whitespace-len (max-leading-whitespace lines))
         (leading-whitespace     (make-string leading-whitespace-len ?\ ))
         (indented-lines         (mapcar (lambda (line) (concat leading-whitespace line)) new-lines))
         (new-text               (join-strings "\n" indented-lines))
	 )
    (delete-region begin end)
    (insert new-text)
    )
  )


(defun line-splitter (text)
  (let* ((broken-lines   (mapcar 'split-string text))
         ; split-string will sometimes return 0-length strings.  Remove them.
         (broken-lines  (mapcar (lambda (str) (filter 'string-non-empty str)) broken-lines))
         (word-lengths   (mapcar (lambda (y) (mapcar 'length y)) broken-lines))
         (transposed-lengths (transpose word-lengths))
         (max-lengths    (mapcar (lambda (x) (apply 'max x)) transposed-lengths))
         (spaced-strings (mapcar (lambda (x) (pad-words x max-lengths))
                                  broken-lines))
         ; Put a space after each padded string (to have the padding between words)
         (spaced-lines   (mapcar (lambda (x) (join-strings " " x)) spaced-strings))
         )
    spaced-lines
    )
  )


; Return true if the string has nonzero length (note: also works on lists)
(defun string-non-empty (string)
  (not (= 0 (length string))))

; Return a list of strings joined together by separator
(defun join-strings (separator strings)
  (foldl (lambda (x y) 
; y is null if x is the last item in the list.
; Don't put the separator after the last item.
           (if y 
               (concat x separator y)
             x)) 
         strings)
  )
  
(defun foldl (fun data)
  (if (null data)
      '()
    (funcall fun (car data) (foldl fun (cdr data)))
    )
  )

; Add spaces to the end of a list of words.  Return a list
; of strings where word number n is padded to be the number
; of characters specified in the nth element of lengths.
(defun pad-words (words lengths)
;  If there are more lengths left
  (if (not (null lengths))
      (let* ((word (car words))
	     (word-length (car lengths))
	     (pad-length (- word-length (length word)))
	     (padded-word (concat word (make-string pad-length ?\ )))
	     (rest (pad-words (cdr words) (cdr lengths)))
	     )
	(cons padded-word rest)
	)
; No more lengths left, return the rest of the words
    words
    )
  )

; Do a matrix transpose operation on a list of lists.
(defun transpose (lists)
  (if (contains-nil lists)
      '()
    (let* ((rest (mapcar 'cdr lists))
	   (new-head (mapcar 'car lists))
	   (new-rest (transpose rest))
	   )
      (cons new-head new-rest)
      )
    )
  )

; Return 't if the condition function returns
; true for any item of the list.
(defun any-match (condition list)
  (cond ((null list) '())
	((funcall condition (car list)) 't)
	('t  (any-match condition (cdr list)))
	)
  )

; Return 't if the list contains nil.
(defun contains-nil (list)
  (any-match (lambda (x) (eq x '())) list)
  )


; Return all the elements in list where condition is true.
; I'm sure this is built-in, but with a different name.
(defun filter (condition list)
  (if (null list) 
      '()
    (let* ((head        (car list))
           (tail        (filter condition (cdr list)))
           )
      (if (funcall condition head)
          (cons head tail)
        tail
        )
      )
    )
  )


(defun count-leading-whitespace (text-as-list)
"Figure out how much leading whitespace a list of characters has"
  (cond ((null text-as-list)              0) ; end of list
        ((not (= (car text-as-list) ?\ )) 0) ; 1st thing isn't whitespace
        ('t                              (+ 1 (count-leading-whitespace (cdr text-as-list))))
        )
  )

(defun max-leading-whitespace (text-lines)
"Given a bunch of lines (in a list, one line per item), figure out which one has the greatest
ammount of initial whitespace.  Return that ammount."
  (let* ((lines-as-lists (mapcar 'string-to-list           text-lines))
         (initial-spaces (mapcar 'count-leading-whitespace lines-as-lists))
         ; Call max, and make its arguments be the things in initial-spaces (that is, 
         ; do list flattening).  There's probably an easier way to do this...
         (maximum        (eval (cons 'max initial-spaces)))
         )
    maximum
    )
  )

