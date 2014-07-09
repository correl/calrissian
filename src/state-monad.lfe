(defmodule state-monad
  (behaviour monad)
  (behaviour state)
  (export (return 1)
          (fail 1)
          (run 2)
          (>>= 2)
          (get 0)
          (put 1)
          (modify 1)
          (modify-and-return 1)
          (exec 2)
          (eval 2)))

(defun return (x) (lambda (state) (tuple x state)))
(defun fail (x) (throw (tuple 'error x)))

(defun run (m state)
  (funcall m state))

(defun >>= (m f)
  (lambda (state)
    (let (((tuple x s) (run m state)))
      (run (funcall f x) s))))

(defun put (state)
  (lambda (_) (tuple '() state)))

(defun get ()
  (lambda (state)
    (tuple state state)))

(defun modify (f)
  (lambda (state)
    (tuple '() (funcall f state))))

(defun modify-and-return (f)
  (lambda (state)
    (let ((newstate (funcall f state)))
      (tuple newstate newstate))))

(defun eval (m state)
  (let (((tuple x _s) (run m state)))
    x))
(defun exec (m state)
  (let (((tuple _x s) (run m state)))
    s))
