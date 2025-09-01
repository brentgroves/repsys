<https://linuxcontainers.org/distrobuilder/introduction/>

First, we need to install lxd-imagebuilder

`sudo snap install lxd-imagebuilder --classic --edge`

```bash
sudo lxd-imagebuilder repack-windows Win11_24H2_English_x64.iso win11.lxd.iso

sudo lxd-imagebuilder repack-windows SERVER_EVAL_x64FRE_en-us.iso wins22.lxd.iso
```

ⓘYou might get a message “Required tool “hivexregedit” is missing” and “Required tool “wimlib-imagex” is missing”. You can easily install all the needed dependencies using the following command: `sudo apt-get install -y --no-install-recommends genisoimage libwin-hivex-perl rsync wimtools`

ⓘYou might also get a message “failed to create overlay” depending on the file system you use. This does not hinder the process, rather it will just do things the alternative way which may take a few min longer
