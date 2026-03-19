Start
=====

Simply run the command ``restsh``. Without any option a ncurses menu appears where you can select the configuration to use. As an alternative you can specify the configuration file as the first argument.

.. code::

    restsh [configuration file]

After selecting the configuration file Restsh asks for the username and password if it is not specified in the configuration file or in environment variables.

The environment variables are:

- RESTSH_USER
- RESTSH_PASS

Your are now in a standard Bash shell with a custom environment. Type ``restsh.help`` to show all valid commands provided by Restsh and use ``exit`` to return your default environment.
