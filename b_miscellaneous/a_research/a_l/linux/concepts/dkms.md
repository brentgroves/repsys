# **[DKMS](https://wiki.ubuntu.com/Kernel/Dev/DKMSPackaging)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[DKMS](https://wiki.ubuntu.com/Kernel/Dev/DKMSPackaging)**
- **[DKMS wiki](<https://en.wikipedia.org/wiki/Dynamic_Kernel_Module_Support#:~:text=Dynamic%20Kernel%20Module%20Support%20(DKMS,Dynamic%20Kernel%20Module%20Support)>**

## What is DKMS

dkms is a framework which allows kernel modules to be dynamically built for each kernel on your system in a simplified and organized fashion.

This page will show you how to build an DKMS deb package.

![](https://wiki.ubuntu.com/Kernel/Dev/DKMSPackaging?action=AttachFile&do=get&target=dkms.png)

Dynamic Kernel Module Support (DKMS) is a Linux framework that helps manage and install kernel modules that are external to the standard kernel distribution. These modules are often from hardware vendors and can add functionality to the Linux kernel, such as a hardware driver. DKMS has several benefits, including:\
**Compatibility**\
DKMS is compatible with most Linux distributions and monitors the system for kernel updates. When a new kernel is installed, DKMS automatically rebuilds the external modules using the latest kernel headers to ensure compatibility.\
**Convenience**\
DKMS is a convenient way to install additional drivers that are outside of the kernel tree.
However, DKMS also has some potential drawbacks, including:\
**Additional handling**\
Resident modules may require additional handling.
**Source code**\
Source code for NVIDIA-like modules with blob parts may not be convenient to deliver with DKMS.
**Module building**\
DKMS may not build a module if its function names have changed or if there are changes in how the kernel interacts with its components.
**Installation**\
DKMS doesn't guarantee proper installation if the kernel application binary interface changes.

## Prepare source

Prepare your kernel module source. It contains the C file and its Makefile at least. The following is an hello world kernel module as an example

```c
#include <linux/kernel.h>
#include <linux/module.h>

static int __init hello_init(void)
{
        pr_info("Hello world.\n");
        return 0;
}

static void __exit hello_exit(void)
{
        pr_info("Goodbye world.\n");
}

module_init(hello_init);
module_exit(hello_exit);
```

Kernel modules location.

```bash
ls /lib/modules/        
5.15.0-43-generic  6.2.0-32-generic  6.2.0-35-generic  6.2.0-39-generic  6.5.0-17-generic  6.5.0-25-generic  6.5.0-28-generic  6.5.0-44-generic
6.2.0-26-generic   6.2.0-33-generic  6.2.0-36-generic  6.5.0-14-generic  6.5.0-18-generic  6.5.0-26-generic  6.5.0-35-generic  6.5.0-45-generic
6.2.0-31-generic   6.2.0-34-generic  6.2.0-37-generic  6.5.0-15-generic  6.5.0-21-generic  6.5.0-27-generic  6.5.0-41-generic  6.8.0-40-generic

uname -r      
6.8.0-40-generic

ls /lib/modules/6.8.0-40-generic 
build   kernel         modules.alias.bin  modules.builtin.alias.bin  modules.builtin.modinfo  modules.dep.bin  modules.order    modules.symbols      vdso
initrd  modules.alias  modules.builtin    modules.builtin.bin        modules.dep              modules.devname  modules.softdep  modules.symbols.bin

ls /lib/modules/6.8.0-40-generic/build
arch   certs   Documentation  fs       init      ipc     Kconfig  lib       mm              net   samples  security  tools   usr
block  crypto  drivers        include  io_uring  Kbuild  kernel   Makefile  Module.symvers  rust  scripts  sound     ubuntu  virt
```

The following is its Makefile as example.

```make
obj-m := hello.o
KVERSION := $(shell uname -r)

all:
        $(MAKE) -C /lib/modules/$(KVERSION)/build M=$(PWD) modules

clean:
        $(MAKE) -C /lib/modules/$(KVERSION)/build M=$(PWD) clean
```

Please use a variable to keep the kernel version we want to compile. In the above example, it is $(KVERSION). We usually run dkms build under the various kernel version, and the DKMS will pass the target kernel version to Makefile.

Please put your Makefile and source code at /usr/src/<module>-<module-version>. For example, I put above two files at /usr/src/hello-0.1

dkms.conf
Add dkms.conf and put it with your Makefile

Here is an example dkms.conf for hello-0.1

PACKAGE_NAME="hello"
PACKAGE_VERSION="0.1"
CLEAN="make clean"
MAKE[0]="make all KVERSION=$kernelver"
BUILT_MODULE_NAME[0]="hello"
DEST_MODULE_LOCATION[0]="/updates"
AUTOINSTALL="yes"
PACKAGE_NAME, PACKAGE_VERSION is necessary information, it shall be the same with the information or your folder name.

CLEAN is the command to clean up the folder. Every time before build, it will be executed. If unset, it is assumed to be "make clean"

MAKE[0] is the first command to build the kernel object. Since this is an example, this is the only command we have. This field tells DKMS how to build the kernel object, and we can pass the target kernel version by using $kernelver that DKMS provides us.

DEST_MODULE_LOCATION[0] tells DKMS where to put the kernel object when installing. In this example, the kernel object will be "/lib/modules/$kernelver/updates". In Ubuntu, this information will be overrade to "/updates/dkms". It means our kernel objects will be put at /lib/modules/$kernelver/updates/dkms". Although this information will be overrade, it is still a necessary field.

AUTOINSTALL set to yes means DKMS will try to build and install the kernel object when booting and it won't be re-built nor re-installed if the kernel object has been installed.

## DKMS commands

Now, use "dkms add" to tell DKMS we have a module is ready. DKMS will create symlink from /var/lib/dkms to /usr/src.

```bash
user@here:~$ sudo dkms add -m hello -v 0.1

Creating symlink /var/lib/dkms/hello/0.1/source ->
                 /usr/src/hello-0.1

DKMS: add Completed.

# Then, you can try to build this module with "DKMS build".

user@here:~$ sudo dkms build -m hello -v 0.1

Kernel preparation unnecessary for this kernel.  Skipping...

Building module:
cleaning build area....
su nobody -c "make KERNELRELEASE=4.4.0-57-generic -C /lib/modules/4.4.0-57-generic/build M=/var/lib/dkms/hello/0.1/build"....
cleaning build area....

DKMS: build Completed.

# And, you can install this module to the kernel module tree.

user@here:~$ sudo dkms install -m hello -v 0.1

hello.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.4.0-57-generic/updates/dkms/

depmod......

DKMS: install Completed.
# Then, you can see the kernel object has been add to your module tree

user@here:~$ ls -al /lib/modules/4.4.0-57-generic/updates/dkms/hello.ko
-rw-r--r-- 1 root root 3328 2009-11-11 11:19 /lib/modules/4.4.0-57-generic/updates/dkms/hello.ko
# And you can use it now.

user@here:~$ sudo modprobe hello
user@here:~$ dmesg | tail -1
[ 7328.183867] Hello world.
# If the module is useless for you, you can remove the module from DKMS. All files related to this module under /var/lib/dkms and /lib/modules will be removed.

user@here:~$ sudo dkms remove -m hello -v 0.1 --all
# You can also ask DKMS to build and install this module for another kernel version after "dkms add".

user@here:~# sudo dkms build -m hello -v 0.1 -k 4.4.0-57-generic

Kernel preparation unnecessary for this kernel.  Skipping...

Building module:
cleaning build area....
su nobody -c "make KERNELRELEASE=4.4.0-57-generic all KVERSION=4.4.0-57-generic"....
cleaning build area....

DKMS: build Completed.
user@here:~# dkms install -m hello -v 0.1 -k 4.4.0-57-generic

hello.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.4.0-57-generic/updates/dkms/

depmod....

DKMS: install Completed.
# It is also possible to build against multiple kernel versions.

user@here:~# sudo dkms build -m hello -v 0.1 -k 4.4.0-57-generic -k 4.4.0-58-generic
# The pre-built modules will be included in the DKMS deb made later. When the versions of the pre-built modules and the kernel on the target computer match, the pre-built modules will just be used rather than compiling on installation.
```

## Generate DKMS deb

Using "dkms mkdeb" to build deb package. You shall run "dkms mkdeb" after "dkms add" and "dkms build"

```bash
user@here:~$ sudo dkms mkdeb -m hello -v 0.1
Using /etc/dkms/template-dkms-mkdeb
copying template...
modifying debian/changelog...
modifying debian/compat...
modifying debian/control...
modifying debian/copyright...
modifying debian/dirs...
modifying debian/postinst...
modifying debian/prerm...
modifying debian/README.Debian...
modifying debian/rules...
copying legacy postinstall template...
Copying source tree...
Gathering binaries...Marking modules for 4.4.0-57-generic (x86_64) for archiving...

Creating special tarball structure to accomodate only binaries.


Tarball location: /var/lib/dkms/hello/0.1/tarball/hello-0.1.dkms.tar.gz

DKMS: mktarball Completed.

Copying DKMS tarball into DKMS tree...
Building binary package...dpkg-buildpackage: warning: using a gain-root-command while being root
 fakeroot debian/rules clean
 debian/rules build
 fakeroot debian/rules binary
 dpkg-genchanges -b >../hello-dkms_0.1_amd64.changes
dpkg-genchanges: binary-only upload - not including any source code


DKMS: mkdeb Completed.
Moving built files to /var/lib/dkms/hello/0.1/deb...
Cleaning up temporary files...
And you can have the deb package

user@here:~$ ls -al /var/lib/dkms/hello/0.1/deb/hello-dkms_0.1_all.deb
-rw-r--r-- 1 root root 5336 2009-11-11 13:50 /var/lib/dkms/hello/0.1/deb/hello-dkms_0.1_all.deb
with AUTOINSTALL=yes in dkms.conf, you can boot with various kernel and dkms will build the kernel module automatically for you.
```
