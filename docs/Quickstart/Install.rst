Install
=======

Prepare your environment
------------------------

Windows: Install WSL2
~~~~~~~~~~~~~~~~~~~~~

-  Install Windows Subsystem for Linux (Windows Feature)
-  Start an administrative Power Shell
-  ``wsl --install -d Debian``
-  `Reference <https://learn.microsoft.com/en-us/windows/wsl/install>`__

Linux and macOS
~~~~~~~~~~~~~~~

Restsh runs in any current Linux environment and also on macOS. The Bash shell is required.

- :doc:`/restsh/Installation`

Clone the repository
--------------------

Personally, I manage all my Git repositories in a ``git`` folder in my home directory.

.. code::

    mkdir ~/git
    cd ~/git

**With HTTPS**

.. code::

    git clone https://github.com/AxiansITSecurity/Restsh.git restsh

**With SSH**

.. code::

    git@github.com:AxiansITSecurity/Restsh.git restsh

Setup
-----

Change your working directory into the cloned folder and run the setup script.

.. code:: sh

    cd restsh
    restsh/restsh.setup init

This adjusts your ``.bashrc``, sets an alias for ``restsh`` and creates the ``.restsh-config`` folder in your home
directory.

Your ``.bashsrc`` should now have entries like:

.. code:: sh

    export RESTSH_CONFIG_PATH=/home/juergen/.restsh-config
    alias restsh="/home/juergen/git/Restsh/restsh/restsh.start"
    alias restsh.setup="/home/juergen/git/Restsh/restsh/restsh.setup"

Re-open the terminal or run ``. ~/.bashrc``.
