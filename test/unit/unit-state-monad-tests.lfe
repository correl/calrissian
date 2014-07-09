(defmodule unit-state-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'state-monad)
