(defmodule calrissian-error-monad
  (behaviour calrissian-monad)
  (export (>>= 2)
          (return 1)
          (fail 1)))

(defun >>=
  ((`#(error ,reason) f)
   `#(error ,reason))
  ((`#(ok ,value) f)
   (funcall f value))
  (('ok f)
   (funcall f 'ok)))

(defun return
  (('ok)
   'ok)
  ((x)
   `#(ok ,x)))

(defun fail (reason)
  `#(error ,reason))
