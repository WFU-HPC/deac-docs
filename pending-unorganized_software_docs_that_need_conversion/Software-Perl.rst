.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Languages </Category:Languages>`__
This article is not intended to teach you how to use Perl. Rather, it
provides tips, tricks and information.

Perl Oneliners
==============

Most useful for least amount of code/knowledge

'''perl -p -i -e 's/foo/bar/g' \* ''' Replaces foo with bar in every
file in your current directory.

Perl Philosophy
===============

In general Perl is a permissive language, and the Perl motto is "There
is more than one way to do it". As a consequence perl code can be easy
to write, but sometimes hard to read, as you may know 3 ways to do
something, but not recognize the way that someone else used. In general,
knowing enough about perl to guess what the program is doing+decent
comments+a good a search engine should make unraveling someone else's
work not too bad. The goal of this page is to teach you enough to get by
and to introduce you to a few examples.

Data Types
==========

Perl has two primary data types, scalars and arrays. It has others, but
they're more complicated and less important. Data types in perl are
always easy to recognize because they always wear a nametag called a
sigil. For $calars the sigil is $ and for @rrays the sigil is @. So if
you see a perl variable that begins with a $, it's a scalar, and
similarly if it starts with @ it's an array.

======== ======
Scalars  Arrays
======== ======
$a       @a
$dir[$i] @fred
======== ======

You can have a scalar $a and an array @a that have no relationship to
each other. It may confuse humans, but it won't confuse perl. If your
code is not intended to be read or used by humans, then this naming
scheme is acceptable, otherwise try and name your variables less
cryptically.

File I/O
========

open files with **open FILEHANDLE, "operation", "filename";** (i.e. open
POSITION, "<", "positions.txt" would open a file positions.txt for
reading, and I would use the handle POSITION to refer to that file in my
own code)

**@lines=** would then save each line of the file positions.txt to an
element in the array @lines.

| To write to a file, use '''open OUTPUT, ">", newpositions.txt;
| print OUTPUT "This will get printed into newpositions.txt" '''

Regular expressions
===================

Much of the power of perl comes from it's regular expression engine.
Regular expressions are a fancy way of allowing perl to look for
patterns in text files.

Regular expressions allow you to find and/or replace given patterns in a
file. This is great for extracting one or more desired final properties
out of an output file produced by some code. It's also useful for
setting up approximately the same, but slightly different input files.

There are two basic operations match, and substitute: $string =~
m/sought_text/; $string =~ s/sought_text/text_to_replace_it_with/;

The text you're seeking doesn't have to be completely literal, and can
be represented with wildcards, some of which are shown here

Wildcards

-  . Match any character
-  \\w Match "word" character (alphanumeric plus "_")
-  \\W Match non-word character
-  \\s Match whitespace character
-  \\S Match non-whitespace character
-  \\d Match digit character
-  \\D Match non-digit character
-  \\t Match tab
-  \\n Match newline

Quantifiers

-  \* Match 0 or more times
-  + Match 1 or more times
-  ? Match 1 or 0 times
-  {n} Match exactly n times
-  {n,} Match at least n times
-  {n,m} Match at least n but not more than m times

More on regular
expressions.\ `1 <http://www.troubleshooters.com/codecorn/littperl/perlreg.htm>`__

Perl + linux
============

| Perl also plays very nicely with linux/unix environments. System
  commands can be run using either system("do something") or by
  enclosing the command in backticks. If you wanted to store all the
  filenames in your current directory, you could just type
  **@files=`ls\`**.
| A point of warning, system(" ") and \`\` will in general start a new
  subshell each time you invoke them. So system(cd ../../); system(ls);
  won't give you the files from two directories up, it will give you the
  files from the directory you ran the script in. Use system("cd ../../;
  ls") to get the files from two directories up.

Pragmas
=======

You can modify the behavior of your perl script by invoking various
pragmas. In practice, **use warnings** gives better error messages and
**use strict** will force you to follow some slightly better programming
habits (useful for long codes/anything that has to be maintained). A
more complete list of pragmas and their descriptions is available
online. `2 <http://perldoc.perl.org/index-pragmas.html>`__

CPAN
====

One of the nice things about perl is its ability to be extended by
modules. These modules can be downloaded and installed via a module
called CPAN.

Installation
------------

-  In order to set up your own local version of cpan, download the
   source (currently available at
   http://search.cpan.org/~andk/CPAN-1.9800/lib/CPAN.pm).
-  Untar/unzip it,
-  cd into the resulting directory
-  issue the command **perl Makefile.PL PREFIX=${HOME}/perl5
   LIB=${HOME}/perl5**.
-  Now for bash-like shells use:

..

   ::

      cat >> ${HOME}/.bashrc << EOF
      export PERL_LOCAL_LIB_ROOT=${HOME}/perl5
      export PERL_MB_OPT="--install_base ${HOME}/perl5"
      export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"
      export PERL5LIB=${HOME}/perl5/lib/x86_64-linux-thread-multi:${HOME}/perl5/lib/perl5:${PERL5LIB}
      export PATH=${HOME}/perl5/bin:${PATH}
      EOF

:\* The syntax will be slightly different (change export to setenv) for
tcsh/csh derived shells.

-  Source your .bashrc file with the command **source ~/.bashrc**
-  Now open cpan by typing **cpan**.

-  When it asks what configuration you want choose local::lib, which
   will install your modules in the ~/perl5 directory and link to them
   automagically.

Include modules in your perl scripts by putting use ModuleName at the
beginning of your script. (i.e. use PDL to add matlab-like functionality
to perl).
