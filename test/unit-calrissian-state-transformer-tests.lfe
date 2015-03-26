(defmodule unit-calrissian-state-transformer-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/ltest/include/ltest-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad (transformer 'state 'identity))

(deftest eval
  (is-equal 5
            (let* ((m (transformer 'state 'identity))
                   (mval (call m 'return 5)))
              (call m 'eval mval 'undefined))))

(deftest exec-unchanged
  (is-equal 'foo
            (let* ((m (transformer 'state 'identity))
                   (mval (call m 'return 5)))
              (call m 'exec mval 'foo))))

(deftest exec-modify
  (is-equal 10
            (let ((m (transformer 'state 'identity)))
              (call m 'exec
                (do-m m
                      (call m 'modify (lambda (x) (* x 2))))
                5))))

(deftest exec-put-and-modify
  (is-equal 30
            (let ((m (transformer 'state 'identity)))
              (call m 'exec
                (do-m m
                      (call m 'put 10)
                      (call m 'modify (lambda (x) (+ x 5)))
                      (call m 'modify (lambda (x) (* x 2)))
                      (call m 'return 123))
                3))))

(deftest exec-bind-and-modify
  (is-equal 16
            (let ((m (transformer 'state 'identity)))
              (call m 'exec
                (do-m m
                      (a <- (call m 'modify-and-return (lambda (x) (+ x 5))))
                      (call m 'modify (lambda (x) (+ x a))))
                3))))

(deftest exec-fail
  (is-throw #(error value)
            (let ((m (transformer 'state 'identity)))
              (call m 'exec
                (call m 'fail 'value)
                'undefined))))
