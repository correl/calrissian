(defmodule unit-maybe-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad maybe-monad)

(deftest bind-short-circuit-value
  (is-equal 'nothing
            (>>= maybe-monad 'nothing
                       (lambda (x) (+ 5 x)))))

(deftest bind-short-circuit-error
  (is-equal 'nothing
            (>>= maybe-monad 'nothing
                       (lambda (_) (error 'bad-func)))))

(deftest bind
  (is-equal 10
            (>>= maybe-monad (tuple 'just 5)
                       (lambda (x) (+ 5 x)))))

(deftest bind-fold
  (is-equal #(just 3)
            (let ((minc (lambda (x) (return maybe-monad (+ 1 x))))
                  (bind (lambda (f m) (>>= maybe-monad m f))))
              (lists:foldr bind
                           #(just 0)
                           (list minc
                                 minc
                                 minc)))))

(deftest do-bindings
  (is-equal #(just 3)
            (do-m maybe-monad
                (a <- #(just 1))
              (b <- #(just 2))
              (return maybe-monad (+ a b)))))

(deftest do-nobindings
  (is-equal #(just 3)
            (do-m maybe-monad
                #(just 5)
              #(just 3))))
