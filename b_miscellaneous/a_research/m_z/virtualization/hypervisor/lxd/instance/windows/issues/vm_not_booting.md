# **[VM not booting/installing from Windows 11 multi-edition ISO](https://discuss.linuxcontainers.org/t/vm-not-booting-installing-from-windows-11-multi-edition-iso/17317)**

Libvirt/QEMU UEFI works fine on a 5.10.179-gentoo-dist kernel, and the portage version 5.0.2-r2’s LXD containers work for the most part other than a stubborn nvenc plex issue - for another time. The headless & unpriveleged LXD steam streaming container works very well, too. The distrobuilder process to repack-windows completes without error for the Windows 11 multi-edition ISO for x64 devices downloaded from <https://www.microsoft.com/en-us/software-download/windows11>

However, following Stephane’s instruction to include adjusted needs at <https://www.youtube.com/watch?v=3PDMGwbbk48> as:

```bash
lxc init win11 --vm --empty
lxc config set win11 limits.cpu=8 limits.memory=32GiB
lxc config device override win11 root size=100GiB
lxc config device add win11 install disk source=/nfs/ISO/lxd_repack-Win11_22H2_English_x64v1.iso boot.priority=10
lxc start win11 --console=vga
```

Pressing a key to start the Windows installation seems to hang the session with a single CPU holding 1 core at 100%. Escaping to the bootloader shows fs0:\efi\boot\bootx64.efi This is the same for the original ISO - not repacked.

I may I have read every post and guidance for LXD4 and LXD5 google has yielded. At this point I can’t seem to identify additional areas to continue to troubleshoot. Therefore, debugging hints or other troubleshooting guidance is greatly appreciated.

It seems there is a kernel bug triggered when using LXD/QEMU to boot Win11. No bug with Libvirt/QEMU

