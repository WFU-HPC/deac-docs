.. contents::
   :depth: 3
..

Converting SVN repo to GIT
==========================

The following is based upon an `online
tutorial <https://www.atlassian.com/git/tutorials/svn-to-git-prepping-your-team-migration>`__.

Preparation
-----------

-  You will need to use the pre-downloaded svn-migration-scripts.jar
   file on the headnodes

:\* You can also download
`svn-migration-scripts.jar <https://bitbucket.org/atlassian/svn-migration-scripts/downloads/svn-migration-scripts.jar>`__
locally, but additional steps will need to be covered OYO via the
referenced tutorial.

:\* Verify the downloaded file if using locally: *java -jar
~/svn-migration-scripts.jar verify*

-  Generate an "Authors" file to convert SVN commit info to Git format

::

    java -jar svn-migration-scripts.jar authors <svn-repo> > authors.txt
   j.doe = j.doe <j.doe@mycompany.com>
   m.smith = m.smith <m.smith@mycompany.com><\pre>
   :* This will save all users who have committed to the SVN repo, which you will then need to update with full name and email.
   * Edit the authors.txt file and change the portion to the right of the "=" to the example below
   <pre>
   j.doe = John Doe <john.doe@atlassian.com>
   m.smith = Mary Smith <mary.smith@atlassian.com>

Converting
----------

-  Beware this process can take a significant amount of time for large
   repos.

:\* For example, a 400MB repository with 33K commits can take around 12
hours.

-  The command to convert a SVN repo with a standard layout is:

::

   git svn clone --stdlayout --authors-file=authors.txt <svn-repo>/<project> <git-repo-name>

-  Where svn-repo is the URI of the SVN repository you are migrating,
   project is the name to be imported, and git-repo-name is the new Git
   repository

::

    git svn clone --stdlayout --authors-file=authors.txt <SVN_URL>/NiceCode NiceCodeAsGit 

-  Inspect what was migrated

:\* Run *git branch -r* to examine branches moved

:\* Run *git tag* to inspect tags with commits

:\* It's okay if things seem out of order, as long as the content is
there.

-  Next, all tags and branches must be cleaned with the following
   command:

::

   java -Dfile.encoding=utf-8 -jar svn-migration-scripts.jar clean-git --force

-  Once fully converted to Git locally, the repository can be imported
   to Bit Bucket via the "I have an existing project" commands given
   after creating a repo.

Importing
---------

-  Switch to your repository's directory
-  Connect your existing repository to Git

::

   git remote add origin https://login@<GIT-URL>/repositoryName.git
   git push -u origin master
   <pre>
   * You can now checkout this git repo from Bit Bucket remotely!
   * To test, cd to a different path and clone
   <pre>git clone https://login@<GIT-URL>/repositoryName.git

SVN to GitHub real world example
--------------------------------

-  Create directory for git clone

   -  mkdir gitbranch

-  Using a browser, login to www.github.com with login name and password
-  Click on "New repository" box
-  Click on "Create repository"
-  On cluster headnode, within git clone directory, run the following
   command:

   -  git clone https://\ [@]github.com//.git
   -  Enter password if requested - Note, username only needed for
      PRIVATE repo

-  Enter git branch

   -  cd

-  Initialize as a git svn repo

   -  git svn init --stdlayout --no-metadata

-  Modify git config for SVN repo settings

   -  git config --edit

::

         1 [core]
         2         repositoryformatversion = 0
         3         filemode = true
         4         bare = false
         5         logallrefupdates = true
         6 [remote "origin"]
         7         fetch = +refs/heads/*:refs/remotes/origin/*
         8         url = https://natalieawh@github.com/natalieawh/AtompawProject.g        it
         9 [branch "master"]
        10         remote = origin
        11         merge = refs/heads/master
        12 [svn-remote "svn"]
        13         noMetadata = 1
        14         url = <SVN-URL>
        15         fetch = trunk/<branch to convert>:refs/remotes/trunk/origin
        16         branches = branches/*/<branch to convert>:refs/remotes/origin/*
        17         tags = tags/*/<branch to convert>:refs/remotes/tags/origin/*

-  

   -  NOTE - Git 1.7 does not properly initial svn repo, "origin" must
      be added to "fetch," "branches" and "tags"

Note that the "origin" is critical.

-  After saving this file, then retrieve SVN data

   -  git svn fetch

-  After several minutes, there is a stream of file names and the files
   appear in the repository.
-  If multiple branches were retrieved, run bash command:

::

   /bin/bash
   for branch in `git branch -r |grep "branches/" |sed 's/ branches\///'` ; do
   git branch $branch refs/remotes/branches/$branch
   done
   for tag in `git branch -r |grep "tags/" |sed 's/ tags\///'` ; do
   git tag -a -m"Converting SVN tags" $tag refs/remotes/tags/$tag
   done

-  Push data to git

   -  git push --all origin
   -  get push --tags origin

See Also
========

-  https://www.atlassian.com/git/tutorials/migrating-overview

`Category:Quick Start </Category:Quick_Start>`__ `Category:Revision
Control </Category:Revision_Control>`__
