###########
calrissian
###########


Introduction
============

Calrissian is an implementation of monads in LFE, inspired by
`erlando`_, mostly as a learning exercise. So far, only the Maybe,
Error and Identity monads are supported.


Dependencies
------------

This project assumes that you have `rebar`_ installed somwhere in your
``$PATH``.

This project depends upon the following, which are installed to the ``deps``
directory of this project when you run ``make deps``:

* `LFE`_ (Lisp Flavored Erlang; needed only to compile)
* `lfeunit`_ (needed only to run the unit tests)


Installation
============

Just add it to your ``rebar.config`` deps:

.. code:: erlang

    {deps, [
        ...
        {calrissian, ".*", {git, "git@github.com:correl/calrissian.git", "master"}}
      ]}.


And then do the usual:

.. code:: bash

    $ rebar get-deps
    $ rebar compile


Examples
========

The following examples demonstrate some of the possible uses of monads
in real-world code.

Error Monad
-----------

The following is an example of using the error monad and do-notation
to simplify flow control through a series of sequential operations
that, if any step should fail, should halt execution and return an
error.

The error monad will inspect the result of the previous operation. If
it was successful (represented as ``'ok`` or ``(tuple 'ok result)``),
the result will be passed on to the next operation. If it failed
(represented as ``(tuple 'error reason)``, the error will be returned
and execution will cease.

.. code:: scheme

    (include-lib "deps/calrissian/include/monads.lfe")

    (defun dostuff ()
           (do-m error-monad
                 (input <- (fetch-input))        ;; fetch-input -> (tuple 'ok result) | (tuple 'error reason)
                 (parsed <- (parse-input input)) ;; parse-input -> (tuple 'ok result) | (tuple 'error reason)
                 (store-data parsed)))           ;; store-data -> 'ok | (tuple 'error reason)

Without the error monad, the code might have looked like this:

.. code:: scheme

    (defun dostuff ()
           (case (fetch-input)
                 ((tuple 'error reason)
                  (tuple 'error reason))
                 ((tuple 'ok input)
                  (case (parse-input input)
                        ((tuple 'error reason)
                         (tuple 'error reason))
                        ((tuple 'ok parsed)
                         (store-data parsed))))))

.. Links
.. -----
.. _erlando: https://github.com/rabbitmq/erlando
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
