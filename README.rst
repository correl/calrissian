###########
calrissian
###########


Introduction
============

Calrissian is an implementation of monads in LFE, inspired by
`erlando`_, mostly as a learning exercise. So far, only the maybe
monad is supported.

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


Usage
=====

Coming soon          

.. Links
.. -----
.. _erlando: https://github.com/rabbitmq/erlando
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
