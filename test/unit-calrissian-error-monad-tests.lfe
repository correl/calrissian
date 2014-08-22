(defmodule unit-calrissian-error-monad-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/ltest/include/ltest-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad (monad 'error))

(deftest return-ok
  (is-equal 'ok
            (return (monad 'error) 'ok)))

(deftest return-value
  (is-equal #(ok 123)
            (return (monad 'error) 123)))

(deftest fail-with-reason
  (is-equal #(error reason)
            (fail (monad 'error) 'reason)))

(deftest fail-short-circuits-value
  (is-equal (fail (monad 'error) 'something-bad)
            (>> (monad 'error)
                (fail (monad 'error) 'something-bad)
                (return (monad 'error) 123))))

(deftest fail-short-circuits-error
  (is-equal #(error something-bad)
            (>> (monad 'error)
                (fail (monad 'error) 'something-bad)
                (throw 'error))))
