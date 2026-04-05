Install
=======

Dependencies
------------

Restsh works only inside the Bash shell and requires standard GNU core utilities like awk, sed, grep, etc.

Further dependencies are:

- curl >= v7.76.0
- jq >= 1.7
- openssl
- whiptail (newt)

Prepare your environment
------------------------

Restsh runs in any current Linux environment, WSL2, :doc:`/FirstSteps/Docker` and also on macOS. The Bash shell is required.

Windows: Install WSL2
~~~~~~~~~~~~~~~~~~~~~

-  Install Windows Subsystem for Linux (Windows Feature)
-  Start an administrative Power Shell
-  ``wsl --install -d Debian``
-  `Reference <https://learn.microsoft.com/en-us/windows/wsl/install>`__

.. warning:: Restsh is not compatible with GitBash.

Linux
~~~~~

Most packages should be already installed on a standard Linux installation.

-  awk
-  bash
-  coreutils
-  curl
-  gettext-base
-  git
-  grep
-  jq
-  newt (whiptail)
-  sed
-  yq

.. warning:: Restsh is not compatible with the BusyBox utilities, which are used by Alpine Linux, for example.

.. code:: sh

   apt-get install curl gettext-base git jq openssl pandoc whiptail yq

macOS
~~~~~

The required packages must be installed using Homebrew.

.. code:: sh

   brew install bash curl yq jq coreutils findutils gnu-sed gawk grep newt

Then adjust the ``PATH`` accordingly:

.. code:: sh

   PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
   PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
   PATH="/opt/homebrew/opt/curl/bin:$PATH"
   PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
   PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
   PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
   PATH="/opt/homebrew/opt/curl/bin:$PATH"
   PATH="/opt/homebrew/bin:$PATH"

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

The `RESTSH_CONFIG_PATH` environment variable defines the folder for configuration files. Subfolders are supported.
