Installation
============

Restsh runs in any current Linux environment and also on macOS. The Bash shell is required.

Linux
-----

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

macOS
-----

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
