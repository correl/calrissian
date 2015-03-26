(defmodule unit-calrissian-maybe-monad-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/ltest/include/ltest-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad (monad 'maybe))

(deftest nothing-short-circuits-value
  (is-equal 'nothing
            (>>= (monad 'maybe) 'nothing
                       (lambda (x) (+ 5 x)))))

(deftest nothing-short-circuits-error
  (is-equal 'nothing
            (>>= (monad 'maybe) 'nothing
                       (lambda (_) (error 'bad-func)))))

(deftest fold-increment-value
  (is-equal #(just 3)
            (let ((minc (lambda (x) (return (monad 'maybe) (+ 1 x))))
                  (bind (lambda (f m) (>>= (monad 'maybe) m f))))
              (lists:foldr bind
                           #(just 0)
                           (list minc
                                 minc
                                 minc)))))
