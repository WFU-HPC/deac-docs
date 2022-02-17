.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

**SAS 9.3**\  [1]_ is installed and available on the RHEL6 cluster. Its
use is restricted to staff and students of Wake Forest Baptist Health.
If you require access to SAS, please send a message to deac-help@wfu.edu

Using
=====

SAS is available only on the RHEL6 cluster. Log in to one of the RHEL6
head nodes for interactive use.

To use SAS, the module must be loaded:

``   $ module load sas-9.3``

This provides the "sas" command. By default, SAS starts in graphical
(GUI) mode. If you are using Windows to access the head nodes, please
see `this article on using Linux graphical displays via
Windows </Cluster:Using_from_Windows>`__. You can also start in terminal
mode, which does not provide a GUI: "sas -nodms"

| ``    $ sas           ``\ *``to``\ ````\ ``run``\ ````\ ``the``\ ````\ ``graphical``\ ````\ ``interface``*
| ``    $ sas -nodms    ``\ *``to``\ ````\ ``run``\ ````\ ``the``\ ````\ ``terminal``\ ````\ ``interface``*

References
==========

.. raw:: html

   <references/>

.. [1]
   `SAS web page <http://www.sas.com/>`__
