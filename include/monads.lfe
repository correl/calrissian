(defmacro do-m args
  (let ((monad (car args))
        (statements (cdr args)))
    (monad:do-transform monad statements)))

(defmacro >>= (monad m f)
  `(: ,monad >>= ,m ,f))

(defmacro >> (monad m1 m2)
  `(: ,monad >>= ,m1 (lambda (_) ,m2)))

(defmacro return (monad expr)
  `(: ,monad return ,expr))

(defmacro fail (monad expr)
  `(: ,monad fail ,expr))

(defmacro sequence (monad list)
  `(: lists foldr
     (lambda (m acc) (mcons ,monad m acc))
     (return ,monad [])
     ,list))

(defmacro mcons (monad m mlist)
  `(do-m ,monad
         (x <- ,m)
         (rest <- ,mlist)
         (return ,monad (cons x rest))))
