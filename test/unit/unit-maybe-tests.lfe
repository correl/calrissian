(defmodule unit-maybe-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/maybe.lfe")

(deftest bind-nothing
  (is-equal 'nothing
            (maybe:>>= 'nothing
                       (lambda (x) (+ 5 x)))))

(deftest bind-nothing-error
  (is-equal 'nothing
            (maybe:>>= 'nothing
                       (lambda (_) (error 'bad-func)))))

(deftest bind-five
  (is-equal 10
            (maybe:>>= (tuple 'just 5)
                       (lambda (x) (+ 5 x)))))

(deftest bind-fold
  (is-equal #(just 3)
            (let ((minc (lambda (x) (maybe:return (+ 1 x))))
                  (bind (lambda (f m) (maybe:>>= m f))))
              (lists:foldr bind
                           #(just 0)
                           (list minc
                                 minc
                                 minc)))))

(deftest >>
  (is-equal #(just 3)
            (maybe:>> #(just 5) #(just 3))))

(deftest do-bindings
  (is-equal #(just 3)
            (do (a <- #(just 1))
                (b <- #(just 2))
              (maybe:return (+ a b)))))

(deftest do-nobindings
  (is-equal #(just 3)
            (do #(just 5)
                #(just 3))))