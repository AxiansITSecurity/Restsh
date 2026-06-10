F5 Certificate Deployment with HashiCorp Vault
==============================================

Introduction
------------

This tutorial demonstrates how to deploy a new certificate on the F5 by creating a certificate signing request and signing it with HashiCorp Vault.

In this workflow, you'll create the certificate materials on the F5, have them signed by a trusted Certificate Authority (in this case, HashiCorp Vault), and then deploy the signed certificate back to the F5. This process ensures that the private key never leaves the F5.

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

1. Create a key pair and signing request (CSR) on the F5
--------------------------------------------------------

The first step is to create a key pair and a Certificate Signing Request (CSR) on the F5. A key pair consists of a private key (which stays secret on the F5) and a public key. The CSR contains the public key and certificate details that will be sent to a Certificate Authority (CA) for signing.

Below are the certificate parameters we'll use for this example:

- Name on the F5: test.lab.lan
- Partition: Common
- CN: test.lab.lan
- Subject Alternative Names: test.lab.lan, test2.lab.lan
- Keytype: EC with SECP384R1

.. code:: sh

   f5.cert.csr.create --cn=test.lab.lan --keytype=ec-private --curvename=secp384r1 -a test.lab.lan -a test2.lab.lan -n test.lab.lan

2. Download the signing request
-------------------------------

The next step is to download the Certificate Signing Request from the F5 to your local machine. This file contains the public key and certificate information that needs to be signed by the Certificate Authority. We'll save it to a temporary directory for processing.

.. code:: sh

   f5.cert.csr.get /Common/test.lab.lan > "$RESTSH_TMP/test.lab.lan.csr"

You can inspect the details of the CSR to verify it contains the correct information (domain names, key type, etc.). The ``cert.*`` commands are convenient wrapper scripts for the OpenSSL command-line tool, making certificate operations easier.

.. code:: sh

   cert.csr.show "$RESTSH_TMP/test.lab.lan.csr"

You can also view the public key contained in the CSR:

.. code:: sh

   cert.csr.pubkey "$RESTSH_TMP/test.lab.lan.csr"

3. Sign the CSR with HashiCorp Vault
------------------------------------

Now we use HashiCorp Vault to sign the CSR. Vault acts as your Certificate Authority (CA) and will create a signed certificate based on your CSR. First, you authenticate with Vault using ``vault login``, then you submit the CSR for signing.

The ``vault write`` command sends your CSR to the Vault PKI backend, which signs it and returns a complete certificate. In this example, we're using the signing backend/role ``pki/sign/lab-ca`` (adjust this to match your Vault configuration).

.. code:: sh

   vault login
   vault write -field=certificate pki/sign/lab-ca csr=@"$RESTSH_TMP/test.lab.lan.csr" > "$RESTSH_TMP/test.lab.lan.crt"

After signing, you can verify the certificate details to ensure it was signed correctly and contains the expected information (domain names, validity period, key type, etc.):

.. code:: sh

   cert.x509.show "$RESTSH_TMP/test.lab.lan.crt"

You can also view the public key in the signed certificate to confirm it matches the public key from the CSR:

.. code:: sh

   cert.x509.pubkey "$RESTSH_TMP/test.lab.lan.crt"

4. Upload the signed certificate to the F5
------------------------------------------

Finally, we upload the signed certificate back to the F5. This makes the certificate available for use in SSL profiles. We use the same certificate name that we used when creating the CSR, so the F5 knows to pair it with the private key we created in step 1.

.. code:: sh

   f5.cert.import /Common/test.lab.lan "$RESTSH_TMP/test.lab.lan.crt"

You can view the imported certificate with following command:

.. code:: sh

   f5.cert.get /Common/test.lab.lan

5. Cleanup
-----------

Cleanup is optional the files in the temporary directory will be automatically removed after Restsh finishes. However, if you want to manually remove the CSR and certificate files from your local machine, you can do so with the following command:

.. code:: sh

   rm "$RESTSH_TMP/test.lab.lan.csr" "$RESTSH_TMP/test.lab.lan.crt"

Optionally sync the F5 cluster to ensure the new certificate is available on all cluster members. ``failover`` is here the name of the Sync-Failover device group.

.. code:: sh

   f5.cluster.config-sync failover

Summary
-------

In this tutorial, we walked through the process of deploying a new certificate on an F5 device using Restsh and HashiCorp Vault. We created a key pair and CSR on the F5, signed the CSR with Vault, and then imported the signed certificate back to the F5. This workflow allows you to securely manage certificates without exposing private keys, while leveraging the power of Restsh for automation and integration with your existing infrastructure.

**Used Restsh commands**:

- ``cert.csr.pubkey``: Shows the public key of a certificate signing request
- ``cert.x509.pubkey``: Shows the public key of a certificate
- ``cert.x509.show``: Shows details of a certificate
- ``f5.cert.csr.create``: Creates a certificate signing request on the F5
- ``f5.cert.csr.get``: Exports a certificate signing request from the F5
- ``f5.cert.get``: Exports a certificate from the F5
- ``f5.cert.import``: Imports a certificate into the F5
- ``f5.cluster.config-sync``: Syncs a F5 Device Group
