# **[Windows 11 Desktop or Server](https://ubuntu.com/tutorials/how-to-install-a-windows-11-vm-using-lxd#1-overview)**

## note

Run this from vendor network unless virus software is installed.

If you are using a Linux environment but want to run a Windows 11 virtual machine, you can easily do so using LXD. Windows 11 is somewhat strict in its requirements (needs UEFI SecureBoot, having a TPM, and having a modern CPU), but LXD supports that out of the box, and there’s no need for any complex configuration in order to enable a Windows VM. In this tutorial, we will walk through the process of installing Windows in an LXD virtual machine. We will be installing Windows 11, but the same procedure also applies to Windows server machines.

## What you’ll learn

- How to repackage an ISO image with lxd-imagebuilder
- How to install a Windows VM

## What you’ll need

Ubuntu Desktop 20.04 or above
LXD snap (version 5.0 or above) installed and running
Some basic command-line knowledge

## 2. Prepare your Windows image

To start, we need to **[download a Windows 11 Disk Image (ISO)](https://www.microsoft.com/software-download/windows11)** from the official website.
**[server version](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022)**

To proceed with the installation, we need to prepare the downloaded image, by repackaging it with a tool called lxd-imagebuilder. lxd-imagebuilder is an image-building tool for LXC and LXD, used to build all our official images.

First, we need to install lxd-imagebuilder

`sudo snap install lxd-imagebuilder --classic --edge`

Then we need to locate our downloads directory and find our Windows 11 ISO file

```bash
cd Downloads/
ls Win11_24H2_English_x64.iso
ls SERVER_EVAL_x64FRE_en-us.iso
```

We can then repackage the file, and give it a new file name (let’s call it “win11.lxd.iso”)

This needs to be run as root

```bash
sudo lxd-imagebuilder repack-windows Win11_24H2_English_x64.iso win11.lxd.iso

sudo lxd-imagebuilder repack-windows SERVER_EVAL_x64FRE_en-us.iso wins22.lxd.iso
```

ⓘYou might get a message “Required tool “hivexregedit” is missing” and “Required tool “wimlib-imagex” is missing”. You can easily install all the needed dependencies using the following command: `sudo apt-get install -y --no-install-recommends genisoimage libwin-hivex-perl rsync wimtools`

ⓘYou might also get a message “failed to create overlay” depending on the file system you use. This does not hinder the process, rather it will just do things the alternative way which may take a few min longer

The result is a new ISO image that will work seamlessly with LXD.

We can now locate the new ISO file

```bash
ls -lh win11.lxd.iso
ls -lh wins22.lxd.iso          
-rw-r--r-- 1 root root 4.8G Aug 11 18:21 wins22.lxd.iso

```

## 3. Create a new VM

After we create the Windows image, We can create a new empty VM that we can call ”win11”

```bash
lxc init win11 --vm --empty
```

The default storage/disk provided to new VMs is 10GB, which is not enough for Windows so we need to increase the size of the disk to 50GB with the following command before proceeding

```bash
df -T
Filesystem     Type      Size  Used Avail Use% Mounted on
tmpfs          tmpfs     1.6G  3.1M  1.6G   1% /run
/dev/nvme0n1p2 ext4      468G   70G  374G  16% /
tmpfs          tmpfs     7.6G  155M  7.4G   3% /dev/shm
tmpfs          tmpfs     5.0M   12K  5.0M   1% /run/lock
efivarfs       efivarfs  438K  303K  131K  70% /sys/firmware/efi/efivars
/dev/nvme0n1p1 vfat      1.1G  6.2M  1.1G   1% /boot/efi
tmpfs          tmpfs     1.6G  148K  1.6G   1% /run/user/1000
tmpfs          tmpfs     1.0M     0  1.0M   0% /var/snap/lxd/common/ns


# lxc config device override win11 root size=50GiB
lxc config device override win11 root size=120GiB
Device root overridden for win11

We should also increase the CPU limits for optimal performance

lxc config set win11 limits.cpu=4 limits.memory=8GiB
```

Next, we need to add TPM (Trusted Platform Module) as it’s one of the things Windows requires. We can call it vtpm as it is a virtual TPM after all. Adding TPM will also enable you to enable things like bitlocker inside of your VM.

A virtual Trusted Platform Module (vTPM) is a software-based emulation of a physical Trusted Platform Module (TPM) chip, providing the same security functionalities within a virtualized environment. It allows virtual machines to leverage hardware-based security features like key storage and remote attestation without needing a dedicated physical TPM.

```bash
lxc config device add win11 vtpm tpm path=/dev/tpm0
Device vtpm added to win11
```

To install ceph driver we need to disable secure boot.

```bash
lxc config set win11 security.secureboot=false
lxc config get win11 security.secureboot
false
lxc config uefi show win11
# no uefi variables yet
...
SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44:
    data: "01"
    attr: 3
    timestamp: ""
    digest: ""
```

The last thing we need to do is add the install media Itself and make it a boot priority (so it boots automatically).

If you are doing this in a cluster, make sure to launch this commands on the same member where the targeted instance is placed. You can check this with lxc info win11

```bash
lxc config device add win11 install disk source=/home/brent/Downloads/win11.lxd.iso boot.priority=10
Device install added to win11
```

Now we can start the installer.

ⓘYou will need to manually provide a VGA console access by installing either remote-viewer or spicy. If neither of these is found in the system, you will get a message instructing you to install them.

```bash
# quickly press any to boot from cd
lxc start win11 --console=vga
# start install process
# we disconnect several times during process run lxc console
lxc console win11c --type=vga 
```

If needed, install a Spice client as prompted:

`sudo apt-get install -y --no-install-recommends virt-viewer`

## 4. Install Windows

You should now see the Windows installer screen.

![i1](https://lh4.googleusercontent.com/TPGhAj1s0mdLxWVWJA61U1hKfzGvn2PxcexmgCRGofOf4FTM-RLSjycLyUKfapgWCKevEd-qL2Y8AfEI_Rdr44Npoh6JM3CNbf98Uw1Z4saXj_wAX89ZOYIX84LJxgZHKU02za8puz-XlAlnlA)

You can select “I don’t have a key” (or add a key if you have one), select Windows 11 Pro, select the option Custom: Install Windows Pro only (Custom/advanced) and click install.

![i2](https://lh5.googleusercontent.com/-1GZJKu8th67c1L3nPkGKV42d9laRGTrhwqIvTtTxRP8pKVI0uYGS2NB5COJ-4zLb42TQg_qiMKN39WXbihl6kRWA4JJCrCjjxI9P0xvaV9eHoOGyRjJVQr17hq_n91fm3iL8RI_XHVzGRgYxg)

The installation will take some time.

![i3](https://lh4.googleusercontent.com/5oVbkYDGEF_d4hMADl2eLsGyMjMRO-1gyA0L3QUdTRINbcqigQQJOLGQaI5iHMsyzXDAoDmBHeq87Y1mSdjykoUxVI_98zY-hDHGkBOejHPDJ9v88TxqmyWaifPBvcKiN1OASMCQtmrCP_rrSA)

Once the first stage is done, you will need to restart. That will close the terminal for the console, so you need to open it again.

`lxc console win11 --type=vga`

This will now look like a regular Windows installation process. You will see a boot window with “getting ready”. If it needs to reboot again, just run the command above.

You will get another standard setup screen, choose your options (date format, keyboard layout etc.) or skip through it.

![i4](https://lh5.googleusercontent.com/hywd6kdwOskInsSf99d4py3mnreVmsms_-fkdTtGT6lopLEY0iazE-SK1mDDK1la39n0naruuWz06fUFNJQalViPUYzpnRakneO4KSkaBhevdVoCM86Eow4PQfIabkA1P-ijZ6COiXaJDUKM0Q)

Now it will look for updates. This will take some time.

![i5](https://lh5.googleusercontent.com/Ui5uF-_v6f7dYcY7abvroXt_tC3DKl8t27uo1bKWHyM9_7YsSKEMJtiFmwqv3oEb183cNZQWYB2NN3uBK5SUPbJRpo4azM2ld9hy_2dQBQwsGTCamwElsYSpiOoQ-eioypVM9nD2wX5dQTVZeg)

Once completed, it will restart again so attach to the console again. The installer will show up once again and complete the process.

`lxc console win11 --type=vga`

## 5. Additional information

Now you have your Windows 11 VM up and running, and you can use it in any way you’d like. For faster boots, the ISO can be removed once the installation process is over.

`lxc config device remove win11 install`

## 5. can create a faster boot image

video 12:34

### template for new instances

Then you won't have to go through the install process.

- run disk prep to make windows images
- run sys prep
- shut down vm
- publish as an image

## 5.1

<https://www.youtube.com/watch?v=A50D8Osh348&t=426s>

- at bottom of windows start typing activation settings
- in activation settings choose change product key
- paste new key in
- click activate

## 6. That’s all

Now you’ve learned how you can set up and run a Windows 11 virtual machine using LXD. Additional information on how to do image repacking with lxd-imagebuilder can be found here.

If you’d like to watch a video walk-through, you can find it here.

If you’d like to read more about LXD virtual machines, read this **[blog](https://ubuntu.com/blog/lxd-virtual-machines-an-overview)**.

For more about LXD in general, take a look at the following resources:

LXD webpage

Documentation Page

If you have further questions or need help, you can get help here:

**[Discussion forum](https://discourse.ubuntu.com/c/lxd/126?_gl=1*1s718h5*_gcl_au*MTcwMzEzOTMxMC4xNzUzMTIxNDg4)**
