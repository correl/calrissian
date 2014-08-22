(defmodule unit-calrissian-identity-monad-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/ltest/include/ltest-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad (monad 'identity))

(deftest identity
  (is-equal 'ok
            (return (monad 'identity) 'ok)))

(deftest fail-with-error
  (is-throw #(error value)
            (fail (monad 'identity) 'value)))