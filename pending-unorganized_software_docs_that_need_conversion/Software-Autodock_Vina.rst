.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__
**AutoDock Vina** is a new generation of docking software from the
Molecular Graphics Lab. It achieves significant improvements in the
average accuracy of the binding mode predictions, while also being up to
two orders of magnitude faster than `AutoDock
4 </Software:Autodock>`__. [1]_

Versions
========

Installed on the cluster:

:\* **1.1.2**

Usage
=====

Load the module:

``    module load vina/1.1.2-intel-2012``

The executables are:

-  vina
-  vina_split

Compiling
=========

-  Note: the following procedures are still valid for intel-2017
   compiler with boost-1.64.0, just change BOOST_VERSION variable
   accordingly.

AutoDock Vina depends on the `Boost C++ Libraries </Software:Boost>`__.

| ``    module load boost/1.54.0-intel-2012``
| ``    tar zxf autodock_vina_1_1_2.tgz``
| ``    cd autodock_vina_1_1_2/build/linux/release``
| ``    ``

Edit source code. Patch file:

::

   diff -Naur autodock_vina_1_1_2/build/linux/release/Makefile autodock_vina_1_1_2-deac/build/linux/release/Makefile
   --- autodock_vina_1_1_2/build/linux/release/Makefile    2011-05-11 16:35:13.000000000 -0400
   +++ autodock_vina_1_1_2-deac/build/linux/release/Makefile   2013-07-17 12:06:25.003557000 -0400
   @@ -1,9 +1,9 @@
   -BASE=/usr/local
   -BOOST_VERSION=1_41
   -BOOST_INCLUDE = $(BASE)/include
   -C_PLATFORM=-static -pthread
   -GPP=/usr/local/bin/g++
   -C_OPTIONS= -O3 -DNDEBUG
   +BASE=$(BOOST_DIR)
   +BOOST_VERSION=1_54
   +BOOST_INCLUDE = $(BOOST_INCDIR)
   +C_PLATFORM=-pthread
   +GPP=icpc
   +C_OPTIONS= -O3 -xSSE4.1 -ipo
    BOOST_LIB_VERSION=

    include ../../makefile_common
   diff -Naur autodock_vina_1_1_2/build/makefile_common autodock_vina_1_1_2-deac/build/makefile_common
   --- autodock_vina_1_1_2/build/makefile_common   2011-05-11 16:35:13.000000000 -0400
   +++ autodock_vina_1_1_2-deac/build/makefile_common  2013-07-17 12:10:30.716675000 -0400
   @@ -2,15 +2,15 @@
    MAINOBJ = main.o
    SPLITOBJ = split.o

   -INCFLAGS = -I $(BOOST_INCLUDE)
   +INCFLAGS = -I$(BOOST_INCLUDE)

    # -pedantic fails on Mac with Boost 1.41 (syntax problems in their headers)
    #CC = ${GPP} ${C_PLATFORM} -ansi -pedantic -Wno-long-long ${C_OPTIONS} $(INCFLAGS)
   -CC = ${GPP} ${C_PLATFORM} -ansi -Wno-long-long ${C_OPTIONS} $(INCFLAGS)
   +CC = ${GPP} ${C_PLATFORM} -ansi ${C_OPTIONS} $(INCFLAGS)

   -LDFLAGS = -L$(BASE)/lib -L.
   +LDFLAGS = -L$(BASE)/lib -Wl,-rpath,$(BASE)/lib -Wl,-rpath,.

   -LIBS = -l boost_system${BOOST_LIB_VERSION} -l boost_thread${BOOST_LIB_VERSION} -l boost_serialization${BOOST_LIB_VERSION} -l boost_filesystem${BOOST_LIB_VERSION} -l boost_program_options${BOOST_LIB_VERSION}#-l pthread
   +LIBS = -lboost_system${BOOST_LIB_VERSION} -lboost_thread${BOOST_LIB_VERSION} -lboost_serialization${BOOST_LIB_VERSION} -lboost_filesystem${BOOST_LIB_VERSION} -lboost_program_options${BOOST_LIB_VERSION}#-l pthread

    .SUFFIXES: .cpp .o

   diff -Naur autodock_vina_1_1_2/src/lib/quaternion.cpp autodock_vina_1_1_2-deac/src/lib/quaternion.cpp
   --- autodock_vina_1_1_2/src/lib/quaternion.cpp  2011-05-11 16:35:00.000000000 -0400
   +++ autodock_vina_1_1_2-deac/src/lib/quaternion.cpp 2013-07-17 11:55:10.980025000 -0400
   @@ -22,6 +22,10 @@

    #include "quaternion.h"

   +fl quaternion_norm_sqr(const qt& q) { // equivalent to sqr(boost::math::abs(const qt&))
   +   return sqr(q.R_component_1()) + sqr(q.R_component_2()) + sqr(q.R_component_3()) + sqr(q.R_component_4());
   +}
   +
    bool quaternion_is_normalized(const qt& q) { // not in the interface, used in assertions
       return eq(quaternion_norm_sqr(q), 1) && eq(boost::math::abs(q), 1);
    }
   diff -Naur autodock_vina_1_1_2/src/lib/quaternion.h autodock_vina_1_1_2-deac/src/lib/quaternion.h
   --- autodock_vina_1_1_2/src/lib/quaternion.h    2011-05-11 16:35:00.000000000 -0400
   +++ autodock_vina_1_1_2-deac/src/lib/quaternion.h   2013-07-17 11:51:52.383029000 -0400
   @@ -31,6 +31,9 @@

    typedef boost::math::quaternion<fl> qt;

   +fl quaternion_norm_sqr(const qt& q);
   +bool quaternion_is_normalized(const qt& q);
   +
    // non-intrusive free function split serialization
    namespace boost {
       namespace serialization {
   @@ -66,10 +69,6 @@
    vec quaternion_to_angle(const qt& q);
    mat quaternion_to_r3(const qt& q);

   -inline fl quaternion_norm_sqr(const qt& q) { // equivalent to sqr(boost::math::abs(const qt&))
   -   return sqr(q.R_component_1()) + sqr(q.R_component_2()) + sqr(q.R_component_3()) + sqr(q.R_component_4());
   -}
   -
    inline void quaternion_normalize(qt& q) {
       const fl s = quaternion_norm_sqr(q);
       assert(eq(s, sqr(boost::math::abs(q))));
   diff -Naur autodock_vina_1_1_2/src/main/main.cpp autodock_vina_1_1_2-deac/src/main/main.cpp
   --- autodock_vina_1_1_2/src/main/main.cpp   2011-05-11 16:35:00.000000000 -0400
   +++ autodock_vina_1_1_2-deac/src/main/main.cpp  2013-07-17 11:42:37.215905048 -0400
   @@ -47,7 +47,8 @@
    using boost::filesystem::path;

    path make_path(const std::string& str) {
   -   return path(str, boost::filesystem::native);
   +   //return path(str, boost::filesystem::native);
   +   return path(str);
    }

    void doing(int verbosity, const std::string& str, tee& log) {
   @@ -661,7 +662,7 @@
                       cpu, seed, verbosity, max_modes_sz, energy_range, log);
       }
       catch(file_error& e) {
   -       std::cerr << "\n\nError: could not open \"" << e.name.native_file_string() << "\" for " << (e.in ? "reading" : "writing") << ".\n";
   +       std::cerr << "\n\nError: could not open \"" << e.name.native() << "\" for " << (e.in ? "reading" : "writing") << ".\n";
           return 1;
       }
       catch(boost::filesystem::filesystem_error& e) {
   @@ -673,7 +674,7 @@
           return 1;
       }
       catch(parse_error& e) {
   -       std::cerr << "\n\nParse error on line " << e.line << " in file \"" << e.file.native_file_string() << "\": " << e.reason << '\n';
   +       std::cerr << "\n\nParse error on line " << e.line << " in file \"" << e.file.native() << "\": " << e.reason << '\n';
           return 1;
       }
       catch(std::bad_alloc&) {
   diff -Naur autodock_vina_1_1_2/src/split/split.cpp autodock_vina_1_1_2-deac/src/split/split.cpp
   --- autodock_vina_1_1_2/src/split/split.cpp 2011-05-11 16:35:00.000000000 -0400
   +++ autodock_vina_1_1_2-deac/src/split/split.cpp    2013-07-17 11:59:51.386107000 -0400
   @@ -38,7 +38,8 @@
    using boost::filesystem::path;

    path make_path(const std::string& str) {
   -   return path(str, boost::filesystem::native);
   +   //return path(str, boost::filesystem::native);
   +   return path(str);
    }

    std::string default_prefix(const std::string& input_name, const std::string& add) {
   @@ -208,7 +209,7 @@
           write_multimodel_pdbqt(tmp, ligand_prefix, flex_prefix);
       }
       catch(file_error& e) {
   -       std::cerr << "\n\nError: could not open \"" << e.name.native_file_string() << "\" for " << (e.in ? "reading" : "writing") << ".\n";
   +       std::cerr << "\n\nError: could not open \"" << e.name.native() << "\" for " << (e.in ? "reading" : "writing") << ".\n";
           return 1;
       }
       catch(boost::filesystem::filesystem_error& e) {
   @@ -220,7 +221,7 @@
           return 1;
       }
       catch(parse_error& e) {
   -       std::cerr << "\n\nParse error on line " << e.line << " in file \"" << e.file.native_file_string() << "\": " << e.reason << '\n';
   +       std::cerr << "\n\nParse error on line " << e.line << " in file \"" << e.file.native() << "\": " << e.reason << '\n';
           return 1;
       }
       catch(std::bad_alloc&) {

References
==========

.. raw:: html

   <references/>

.. [1]
   `AutoDock Vina Web Site <http://vina.scripps.edu/>`__
