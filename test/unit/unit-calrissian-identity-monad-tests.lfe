(defmodule unit-calrissian-identity-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'calrissian-identity-monad)

(deftest identity
  (is-equal 'ok
            (return 'calrissian-identity-monad 'ok)))

(deftest fail-with-error
  (is-throw #(error value)
            (fail 'calrissian-identity-monad 'value)))