(defmodule maybe
  (export all))

(defun my-adder (x y)
  (+ x (+ y 1)))

(defun >>=
  (('nothing f)
   'nothing)
  (((tuple 'just x) f)
   (funcall f x)))

(defun >> (a b)
  (>>= a (lambda (_) b)))

(defun return (x) (tuple 'just x))
(defun fail (_) 'nothing)

;; (defmacro do statements
;;   `(lists:foldl >>= (car statements) (cdr statements)))

 ;; (defmacro do statements
 ;;  `'(list ,@statements))

(defun do-statement
  (((cons h '())) h)
  (((cons (list f '<- m) t)) (list ': 'maybe '>>=
                                   m
                                   (list 'lambda (list f) (do-statement t))))
  (((cons h t)) (list 'lambda '(_) (do-statement t)))
  )
