(defmodule unit-state-transformer-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")

(deftest eval
  (is-equal 5
            (let* ((m (: state-transformer new 'identity-monad))
                   (mval (call m 'return 5)))
              (call m 'eval mval 'undefined))))

(deftest exec-unchanged
  (is-equal 'foo
            (let* ((m (: state-transformer new 'identity-monad))
                   (mval (call m 'return 5)))
              (call m 'exec mval 'foo))))

(deftest exec-modify
  (is-equal 10
            (let ((m (: state-transformer new 'identity-monad)))
              (call m 'exec
                (do-m m
                      (call m 'modify (lambda (x) (* x 2))))
                5))))

(deftest exec-modify-multiple
  (is-equal 30
            (let ((m (: state-transformer new 'identity-monad)))
              (call m 'exec
                (do-m m
                      (call m 'modify (lambda (x) (+ x 5)))
                      (call m 'modify (lambda (x) (* x 2)))
                      (call m 'return 123))
                10))))

(deftest exec-fail
  (is-throw #(error value)
            (let ((m (: state-transformer new 'identity-monad)))
              (call m 'exec
                (call m 'fail 'value)
                'undefined))))
