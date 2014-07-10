(defmodule unit-calrissian-maybe-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'calrissian-maybe-monad)

(deftest nothing-short-circuits-value
  (is-equal 'nothing
            (>>= 'calrissian-maybe-monad 'nothing
                       (lambda (x) (+ 5 x)))))

(deftest nothing-short-circuits-error
  (is-equal 'nothing
            (>>= 'calrissian-maybe-monad 'nothing
                       (lambda (_) (error 'bad-func)))))

(deftest fold-increment-value
  (is-equal #(just 3)
            (let ((minc (lambda (x) (return 'calrissian-maybe-monad (+ 1 x))))
                  (bind (lambda (f m) (>>= 'calrissian-maybe-monad m f))))
              (lists:foldr bind
                           #(just 0)
                           (list minc
                                 minc
                                 minc)))))
