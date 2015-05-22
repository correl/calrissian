(defmodule calrissian-maybe-monad
  (behaviour calrissian-monad)
  (export (>>= 2)
          (return 1)
          (fail 1)))

(defun >>=
  (('nothing f)
   'nothing)
  ((`#(just ,x) f)
   (funcall f x)))

(defun return (x)
  `#(just ,x))

(defun fail (_)
  'nothing)