DMESG output:
[Thu Jun 1 15:53:36 2023] BUG: kernel NULL pointer dereference, address: 0000000000000000
[Thu Jun 1 15:53:36 2023] #PF: supervisor read access in kernel mode
[Thu Jun 1 15:53:36 2023] #PF: error_code(0x0000) - not-present page
[Thu Jun 1 15:53:36 2023] PGD 0 P4D 0
[Thu Jun 1 15:53:36 2023] Oops: 0000 [#17] SMP PTI
[Thu Jun 1 15:53:36 2023] CPU: 0 PID: 17965 Comm: qemu-system-x86 Tainted: P D O 5.10.179-gentoo-dist #1
[Thu Jun 1 15:53:36 2023] Hardware name: SuperMicro/To be filled by O.E.M., BIOS 5.6.5 06/18/2015
[Thu Jun 1 15:53:36 2023] RIP: 0010:find_first_bit+0x19/0x40
[Thu Jun 1 15:53:36 2023] Code: 5d 41 5e 41 5f c3 cc cc cc cc cc cc cc cc cc cc cc 48 85 f6 48 89 f0 74 2d 31 d2 eb 0d 48 83 c2 40 48 83 c7 08 48 39 c2 73 1c <48> 8b 0f 48 85 c9 74 eb f3 48 0f bc c9 48 01 d1 48 39 c8 48 0f 47
[Thu Jun 1 15:53:36 2023] RSP: 0018:ffffb33accd9fa68 EFLAGS: 00010246
[Thu Jun 1 15:53:36 2023] RAX: 0000000000000120 RBX: ffffb33b025a2000 RCX: 0000000000000000
[Thu Jun 1 15:53:36 2023] RDX: 0000000000000000 RSI: 0000000000000120 RDI: 0000000000000000
[Thu Jun 1 15:53:36 2023] RBP: 0000000000000000 R08: ffff962b13229ff8 R09: ffff962b13229ff8
[Thu Jun 1 15:53:36 2023] R10: 000000000000000e R11: 0000000000000420 R12: ffff962b13229ff8
[Thu Jun 1 15:53:36 2023] R13: 0000000000000323 R14: 0000000000000000 R15: 0000000000000000
[Thu Jun 1 15:53:36 2023] FS: 00007fda8e88d6c0(0000) GS:ffff9627df800000(0000) knlGS:fffff8027242a000
[Thu Jun 1 15:53:36 2023] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Jun 1 15:53:36 2023] CR2: 0000000000000000 CR3: 0000002af2a0c001 CR4: 00000000001726f0
[Thu Jun 1 15:53:36 2023] Call Trace:
[Thu Jun 1 15:53:36 2023] kvm_make_vcpus_request_mask+0x3a/0xf0 [kvm]
[Thu Jun 1 15:53:36 2023] kvm_hv_get_assist_page+0x8f8/0xb10 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_configure_mmu+0xd41/0x2560 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_configure_mmu+0x1f6e/0x2560 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_init_shadow_npt_mmu+0x1318/0x22c0 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_init_shadow_npt_mmu+0x168b/0x22c0 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_is_reserved_pfn+0xe/0x420 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_release_pfn_clean+0x22/0x40 [kvm]
[Thu Jun 1 15:53:36 2023] ? disallowed_hugepage_adjust+0x25b/0xab0 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_mmu_page_fault+0x67/0x600 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_lapic_reg_write+0xe8/0x670 [kvm]
[Thu Jun 1 15:53:36 2023] ? kvm_emulate_hypercall+0x25/0x540 [kvm]
[Thu Jun 1 15:53:36 2023] kvm_hv_hypercall+0x154/0x4d0 [kvm]
[Thu Jun 1 15:53:36 2023] ? pi_update_irte+0x200f/0x20a0 [kvm_intel]
[Thu Jun 1 15:53:36 2023] kvm_arch_vcpu_ioctl_run+0x657/0x15d0 [kvm]
[Thu Jun 1 15:53:36 2023] ? do_futex+0x47e/0xb40
[Thu Jun 1 15:53:36 2023] kvm_vcpu_block+0x510/0x9a0 [kvm]
[Thu Jun 1 15:53:36 2023] ? __fget_files+0x76/0xa0
[Thu Jun 1 15:53:36 2023]__x64_sys_ioctl+0x90/0xd0
[Thu Jun 1 15:53:36 2023] do_syscall_64+0x33/0x80
[Thu Jun 1 15:53:36 2023] entry_SYSCALL_64_after_hwframe+0x61/0xc6
[Thu Jun 1 15:53:36 2023] RIP: 0033:0x7fda909bdc7b
[Thu Jun 1 15:53:36 2023] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[Thu Jun 1 15:53:36 2023] RSP: 002b:00007fda8e88c6a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[Thu Jun 1 15:53:36 2023] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fda909bdc7b
[Thu Jun 1 15:53:36 2023] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001c
[Thu Jun 1 15:53:36 2023] RBP: 000055d84b3643f0 R08: 000055d849c97990 R09: 00000000ffffffff
[Thu Jun 1 15:53:36 2023] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[Thu Jun 1 15:53:36 2023] R13: 0000000000000007 R14: 00007fff42678ed0 R15: 00007fda8e08d000
[Thu Jun 1 15:53:37 2023] Modules linked in: isofs overlay udf crc_itu_t loop vhost_net macvtap macvlan tap tun nfsv3 nfs_acl cfg80211 rfkill veth nf_conntrack_netlink xt_addrtype br_netfilter bridge ebtable_filter ebtables ip6table_raw ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_raw iptable_mangle iptable_nat iptable_filter ip_tables vhost_vsock vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock fuse rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc nfs_ssc fscache nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc zram binfmt_misc intel_rapl_msr snd_hda_codec_hdmi intel_rapl_common sb_edac snd_hda_intel x86_pkg_temp_thermal snd_intel_dspcfg intel_powerclamp soundwire_intel soundwire_generic_allocation snd_soc_core kvm_intel snd_compress snd_pcm_dmaengine soundwire_cadence kvm snd_hda_codec nct6775 snd_hda_core hwmon_vid ac97_bus snd_hwdep irqbypass snd_pcm iTCO_wdt rapl snd_timer intel_pmc_bxt
[Thu Jun 1 15:53:37 2023] lm75 iTCO_vendor_support intel_cstate i2c_i801 snd soundcore intel_uncore coretemp pcspkr i2c_smbus lpc_ich zfs(PO) zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO) crct10dif_pclmul crc32_pclmul crc32c_intel spl(O) ghash_clmulni_intel mpt3sas igb nvme raid_class i2c_algo_bit scsi_transport_sas dca nvme_core wmi nvidia_drm(PO) drm_kms_helper cec nvidia_uvm(PO) nvidia_modeset(PO) nvidia(PO) drm
[Thu Jun 1 15:53:37 2023] CR2: 0000000000000000
[Thu Jun 1 15:53:37 2023] —[ end trace 15c1706e8c156914 ]—
[Thu Jun 1 15:53:37 2023] RIP: 0010:find_first_bit+0x19/0x40
[Thu Jun 1 15:53:37 2023] Code: 5d 41 5e 41 5f c3 cc cc cc cc cc cc cc cc cc cc cc 48 85 f6 48 89 f0 74 2d 31 d2 eb 0d 48 83 c2 40 48 83 c7 08 48 39 c2 73 1c <48> 8b 0f 48 85 c9 74 eb f3 48 0f bc c9 48 01 d1 48 39 c8 48 0f 47
[Thu Jun 1 15:53:37 2023] RSP: 0018:ffffb33acc9d7a68 EFLAGS: 00010246
[Thu Jun 1 15:53:37 2023] RAX: 0000000000000120 RBX: ffffb33acd231000 RCX: 0000000000000000
[Thu Jun 1 15:53:37 2023] RDX: 0000000000000000 RSI: 0000000000000120 RDI: 0000000000000000
[Thu Jun 1 15:53:37 2023] RBP: 0000000000000000 R08: ffff962919bdcff8 R09: ffff962919bdcff8
[Thu Jun 1 15:53:37 2023] R10: 000000000000000e R11: 0000000000000000 R12: ffff962919bdcff8
[Thu Jun 1 15:53:37 2023] R13: 0000000000000323 R14: 0000000000000000 R15: 0000000000000000
[Thu Jun 1 15:53:37 2023] FS: 00007fda8e88d6c0(0000) GS:ffff9627df800000(0000) knlGS:fffff8027242a000
[Thu Jun 1 15:53:37 2023] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Jun 1 15:53:37 2023] CR2: 0000000000000000 CR3: 0000002af2a0c001 CR4: 00000000001726f0

