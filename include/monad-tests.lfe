(defmacro test-monad-functions (monad)
  `(progn
     (deftest monad->>=
       (is-equal (return ,monad 2)
                 (>>= ,monad
                      (return ,monad 1)
                      (lambda (n) (return ,monad (+ 1 n))))))
     (deftest monad->>
       (is-equal (return ,monad 1)
                 (>> ,monad
                     (return ,monad 5)
                     (return ,monad 1))))
     (deftest monad-do
       (is-equal (return ,monad 'ok)
                 (do-m ,monad
                       (return ,monad 'ignored)
                       (return ,monad 'ok))))
     (deftest monad-do-binding
       (is-equal (return ,monad 9)
                 (do-m ,monad
                       (a <- (return ,monad 3))
                       (return ,monad (* a a)))))
     (deftest monad-sequence
       (is-equal (return ,monad (list 1 2 3))
                 (sequence ,monad (list (return ,monad 1)
                                        (return ,monad 2)
                                        (return ,monad 3)))))
     ))

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
         (is-equal (do-m ,monad (a' <- (return ,monad a))
                         (funcall f a'))
                   (do-m ,monad (funcall f a)))))
     
     (deftest monad-do-right-identity
       (let ((m (return ,monad 3)))
         (is-equal (do-m ,monad (x <- m)
                         (return ,monad x))
                   (do-m ,monad m))))
     
     (deftest monad-do-associativity
       (let ((m (return ,monad 3))
             (f (lambda (n) (return ,monad (* 3 n))))
             (g (lambda (n) (return ,monad (+ 5 n)))))
         (is-equal (do-m ,monad (y <- (do-m ,monad (x <- m)
                                            (funcall f x)))
                         (funcall g y))
                   (do-m ,monad (x <- m)
                         (do-m ,monad (y <- (funcall f x))
                               (funcall g y))))))
     ))

(defmacro test-monad (monad)
  `(progn
     (test-monad-functions ,monad)
     (test-monad-laws ,monad)))
