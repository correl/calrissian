(defmodule unit-maybe-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'maybe-monad)

(deftest nothing-short-circuits-value
  (is-equal 'nothing
            (>>= 'maybe-monad 'nothing
                       (lambda (x) (+ 5 x)))))

(deftest nothing-short-circuits-error
  (is-equal 'nothing
            (>>= 'maybe-monad 'nothing
                       (lambda (_) (error 'bad-func)))))

(deftest fold-increment-value
  (is-equal #(just 3)
            (let ((minc (lambda (x) (return 'maybe-monad (+ 1 x))))
                  (bind (lambda (f m) (>>= 'maybe-monad m f))))
              (lists:foldr bind
                           #(just 0)
                           (list minc
                                 minc
                                 minc)))))
