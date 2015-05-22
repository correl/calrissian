(defmodule unit-calrissian-identity-monad-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "calrissian/include/monads.lfe")
(include-lib "calrissian/include/monad-tests.lfe")

(test-monad (monad 'identity))

(deftest identity
  (is-equal 'ok
            (return (monad 'identity) 'ok)))

(deftest fail-with-error
  (is-throw #(error value)
            (fail (monad 'identity) 'value)))