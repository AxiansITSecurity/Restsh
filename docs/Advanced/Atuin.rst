Atuin
=====

Restsh supports the integration of [Atuin](https://atuin.sh/) for better shell history support.

Most distribution should provide a package, else you can install it directly from the repository.

.. code::

    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

.. hint::

    Restsh enables Atuin only for ``Strg+r``.

Import shell history
--------------------

.. code::

    atuin import auto
