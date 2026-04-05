Passwords and Secrets
=====================

There are two supported methods to save passwords or secrets securely:

1. AES256 encryption
2. HashiCorp Vault or OpenBao integration

Restsh automatically handles Vault values or encrypted values for following variables:

- RESTSH_PASS
- RESTSH_TOKEN_VALUE
- SCM_SECRET
- RESTSH_CURL_PROXY_PASS

Any other variable can be resolved with the ``restsh.util.var.decrypt`` function. ``restsh.util.setvar`` and ``restsh.util.setvars`` also use this feature.

Restsh checks the start of the variable to decide if it must be decrypted or fetched. The keywords are ``AES256:`` and ``VAULT:``.

AES encryption
--------------

AES encryption and decryption is done with the functions ``restsh.util.encrypt`` and ``restsh.util.decrypt``. Restsh uses openssl with the options ``-aes-256-cbc`` and ``-pbkdf2`` to encrypt the sensitive values.

Both functions are using the ``RESTSH_SECRET`` environment variable as secret. This secret is read from the file defined by the environment variable ``RESTSH_SECRET_FILE``.

For interactive mode you can simply not set the ``RESTSH_SECRET`` value. Restsh asks for it as soon as requires it.

In scripted mode, e. g. in CI/CD pipelines you must set the ``RESTSH_SECRET`` environment variable. There are more than one option to do this:

- Define ``RESTSH_SECRET`` as a CI/CD variable (Masked and Hidden in GitLab)
- Inject the ``RESTSH_SECRET`` value in the CI/CD runner
- Set the value of ``RESTSH_SECRET_FILE`` to a file that is mounted from a secret store
- Use a sealed secret from Kubernetes

.. Hint::

    Set the value of a variable to the output of ``restsh.util.encrypt`` (with the ``AES256:`` prefix) to define a encrypted variable.

Workflow
~~~~~~~~

- Start Restsh
- Create the encrypted password string: ``restsh.util.encrypt``
- Exit Restsh and define the ``RESTSH_PASS`` variable as ``<output of above command>``, beginning with ``AES256:``.
- In interactive mode, Restsh asks for the secret if it is not defined in ``RESTSH_SECRET``. In script mode it terminates with an error.
- As an alternative you can set ``RESTSH_SECRET_FILE`` to a file to read the ``RESTSH_SECRET`` from.

.. Hint::

    You can use ``restsh.pwgen`` or ``restsh.passphrase`` to create a secure secret.

HashiCorp Vault
---------------

Using HashiCorp Vault or OpenBao is the best way to store passwords and secrets. Restsh supports the login with an JWT token and fetching a key value.

1. Set VAULT_HOST or VAULT_ADDR and VAULT_AUTH_ROLE
2. Set VAULT_ID_TOKEN and call ``vault.login`` or set the ``VAULT_TOKEN`` directly if you have a already a valid token.
3. Use ``vault.get`` to fetch a key value.

.. Hint::

    Set the value of a variable to ``VAULT:<path>`` to reference a value in Vault.
