(defmodule unit-error-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'error-monad)

(deftest return-ok
  (is-equal 'ok
            (return 'error-monad 'ok)))

(deftest return-value
  (is-equal #(ok 123)
            (return 'error-monad 123)))

(deftest fail-with-reason
  (is-equal #(error reason)
            (fail 'error-monad 'reason)))

(deftest fail-short-circuits-value
  (is-equal (fail 'error-monad 'something-bad)
            (>> 'error-monad
                (fail 'error-monad 'something-bad)
                (return 'error-monad 123))))

(deftest fail-short-circuits-error
  (is-equal #(error something-bad)
            (>> 'error-monad
                (fail 'error-monad 'something-bad)
                (throw 'error))))
