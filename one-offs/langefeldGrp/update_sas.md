# How to Renwew SAS 9.4

0. Read this document: https://support.sas.com/documentation/installcenter/en/ikunixplannedri/66610/PDF/default/setinit_planned.pdf
1. Launch a remote desktop in OOD.
2. When you are in the desktop, launch a terminal.
3. If you are not `anderss` or part of the `sasUsr` group, add yourself temporarily: `sudo gpasswd --add $USER sasUsr`
3. Load the SAS module: `module load apps/sas/9.4`.
4. Run the following command: `bash $SASHOME/SASDeploymentManager/9.4/sasdm.sh`.
5. Click through the dialog buttons for renewing the license, and provide it with the SID file for the new license.
