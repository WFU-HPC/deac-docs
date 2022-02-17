.. contents::
   :depth: 3
..

`Category:Quick Start </Category:Quick_Start>`__ **tcsh** is the Tenex C
Shell. [1]_ [2]_

We highly recommend users login to `bash </Quick_Start_Guide:Bash>`__,
and switch to tcsh only when necessary. Scripts should also be written
in `bash </Quick_Start_Guide:Bash>`__ rather than tcsh. [3]_

Syntax
======

Here is a brief outline of common syntax issues.

Login/Logout Scripts
--------------------

-  .tcshrc
-  .cshrc
-  .login
-  .logout

Aliases
-------

The syntax for defining aliases is:

| ``   alias ls 'ls -FC --color=auto'``
| ``   alias l  'ls'``
| ``   alias ll 'l -l'``
| ``   alias la 'll -a'``

Environment Variables
---------------------

The syntax for defining environment variables is:

| ``   setenv SPECIAL_ENV some_string_or_other``
| ``   setenv VERY_SPECIAL_ENV ${SPECIAL_ENV}:another_string``

See Also
========

-  The man page is comprehensive and definitive

References
==========

.. raw:: html

   <references/>

.. [1]
   `tcsh official website <http://www.tcsh.org/Welcome>`__

.. [2]
   `tcsh article at Wikipedia <http://en.wikipedia.org/wiki/Tcsh>`__

.. [3]
   `CSH Programming Considered
   Harmful <http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/>`__, by
   Tom Christiansen <tchrist@mox.perl.com>, 1996
