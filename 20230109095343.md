#+TITLE: Lisp fill-unfill paragraphs

#+BEGIN_SRC lisp
;; Unfill paragraphs and regions
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))
#+END_SRC
