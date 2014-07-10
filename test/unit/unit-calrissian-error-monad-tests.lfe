(defmodule unit-calrissian-error-monad-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/monads.lfe")
(include-lib "include/monad-tests.lfe")

(test-monad 'calrissian-error-monad)

(deftest return-ok
  (is-equal 'ok
            (return 'calrissian-error-monad 'ok)))

(deftest return-value
  (is-equal #(ok 123)
            (return 'calrissian-error-monad 123)))

(deftest fail-with-reason
  (is-equal #(error reason)
            (fail 'calrissian-error-monad 'reason)))

(deftest fail-short-circuits-value
  (is-equal (fail 'calrissian-error-monad 'something-bad)
            (>> 'calrissian-error-monad
                (fail 'calrissian-error-monad 'something-bad)
                (return 'calrissian-error-monad 123))))

(deftest fail-short-circuits-error
  (is-equal #(error something-bad)
            (>> 'calrissian-error-monad
                (fail 'calrissian-error-monad 'something-bad)
                (throw 'error))))
