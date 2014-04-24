(defmacro do args
  (let ((monad (car args))
        (statements (cdr args)))
    (monad:do-transform monad statements)))

(defmacro >>= (monad m f)
  `(: ,monad >>= ,m ,f))

(defmacro >> (monad m1 m2)
  `(: ,monad >>= ,m1 (lambda (_) ,m2)))

(defmacro return (monad expr)
  `(: ,monad return ,expr))
