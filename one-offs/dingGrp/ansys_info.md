Download this file,

https://drive.google.com/file/d/11wnnI5DA7Vf4TUEMiS-ZUKE_jaDoC0gr/view?usp=sharing

and put it on the server in `/tmp`. For this example, I will assume everything is running out of the `/tmp` directory. Then execute these commands,

```sh
mkdir -p /tmp/ANSYSLICMAN_2024R2_LINX64
tar -xvf /tmp/ANSYSLICMAN_2024R2_LINX64.gz -C /tmp/ANSYSLICMAN_2024R2_LINX64
/tmp/ANSYSLICMAN_2024R2_LINX64/INSTALL -silent -LM -install_dir /tmp/ansys_inc
```

This will install the CLI manager in `/tmp/ansys_inc`. Now just execute these commands,

```sh
/tmp/ansys_inc/shared_files/licensing/linx64/lmutil lmhostid -hostname
/tmp/ansys_inc/shared_files/licensing/linx64/lmutil lmhostid -ether
```

and send the printed information to anderss@wfu.edu. You can now do final cleanup,

```sh
rm -rf /tmp/ANSYSLICMAN_2024R2_LINX64
rm -f  /tmp/ANSYSLICMAN_2024R2_LINX64.gz
rm -rf /tmp/ansys_inc
```
