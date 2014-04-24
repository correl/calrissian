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

(defun do-statement
  (((cons h '())) h)
  (((cons (list f '<- m) t)) (list ': 'maybe '>>=
                                   m
                                   (list 'lambda (list f) (do-statement t))))
  (((cons h t)) (list ': 'maybe '>> h (do-statement t)))
  )
