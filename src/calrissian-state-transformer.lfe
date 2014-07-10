(defmodule calrissian-state-transformer
  (export all))

(include-lib "include/monads.lfe")

(defun new (inner-monad)
  (tuple 'calrissian-state-transformer inner-monad))

(defun return
  ((x (tuple 'calrissian-state-transformer inner-monad))
   (lambda (s) (call inner-monad 'return (tuple x s)))))

(defun fail
  ((reason (tuple 'calrissian-state-transformer inner-monad))
   (lambda (_) (call inner-monad 'fail reason))))

(defun >>=
  ((x f (tuple 'calrissian-state-transformer inner-monad))
   (lambda (s)
     (call inner-monad '>>=
       (funcall x s)
       (match-lambda (((tuple x1 s1)) (funcall (funcall f x1) s1)))))))

(defun get (_)
  (lambda (s)
    (tuple s s)))

(defun put (s _)
  (lambda (_)
    (tuple 'ok s)))

(defun modify
  ((f (tuple 'calrissian-state-transformer inner-monad))
   (lambda (s)
     (tuple 'ok (call inner-monad 'return (funcall f s))))))

(defun modify-and-return
  ((f (tuple 'calrissian-state-transformer inner-monad))
   (lambda (s)
     (let ((newstate (call inner-monad 'return (funcall f s))))
       (tuple newstate newstate)))))

(defun eval
  ((m s (tuple 'calrissian-state-transformer inner-monad))
   (call inner-monad '>>=
     (funcall m s)
     (match-lambda (((tuple x s1))
                    (call inner-monad 'return x))))))

(defun exec
  ((m s (tuple 'calrissian-state-transformer inner-monad))
   (call inner-monad '>>=
     (funcall m s)
     (match-lambda (((tuple x s1))
                    (call inner-monad 'return s1))))))

(defun run
  ((m s (tuple 'calrissian-state-transformer inner-monad))
   (funcall m s)))

