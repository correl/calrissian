(defmodule monad
  (export (behaviour_info 1)
          (do-transform 2)))

(defun behaviour_info
  (('callbacks) (list #(>>= 2)
                      #(return 1)
                      #(fail 1)))
  ((_) 'undefined))

(defun do-transform
  ((monad (cons h '())) h)
  ((monad (cons (list f '<- m) t)) (list '>>= monad
                                   m
                                   (list 'lambda (list f) (do-transform monad t))))
  ((monad (cons h t)) (list '>> monad h (do-transform monad t)))
  )
