Examples
========

Downloads API
-------------

Get the download URL for the AS3 package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   # Get the available files for AS3 v.3.75
   myf5.downloads.product.files AS3 AS3 3.57 AS3_v3.57

   # Get the download url for Ireland
   myf5.downloads.product.links /downloads-management/v1/downloads/product/AS3/AS3/3.57/English/AS3_v3.57/f5-appsvcs-3.57.0-13.noarch.rpm | grep IRELAND

   # This link can now be used to download the file without authentication
   curl -lf <link> -o f5-appsvcs-3.57.0-13.noarch.rpm

Get the download URL for BIG-IP 17.5.1.8 ISO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   # Get all product lines for BIG-IP product family
   myf5.downloads.product.lines BIG-IP

   # Get containers for BIG-IP v17.5.1
   myf5.downloads.product.containers BIG-IP big-ip_v17.x 17.5.1

   # Get the available files for BIG-IP v17.5.1.8
   myf5.downloads.product.files BIG-IP big-ip_v17.x 17.5.1 17.5.1.8

   # Get the download url for US West
   myf5.downloads.product.links /downloads-management/v1/downloads/product/BIG-IP/big-ip_v17.x/17.5.1/English/17.5.1.8/BIGIP-17.5.1.8-0.0.19.iso | grep "WEST COAST"
