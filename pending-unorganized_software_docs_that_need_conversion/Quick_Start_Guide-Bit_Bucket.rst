.. contents::
   :depth: 3
..

What Is Bit Bucket?
===================

Bitbucket is a web-based hosting service that is owned by Atlassian,
used for source code and development projects that use either Mercurial
or Git revision control systems.

Getting Started
===============

Create an Account
-----------------

#. Navigate to: https://www.bitbucket.org
#. Create an account with your University email.

\*# Afterwards, your account should automatically be converted to an
unlimited academic plan.

Create a Team
-------------

#. Log in and click the "+" sign on the left pane.

\*# You should be able to even login with Google - no password required!

#. Under the "Create A New" submenu, click "Team".

\*# Team names should follow the naming scheme: "DEAC_researchGrp"

\*# This is where research group member emails are added

#. Once a team is created, a link to create a new Repository will appear

Create a Repository
-------------------

#. Click the "+" sign on the left pane.
#. Click "Repository" under "CREATE A NEW"
#. In the new menu, select a pre-existing "Project name" or create a new
   one.
#. Provide a relevant repository name.
#. Ensure "This is a private repository" remains checked if to be seen
   by your group only.
#. Leave "Git" as the Version Control System

\*# Under advanced, add a description and specify code type if desired.

#. Once the repository is created, lists below "Get started with command
   line" will provide steps to use your new repo!

Using a New Repository
----------------------

#. After creating your repo, an "I'm starting from scratch" link will
   provide exact steps to use from headnodes.

::

   git clone https://loginName@bitbucket.org/DEAC-researchGrp/repositoryName.git
   cd repositoryName
   echo "# My project's README" >> README.md
   git add README.md
   git commit -m "Initial commit"
   git push -u origin master

#. Those steps will copy your repository locally, create a new file, and
   push it remotely.

Troubleshooting
===============

Academic Plan Enrollment
------------------------

-  If not automatically enrolled into an academic plan, one of two ways
   can be used

:\* Complete [this
form\|\ https://www.atlassian.com/software/views/bitbucket-academic-license.jsp].

-  OR

:\* Change your plan manually

::\* Log in to your account, click the user icon and "View Profile"

::\* Under Plans and Billing, click "Plan Details"

::\* If it does not state "You're on the Academic (tiered) plan.", click
"Change plan"

::\* Scroll down and click "apply to have your institution added."

-  All users on your team should have the academic plan once fixed

See Also
========

-  `Quick Start Guide:GitHub </Quick_Start_Guide:GitHub>`__
-  `Quick Start Guide:Git
   Migration </Quick_Start_Guide:Git_Migration>`__

References
==========

.. raw:: html

   <references/>

`Category:Quick Start </Category:Quick_Start>`__ `Category:Revision
Control </Category:Revision_Control>`__
