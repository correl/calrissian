(defmodule calrissian-error-monad
  (behaviour calrissian-monad)
  (export (>>= 2)
          (return 1)
          (fail 1)))

(defun >>=
  (((tuple 'error reason) f)
   (tuple 'error reason))
  (((tuple 'ok value) f)
   (funcall f value))
  (('ok f)
   (funcall f 'ok)))

(defun return
  (('ok)
   'ok)
  ((x)
   (tuple 'ok x)))

(defun fail (reason)
  (tuple 'error reason))
