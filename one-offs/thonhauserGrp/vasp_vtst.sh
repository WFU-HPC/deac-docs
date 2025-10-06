# vtsttools vtst vasp for thonhauserGrp; made for DSS
# see https://theory.cm.utexas.edu/vtsttools/index.html

# download vtstcode
# wget --no-check-certificate https://theory.cm.utexas.edu/code/vtstcode-199.tgz -O /tmp/vtstcode-199.tgz
# tar -xf /tmp/vtstcode-199.tgz -C /tmp

wget --no-check-certificate https://theory.cm.utexas.edu/code/vtstcode-209.tgz -O /tmp/vtstcode-209.tgz
tar -xf /tmp/vtstcode-209.tgz -C /tmp

# extract vasp
tar -xf /deac/opt/tarballs/vasp/vasp.6.5.1.tgz -C /tmp

# backup files
cp /tmp/vasp.6.5.1/src/main.F  /tmp/vasp.6.5.1/src/main.F.bak
cp /tmp/vasp.6.5.1/src/chain.F /tmp/vasp.6.5.1/src/chain.F.bak
cp /tmp/vasp.6.5.1/src/.objects /tmp/vasp.6.5.1/src/.objects.bak
cp /tmp/vasp.6.5.1/src/makefile /tmp/vasp.6.5.1/src/makefile.bak

# cd /tmp
# diff -urN vasp.6.5.1 vasp.6.5.1.vtstcode/

# generate patch file (see https://theory.cm.utexas.edu/vtsttools/installation.html)
cat <<EOF > /tmp/vasp.6.5.1/vtstcode.patch
diff -urN vasp.6.5.1/src/main.F vasp.6.5.1.vtstcode/src/main.F
--- vasp.6.5.1/src/main.F	2024-03-19 05:18:08.000000000 -0400
+++ vasp.6.5.1.vtstcode/src/main.F	2024-07-03 13:59:21.336020202 -0400
@@ -963,7 +963,7 @@
 ! init all chains (INCAR reader)
 !-----------------------------------------------------------------------
       LCHAIN = IMAGES > 0 .AND. .NOT.AFQMC_SET % ACTIVE
-      IF (LCHAIN) CALL chain_init( T_INFO, IO)
+      CALL chain_init( T_INFO, IO)
 !-----------------------------------------------------------------------
 !xml finish copying parameters from INCAR to xml file
 ! no INCAR reading from here
@@ -3695,11 +3695,11 @@
             TOTEN,TOTEN-EENTROPY,TOTEN-EENTROPY/(2+NORDER)
       ENDIF

-      IF ( DYN%ISIF >= 3 ) THEN
-         CALL CHAIN_STRESS( TSIF )
-      END IF
+      ! IF ( DYN%ISIF >= 3 ) THEN
+      !    CALL CHAIN_STRESS( TSIF )
+      ! END IF
       CALL CHAIN_FORCE(T_INFO%NIONS,DYN%POSION,TOTEN,TIFOR, &
-           LATT_CUR%A,LATT_CUR%B,IO%IU6)
+           TSIF,LATT_CUR%A,LATT_CUR%B,IO%IU6)

       CALL PARALLEL_TEMPERING(NSTEP,T_INFO%NIONS,DYN%POSION,DYN%VEL,TOTEN,TIFOR,DYN%TEBEG,DYN%TEEND, &
            LATT_CUR%A,LATT_CUR%B,IO%IU6)
diff -urN vasp.6.5.1/src/makefile vasp.6.5.1.vtstcode/src/makefile
--- vasp.6.5.1/src/makefile	2024-03-19 05:18:07.000000000 -0400
+++ vasp.6.5.1.vtstcode/src/makefile	2024-07-03 13:58:35.785093946 -0400
@@ -16,7 +16,7 @@
 OFLAG=\$(OFLAG_2)
 OFLAG_IN=\$(OFLAG)

-LIB=lib parser
+LIB=lib parser pyamff_fortran
 LLIB=-Llib -ldmy -Lparser -lparser

 SRCDIR=../../src
@@ -150,7 +150,7 @@
 	\$(MAKE) -C \$@ -j1
 #	\$(MAKE) -C \$@

-dependencies: sources
+dependencies: sources libs
 	\$(MAKE) depend

 depend: \$(F90SRC)
diff -urN vasp.6.5.1/src/.objects vasp.6.5.1.vtstcode/src/.objects
--- vasp.6.5.1/src/.objects	2024-03-19 05:18:07.000000000 -0400
+++ vasp.6.5.1.vtstcode/src/.objects	2024-07-03 13:58:35.785093946 -0400
@@ -127,6 +127,10 @@
 	dos.o \\
 	elf.o \\
 	hamil_rot.o \\
+	bfgs.o dynmat.o instanton.o lbfgs.o sd.o cg.o dimer.o bbm.o \\
+	fire.o lanczos.o neb.o qm.o \\
+	pyamff_fortran/*.o ml_pyamff.o \\
+	opt.o \\
 	chain.o \\
 	dyna.o \\
 	fileio.o \\
EOF

# copy files from vtstcode to vasp source
# cp -r /tmp/vtstcode-199/vtstcode6.4/* /tmp/vasp.6.5.1/src/.
cp -r /tmp/vtstcode-209/vtstcode6.5.1/* /tmp/vasp.6.5.1/src/.

# patch the code
cd /tmp/vasp.6.5.1
patch -p1 -i vtstcode.patch

# now generate final tar file for use with DSS
cd /tmp
mv /tmp/vasp.6.5.1 /tmp/vasp.6.5.1.vtstcode
tar -czf /tmp/vasp.6.5.1.vtstcode.tgz ./vasp.6.5.1.vtstcode

# copy new tarball to /deac/opt/tarballs
cp /tmp/vasp.6.5.1.vtstcode.tgz /deac/opt/tarballs/vasp/vasp.6.5.1.vtstcode.tgz

# remove spurious files
cd $HOME
rm -rf /tmp/vasp.6.5.1* /tmp/vtstcode-209*

################################################################################
################################################################################

# vtst scripts
wget --no-check-certificate http://theory.cm.utexas.edu/code/vtstscripts.tgz -O /tmp/vtstscripts-1033.tgz
mkdir -p /deac/opt/rocky9-noarch/vasp
tar -xf /tmp/vtstscripts-1033.tgz -C /deac/opt/rocky9-noarch/vasp
chgrp -R vaspUsr /deac/opt/rocky9-noarch/vasp
rm -rf /tmp/vtstscripts-1033.tgz
# edit desired VASP modulefile to add /deac/opt/rocky9-noarch/vasp/vtstscripts-1033 to path!!!!
