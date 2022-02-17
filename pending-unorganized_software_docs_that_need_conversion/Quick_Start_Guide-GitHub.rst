.. contents::
   :depth: 3
..

What Is Git Hub?
================

GitHub is a development platform inspired by the way you work. From open
source to business, you can host and review code, manage projects, and
build software alongside millions of other developers.

Getting Started
===============

Create an Account
-----------------

#. Navigate to: https://github.com
#. Create an account with your University email.
#. Leave, "Unlimited public repositories for free" as your plan.
#. Answer "Tailor your experience" questions and submit, or Skip
#. Verify your email account by clicking the provided link in email sent
   to your inbox.

Get Educational Discount
------------------------

#. Navigate to: https:education.github.com
#. Select role that describes you at WFU, and enter "Individual Account"
#. Click Next
#. Ensure your chosen github login name and .edu email address are
   entered

   -  Note - If you are asked to upload an image of your school ID, then
      your email has not been verified!

#. Enter school name and state how you will use Git (in general), and
   click "Submit Request"
#. Check inbox for Discount email (within a few hours)

Using GitHub
============

-  Follow the provided guide:
   https://guides.github.com/activities/hello-world/
-  User tutorial: https://try.github.io

Create a Repository
-------------------

#. In the upper right corner, next to your avatar, click "+" and then
   select New repository.
#. Name your repository.
#. Write a short description.
#. Select "Private" if discount approval has been received

   -  Leaving as public makes your repository world viewable
   -  You still specify who can commit and make changes.

#. If new repo, select "Initialize this repository with a README".

   -  If importing a repo, do not select.

Using a New Repository
----------------------

-  Command line steps to add data to

::

   echo "# Testing" >> README.md
   git init
   git add README.md
   git commit -m "first commit"
   git remote add origin https://<username>@github.com/<GIT-REPO>/Testing.git
   git push -u origin master

-  Those steps will copy your repository locally, create a new file, and
   push it remotely.

See Also
========

-  `Quick Start Guide:Bit Bucket </Quick_Start_Guide:Bit_Bucket>`__
-  `Quick Start Guide:Git
   Migration </Quick_Start_Guide:Git_Migration>`__

`Category:Quick Start </Category:Quick_Start>`__ `Category:Revision
Control </Category:Revision_Control>`__
