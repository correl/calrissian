(defmacro do-m args
  (let ((monad (car args))
        (statements (cdr args)))
    (monad:do-transform monad statements)))

(defmacro >>= (monad m f)
  (if (: lfe-utils atom? monad)
    `(call ',monad '>>= ,m ,f)
    `(call ,monad '>>= ,m ,f)))

(defmacro >> (monad m1 m2)
  (let ((f `(lambda (_) ,m2)))
    (if (: lfe-utils atom? monad)
      `(call ',monad '>>= ,m1 ,f)
      `(call ,monad '>>= ,m1 ,f))))

(defmacro return (monad expr)
  (if (: lfe-utils atom? monad)
    `(call ',monad 'return ,expr)
    `(call ,monad 'return ,expr)))

(defmacro fail (monad expr)
  (if (: lfe-utils atom? monad)
    `(call ',monad 'fail ,expr)
    `(call ,monad 'fail ,expr)))

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
