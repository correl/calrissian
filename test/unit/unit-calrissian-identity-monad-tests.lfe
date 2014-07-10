(defmodule unit-calrissian-identity-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad (monad 'identity))

(deftest identity
  (is-equal 'ok
            (return (monad 'identity) 'ok)))

(deftest fail-with-error
  (is-throw #(error value)
            (fail (monad 'identity) 'value)))