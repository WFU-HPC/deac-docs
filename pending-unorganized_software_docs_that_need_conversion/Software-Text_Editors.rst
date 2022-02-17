.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__ `Category:New User
Information </Category:New_User_Information>`__

**Text editors**\  [1]_ allow you to edit plain text files. Most modern
text editors have features which help you write code, e.g. syntax
highlighting, auto-indenting, and parenthesis/brace-matching. There are
many editors to choose from, some with purely terminal interfaces, and
others with GUIs. [2]_ Using an editor with a terminal interface option
can be useful if you work remotely since the terminal interface is low
bandwidth.

Recommended Editors
===================

Vim
---

**Vim** is VI iMproved. [3]_ It is a version of the standard
terminal-based editor for Unix. It also has a GUI.

Vim is "modeful", i.e. it has two mutually exclusive modes:

#. edit mode
#. command mode

You can only enter text directly in edit mode. To move, copy, paste, and
perform other operations on the contents, you must be in command mode.
When you are in command mode, the commands you type may not be echoed
(visible). In contrast, modern editors are modeless.

It features syntax highlighting, and auto-indent. It is customizable
with a custom scripting language. To run, type **``vim``** at the
command line; for the GUI version, type **``gvim``**. A cheat sheet can
be found
`here <https://www.adminschoice.com/wp-content/uploads/2009/12/vi-editor-Cheat-Sheet.pdf>`__,
and more of a Tutorial
`here <http://www.linuxconfig.org/Vim_Tutorial>`__.

Vim is a powerful tool that looks great on a resume, and can quickly
help you modify text. It comes most highly recommended.

Gedit
-----

**gedit** is the official text editor of the GNOME desktop
environment. [4]_ It is a GUI editor with a modern interface (Ctrl-O to
open a file, etc.).

It features syntax highlighting, and auto-indent. To run, type
**``gedit``** at the command line, or launch from the applications menu
of the desktop.

Gedit is a basic editor (similar to Notepad) that enables people new to
the CLI the ability to edit files and work.

Other Editors
=============

CLI Based Editors
-----------------

Nano
~~~~

**N**\ ano’s **ANO**\ ther editor. [5]_ It is an enhanced free clone of
Pico, the editor included with the Pine email program. Amongst the
terminal-based editors, this is probably the easiest to use: it behaves
more or less like Notepad in Windows. It expands on Pico by providing
syntax highlighting, auto-indent, and other features useful for
programming.

To run, type **``nano``\ \ ``file``\ ** at the command line to edit
*file*. The online manual [6]_ provides extensive documentation.
Commonly used commands are listed at the bottom of the nano screen.
`Here is a
tutorial <http://pherricoxide.wordpress.com/2009/02/13/nano-text-editor-tutorial-for-programmers/>`__.

CLI Based
---------

Emacs
~~~~~

**Emacs** provides both a terminal interface, and a GUI. It is
feature-rich, and extensible: extensions can be written in a dialect of
LISP called Emacs Lisp.

It has syntax highlighting for most languages, and auto-indent. Its
keystroke commands are unlike modern conventions, e.g. rather than
Ctrl-O to open a file, it is Ctrl-X F.

To run, type **``emacs``** at the command line. It has a built-in
tutorial: access it by typing "Ctrl-H T". `Here is an online
tutorial. <http://ocean.stanford.edu/research/quick_emacs.html>`__

While its use is primarily through a GUI-based window, emacs does have a
terminal based editor mode which may automatically start if your **X11
Display** environment is not available or properly configured.

Kate
~~~~

**kate** is part of the KDE desktop project. [7]_ It is a modern GUI
editor, i.e. Ctrl-O to open a file, etc.

It has syntax highlighting, and auto-indent. To run, type **``kate``**
at the command line, or launch from the applications menu.

Nedit
~~~~~

**Nedit** is GUI-based editor for the X Window System. [8]_

It features syntax highlighting, and auto-indent. To run, type
**``nedit``** at the command line.

References
==========

.. raw:: html

   <references/>

.. [1]
   `"Text editor" article at
   Wikipedia <http://en.wikipedia.org/wiki/Text_editor>`__

.. [2]
   `"Comparison of text editors" article at
   Wikipedia <http://en.wikipedia.org/wiki/Comparison_of_text_editors>`__

.. [3]
   `Vim website <http://www.vim.org/>`__

.. [4]
   `gedit website <http://projects.gnome.org/gedit/>`__

.. [5]
   `Official Nano website <http://www.nano-editor.org/>`__

.. [6]
   `Nano online
   manual <http://www.nano-editor.org/dist/v2.2/nano.html>`__

.. [7]
   `Kate editor website <http://kate-editor.org/>`__

.. [8]
   `Nedit website <http://www.nedit.org/>`__
