(defmacro test-monad-laws (monad)
  `(progn
     (deftest monad-left-identity
       (let ((a 3)
             (f (lambda (n) (return ,monad (* 3 n)))))
         (is-equal (>>= ,monad (return ,monad a) f)
                   (funcall f a))))
     
     (deftest monad-right-identity
       (let ((m (return ,monad 3)))
         (is-equal (>>= ,monad m (lambda (m') (return ,monad m')))
                   m)))
     
     (deftest monad-associativity
       (let ((m (return ,monad 3))
             (f (lambda (n) (return ,monad (* 3 n))))
             (g (lambda (n) (return ,monad (+ 5 n)))))
         (is-equal (>>= ,monad (>>= ,monad m f) g)
                   (>>= ,monad m (lambda (x) (>>= ,monad (funcall f x) g))))))
     
     (deftest monad-do-left-identity
       (let ((a 3)
             (f (lambda (n) (return ,monad (* 3 n)))))
         (is-equal (do ,monad (a' <- (return ,monad a))
                     (funcall f a'))
                   (do ,monad (funcall f a)))))
     
     (deftest monad-do-right-identity
       (let ((m (return ,monad 3)))
         (is-equal (do ,monad (x <- m)
                     (return ,monad x))
                   (do ,monad m))))
     
     (deftest monad-do-associativity
       (let ((m (return ,monad 3))
             (f (lambda (n) (return ,monad (* 3 n))))
             (g (lambda (n) (return ,monad (+ 5 n)))))
         (is-equal (do ,monad (y <- (do ,monad (x <- m)
                                           (funcall f x)))
                     (funcall g y))
                   (do ,monad (x <- m)
                     (do ,monad (y <- (funcall f x))
                       (funcall g y))))))
     ))
