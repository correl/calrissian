(defmodule maybe-monad
  (behaviour monad)
  (export (>>= 2)
          (return 1)
          (fail 1)))

(defun >>=
  (('nothing f)
   'nothing)
  (((tuple 'just x) f)
   (funcall f x)))

(defun return (x) (tuple 'just x))
(defun fail (_) 'nothing)
