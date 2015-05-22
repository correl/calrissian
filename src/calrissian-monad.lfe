(defmodule calrissian-monad
  (export (behaviour_info 1)
          (do-transform 2)))

(defun behaviour_info
  (('callbacks) '(#(>>= 2)
                  #(return 1)
                  #(fail 1)))
  ((_) 'undefined))

(defun do-transform
  ((monad `(,h . ()))
   h)
  ((monad `((,f <- ,m) . ,t))
   `(>>= ,monad
         ,m
         (lambda (,f) ,(do-transform monad t))))
  ((monad `(,h . ,t))
   `(>> ,monad ,h ,(do-transform monad t))))
