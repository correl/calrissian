(defmodule calrissian-state-transformer
  (export all))

(include-lib "include/monads.lfe")

(defun new (inner-monad)
  `#(calrissian-state-transformer ,inner-monad))

(defun return
  ((x `#(calrissian-state-transformer ,inner-monad))
   (lambda (s) (call inner-monad 'return (tuple x s)))))

(defun fail
  ((reason `#(calrissian-state-transformer ,inner-monad))
   (lambda (_) (call inner-monad 'fail reason))))

(defun >>=
  ((x f `#(calrissian-state-transformer ,inner-monad))
   (lambda (s)
     (call inner-monad '>>=
       (funcall x s)
       (match-lambda ((`#(,x1 ,s1)) (funcall (funcall f x1) s1)))))))

(defun get (_)
  (lambda (s)
    `#(,s ,s)))

(defun put (s _)
  (lambda (_)
    `#(ok ,s)))

(defun modify
  ((f `#(calrissian-state-transformer ,inner-monad))
   (lambda (s)
     `#(ok ,(call inner-monad 'return (funcall f s))))))

(defun modify-and-return
  ((f `#(calrissian-state-transformer ,inner-monad))
   (lambda (s)
     (let ((newstate (call inner-monad 'return (funcall f s))))
       `#(,newstate ,newstate)))))

(defun eval
  ((m s `#(calrissian-state-transformer ,inner-monad))
   (call inner-monad '>>=
     (funcall m s)
     (match-lambda ((`#(,x ,s1))
                    (call inner-monad 'return x))))))

(defun exec
  ((m s `#(calrissian-state-transformer ,inner-monad))
   (call inner-monad '>>=
     (funcall m s)
     (match-lambda ((`#(,x ,s1))
                    (call inner-monad 'return s1))))))

(defun run
  ((m s `#(calrissian-state-transformer ,inner-monad))
   (funcall m s)))

