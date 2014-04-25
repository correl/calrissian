(defmodule identity-monad
  (behaviour monad)
  (export (>>= 2)
          (return 1)
          (fail 1)))

(defun >>= (x f)
  (funcall f x))

(defun return (x) x)
(defun fail (x) (throw (tuple 'error x)))