LXD and libvirt enables different QEMU flags which might be why you are hitting that kernel/kvm issue.

Run **[FreeBSD 13.1 / OPNsense 22.7 / pfSense 2.7.0 (and newer?) under LXD VM](https://discuss.linuxcontainers.org/t/run-freebsd-13-1-opnsense-22-7-pfsense-2-7-0-and-newer-under-lxd-vm/15799)** contains some ideas on things to try. I’d start by trying the -cpu host trick first and see if that fares better.

Since this topic seems more of a black box and I am not married to 5.10, I opted to revert to kernel 5.4.242 which doesn’t seem to have said issue…

If you want to compare how QEMU is invoked, you can peak at LXD’s config by inspecting the args passed to QEMU with ps aux | grep qemu and also looking at the QEMU config file that lives at /var/snap/lxd/common/lxd/logs/<NAME>/qemu.conf.

We see that hv_passthrough is used for the -cpu which is one key difference from libvirt’s default:

/snap/lxd/24918/bin/qemu-system-x86_64 -S -name juju-lxd -uuid 83a8be7b-f64f-4537-9a3f-8d1af7edaf1c -daemonize -cpu host,hv_passthrough -nographic -serial chardev:console -nodefaults -no-user-config -sandbox on,obsolete=deny,elevateprivileges=allow,spawn=allow,resourcecontrol=deny -readconfig /var/snap/lxd/common/lxd/logs/juju-lxd/qemu.conf -spice unix=on,disable-ticketing=on,addr=/var/snap/lxd/common/lxd/logs/juju-lxd/qemu.spice -pidfile /var/snap/lxd/common/lxd/logs/juju-lxd/qemu.pid -D /var/snap/lxd/common/lxd/logs/juju-lxd/qemu.log -smbios type=2,manufacturer=Canonical Ltd.,product=LXD -runas lxd

And LXD uses a modern machine q35 model and uses UEFI, both also not what libvirt does by default:

```bash
$ sudo cat /var/snap/lxd/common/lxd/logs/juju-lxd/qemu.conf
# Machine
[machine]
graphics = "off"
type = "q35"
accel = "kvm"
usb = "off"

[global]
driver = "ICH9-LPC"
property = "disable_s3"
value = "1"

[global]
driver = "ICH9-LPC"
property = "disable_s4"
value = "1"

[boot-opts]
strict = "on"

# Memory
[memory]
size = "10240M"

# CPU
[smp-opts]
cpus = "1"
maxcpus = "12"

[object "mem0"]
qom-type = "memory-backend-file"
mem-path = "/dev/hugepages"
prealloc = "on"
discard-data = "on"
size = "10240M"
share = "on"

[numa]
type = "node"
nodeid = "0"
memdev = "mem0"

# Firmware (read only)
[drive]
file = "/snap/lxd/current/share/qemu/OVMF_CODE.fd"
if = "pflash"
format = "raw"
unit = "0"
readonly = "on"

# Firmware settings (writable)
[drive]
file = "/dev/fd/3"
if = "pflash"
format = "raw"
unit = "1"

# Qemu control
[chardev "monitor"]
backend = "socket"
path = "/var/snap/lxd/common/lxd/logs/juju-lxd/qemu.monitor"
server = "on"
wait = "off"

[mon]
chardev = "monitor"
mode = "control"

# Console
[chardev "console"]
backend = "socket"
path = "/var/snap/lxd/common/lxd/logs/juju-lxd/qemu.console"
server = "on"
wait = "off"

[device "qemu_pcie0"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.0"
chassis = "0"
multifunction = "on"

# Balloon driver
[device "qemu_balloon"]
driver = "virtio-balloon-pci"
bus = "qemu_pcie0"
addr = "00.0"
multifunction = "on"

# Random number generator
[object "qemu_rng"]
qom-type = "rng-random"
filename = "/dev/urandom"

[device "dev-qemu_rng"]
driver = "virtio-rng-pci"
bus = "qemu_pcie0"
addr = "00.1"
rng = "qemu_rng"

# Input
[device "qemu_keyboard"]
driver = "virtio-keyboard-pci"
bus = "qemu_pcie0"
addr = "00.2"

# Input
[device "qemu_tablet"]
driver = "virtio-tablet-pci"
bus = "qemu_pcie0"
addr = "00.3"

# Vsock
[device "qemu_vsock"]
driver = "vhost-vsock-pci"
bus = "qemu_pcie0"
addr = "00.4"
guest-cid = "181"

# Virtual serial bus
[device "dev-qemu_serial"]
driver = "virtio-serial-pci"
bus = "qemu_pcie0"
addr = "00.5"

# LXD serial identifier
[chardev "qemu_serial-chardev"]
backend = "ringbuf"
size = "16B"

[device "qemu_serial"]
driver = "virtserialport"
name = "org.linuxcontainers.lxd"
chardev = "qemu_serial-chardev"
bus = "dev-qemu_serial.0"

# Spice agent
[chardev "qemu_spice-chardev"]
backend = "spicevmc"
name = "vdagent"

[device "qemu_spice"]
driver = "virtserialport"
name = "com.redhat.spice.0"
chardev = "qemu_spice-chardev"
bus = "dev-qemu_serial.0"

# Spice folder
[chardev "qemu_spicedir-chardev"]
backend = "spiceport"
name = "org.spice-space.webdav.0"

[device "qemu_spicedir"]
driver = "virtserialport"
name = "org.spice-space.webdav.0"
chardev = "qemu_spicedir-chardev"
bus = "dev-qemu_serial.0"

# USB controller
[device "qemu_usb"]
driver = "qemu-xhci"
bus = "qemu_pcie0"
addr = "00.6"
p2 = "8"
p3 = "8"

[chardev "qemu_spice-usb-chardev1"]
backend = "spicevmc"
name = "usbredir"

[device "qemu_spice-usb1"]
driver = "usb-redir"
chardev = "qemu_spice-usb-chardev1"

[chardev "qemu_spice-usb-chardev2"]
backend = "spicevmc"
name = "usbredir"

[device "qemu_spice-usb2"]
driver = "usb-redir"
chardev = "qemu_spice-usb-chardev2"

[chardev "qemu_spice-usb-chardev3"]
backend = "spicevmc"
name = "usbredir"

[device "qemu_spice-usb3"]
driver = "usb-redir"
chardev = "qemu_spice-usb-chardev3"

[device "qemu_pcie1"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.1"
chassis = "1"

# SCSI controller
[device "qemu_scsi"]
driver = "virtio-scsi-pci"
bus = "qemu_pcie1"
addr = "00.0"

[device "qemu_pcie2"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.2"
chassis = "2"

# Config drive (9p)
[fsdev "qemu_config"]
fsdriver = "local"
security_model = "none"
readonly = "on"
path = "/var/snap/lxd/common/lxd/devices/juju-lxd/config.mount"

[device "dev-qemu_config-drive-9p"]
driver = "virtio-9p-pci"
bus = "qemu_pcie2"
addr = "00.0"
multifunction = "on"
mount_tag = "config"
fsdev = "qemu_config"

# Config drive (virtio-fs)
[chardev "qemu_config"]
backend = "socket"
path = "/var/snap/lxd/common/lxd/logs/juju-lxd/virtio-fs.config.sock"

[device "dev-qemu_config-drive-virtio-fs"]
driver = "vhost-user-fs-pci"
bus = "qemu_pcie2"
addr = "00.1"
tag = "config"
chardev = "qemu_config"

[device "qemu_pcie3"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.3"
chassis = "3"

# GPU
[device "qemu_gpu"]
driver = "virtio-vga"
bus = "qemu_pcie3"
addr = "00.0"

[device "qemu_pcie4"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.4"
chassis = "4"

# VM Generation ID
[device "vmgenid0"]
driver = "vmgenid"
guid = "83a8be7b-f64f-4537-9a3f-8d1af7edaf1c"

[device "qemu_pcie5"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.5"
chassis = "5"

[device "qemu_pcie6"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.6"
chassis = "6"

[device "qemu_pcie7"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "1.7"
chassis = "7"

[device "qemu_pcie8"]
driver = "pcie-root-port"
bus = "pcie.0"
addr = "2.0"
chassis = "8"
multifunction = "on"
```

I’m glad this information didn’t head my way prior to downgrading the kernel. I may have been down yet another LXD rabbit hole. It’s useful to know the LXD on gentoo QEMU config is at /var/log/lxd/VM-NAME/qemu.conf - Thank you for highlighting this

5.4.242 will likely remain, and I can start a different topic for the strange plex nvenc container issue which is consistent on both kernels but functions fine in docker…

![i1](https://discuss.linuxcontainers.org/uploads/default/original/2X/6/6990ee3f34ed32eac4794e4cbc2638128195252b.png)

I guess the fun doesn’t cease. I thought tpm might be the issue, but it vtpm is in the qemu.conf and populated:
/var/lib/lxd/virtual-machines/VM-Win11x64/tpm.vtpm/swtpm-vtpm.soc

Windows simply does not wish to play well with my install of LXD. Laughter and comment are greatly appreciated.

It maybe to do with this

<https://github.com/lxc/lxd/pull/11515>

HI Windows Updates in VMs are being affected with the error 0x800f0922 when trying to install KB5012170. Searching it reveals a new OVMF is needed. Is there something we should be doing in LXD or will some update and procedure be released to resolve this new Windows requirement, in terms of existing Windows VM images and instances? Also I’m going to be recreating the Windows Image because the recovery partition is at the end of the root disk and we’re unable to easily extend the C volume, so …
