# **[UEFI boot: how does that actually work, then?](https://www.happyassassin.net/posts/2014/01/25/uefi-boot-how-does-that-actually-work-then/)**

IMPORTANT NOTE TO INDUSTRY FOLKS: This blog post is aimed at regular everyday folks; it's intended to dispel a few common myths and help regular people understand UEFI a bit better. It is not a low-level fully detailed and 100% technically accurate explanation, and I'm not a professional firmware engineer or anything like that. If you're actually building an operating system or hardware or something, please don't rely on my simplified explanations or ask me for help; I'm just an idiot on the internet. If you're doing that kind of thing and you have money, join the UEFI Forum or ask your suppliers or check your reference implementation or whatever. If you don't have money, try asking your peers with more experience, nicely. END IMPORTANT NOTE

You've probably read a lot of stuff on the internet about UEFI. Here is something important you should understand: 95% of it was probably garbage. If you think you know about UEFI, and you derived your knowledge anywhere other than the UEFI specifications, **[mjg59's blog](http://mjg59.dreamwidth.org/)** or one of a few other vaguely reliable locations/people - Rod Smith, or Peter Jones, or Chris Murphy, or the documentation of the relatively few OSes whose developers actually know what the hell they're doing with UEFI - what you think you know is likely a toxic mix of misunderstandings, misconceptions, half-truths, propaganda and downright lies. So you should probably forget it all.

Good, now we've got that out of the way. What I mostly want to talk about is bootloading, because that's the bit of firmware that matters most to most people, and the bit news sites are always banging on about and wildly misunderstanding.

Terminology
First, let's get some terminology out of the way. Both BIOS and UEFI are types of firmware for computers. BIOS-style firmware is (mostly) only ever found on IBM PC compatible computers. UEFI is meant to be more generic, and can be found on systems which are not in the 'IBM PC compatible' class.

You do not have a 'UEFI BIOS'. No-one has a 'UEFI BIOS'. Please don't ever say 'UEFI BIOS'. BIOS is not a generic term for all PC firmware, it is a particular type of PC firmware. Your computer has a firmware. If it's an IBM PC compatible computer, it's almost certainly either a BIOS or a **[UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)** firmware. If you're running Coreboot, congratulations, Mr./Ms. Exception. You may be proud of yourself.

Secure Boot is not the same thing as UEFI. Do not ever use those terms interchangeably. Secure Boot is a single effectively optional element of the UEFI specification, which was added in version 2.2 of the UEFI specification. We will talk about precisely what it is later, but for now, just remember it is not the same thing about UEFI. You need to understand what Secure Boot is, and what UEFI is, and which of the two you are actually talking about at any given time. We'll talk about UEFI first, and then we'll talk about Secure Boot as an 'extension' to UEFI, because that's basically what it is.

Bonus Historical Note: UEFI was not invented by, is not controlled by, and has never been controlled by Microsoft. Its predecessor and basis, EFI, was developed and published by Intel. UEFI is managed by the **[UEFI Forum](http://uefi.org/)**. Microsoft is a member of the UEFI forum. So is Red Hat, and so is Apple, and so is just about every major PC manufacturer, Intel (obviously), AMD, and a laundry list of other major and minor hardware, software and firmware companies and organizations. It is a broad consensus specification, with all the messiness that entails, some of which we'll talk about specifically later. It is no one company's Evil Vehicle Of Evilness.

References
If you really want to understand UEFI, it's a really good idea to go and read the UEFI specification. You can do this. It's very easy. You don't have to pay anyone any money. I am not going to tell you that reading it will be the most fun you've ever had, because it won't. But it won't be a waste of your time. You can find it right here on the **[official UEFI site](http://www.uefi.org/specs/download)**. You have to check a couple of boxes, but you are not signing your soul away to Satan, or anything. It's fine. As I write this, the current version of the spec is 2.4 Errata A, and that's the version this post is written with regard to.

There is no BIOS specification. BIOS is a de facto standard - it works the way it worked on actual IBM PCs, in the 1980s. That's kind of one of the reasons UEFI exists.

Now, to keep things simple, let's consider two worlds. One is the world of IBM PC compatible computers - hereafter referred to just as PCs - before UEFI and GPT (we'll come to GPT) existed. This is the world a lot of you are probably familiar with and may understand quite well. Let's talk about how booting works on PCs with BIOS firmware.

## BIOS booting

It works, in fact, in a very, very simple way. On your bog-standard old-skool BIOS PC, you have one or more disks which have an MBR. The MBR is another de facto standard; basically, the very start of the disk describes the partitions on the disk in a particular format, and contains a 'boot loader', a very small piece of code that a BIOS firmware knows how to execute, whose job it is to boot the operating system(s). (Modern bootloaders frequently are much bigger than can be contained in the MBR space and have to use a multi-stage design where the bit in the MBR just knows how to load the next stage from somewhere else, but that's not important to us right now).

All a BIOS firmware knows, in the context of booting the system, is what disks the system contains. You, the owner of this BIOS-based computer, can tell the BIOS firmware which disk you want it to boot the system from. The firmware has no knowledge of anything beyond that. It executes the bootloader it finds in the MBR of the specified disk, and that's it. The firmware is no longer involved in booting.

In the BIOS world, absolutely all forms of multi-booting are handled above the firmware layer. The firmware layer doesn't really know what a bootloader is, or what an operating system is. Hell, it doesn't know what a partition is. All it can do is run the boot loader from a disk's MBR. You also cannot configure the boot process from outside of the firmware.

UEFI booting: background
OK, so we have our background, the BIOS world. Now let's look at how booting works on a UEFI system. Even if you don't grasp the details of this post, grasp this: it is completely different. Completely and utterly different from how BIOS booting works. You cannot apply any of your understanding of BIOS booting to native UEFI booting. You cannot make a little tweak to a system designed for the world of BIOS booting and apply it to native UEFI booting. You need to understand that it is a completely different world.

Here's another important thing to understand: many UEFI firmwares implement some kind of BIOS compatibility mode, sometimes referred to as a CSM. Many UEFI firmwares can boot a system just like a BIOS firmware would - they can look for an MBR on a disk, and execute the boot loader from that MBR, and leave everything subsequently up to that bootloader. People sometimes incorrectly refer to using this feature as 'disabling UEFI', which is linguistically nonsensical. You cannot 'disable' your system's firmware. It's just a stupid term. Don't use it, but understand what people really mean when they say it. They are talking about using a UEFI firmware's ability to boot the system 'BIOS-style' rather than native UEFI style.

What I'm going to describe is native UEFI booting. If you have a UEFI-based system whose firmware has the BIOS compatibility feature, and you decide to use it, and you apply this decision consistently, then as far as booting is concerned, you can pretend your system is BIOS-based, and just do everything the way you did with BIOS-style booting. If you're going to do this, though, just make sure you do apply it consistently. I really can't recommend strongly enough that you do not attempt to mix UEFI-native and BIOS-compatible booting of permanently-installed operating systems on the same computer, and especially not on the same disk. It is a terrible terrible idea and will cause you heartache and pain. If you decide to do it, don't come crying to me.

For the sake of sanity, I am going to assume the use of disks with a GPT partition table, and EFI FAT32 EFI system partitions. Depending on how deep you're going to dive into this stuff you may find out that it's not strictly speaking the case that you can always assume you'll be dealing with GPT disks and EFI FAT32 ESPs when dealing with UEFI native boot, but the UEFI specification is quite strongly tied to GPT disks and EFI FAT32 ESPs, and this is what you'll be dealing with in 99% of cases. Unless you're dealing with Macs, and quite frankly, screw Macs.

Edit note: the following sections (up to Implications and Complications) were heavily revised on 2014-01-26, a few hours after the initial version of this post went up, based on feedback from Peter Jones. Consider this to be v2.0 of the post. An earlier version was written in a somewhat less accurate and more confusing way.

UEFI native booting: how it actually works - background
OK, with that out of the way, let's get to the meat. This is how native UEFI booting actually works. It's probably helpful to go into this with a bit of high-level background.

UEFI provides much more infrastructure at the firmware level for handling system boot. It's nowhere near as simple as BIOS. Unlike BIOS, UEFI certainly does understand, to varying degrees, the concepts of 'disk partitions' and 'bootloaders' and 'operating systems'.

You can sort of look at the BIOS boot process, and look at the UEFI process, and see how the UEFI process extends various bits to address specific problems.

The BIOS/MBR approach to finding the bootloader is pretty janky, when you think about it. It's very 'special sauce': this particular tiny space at the front of the disk contains magic code that only really makes much sense to the system firmware and special utilities for writing it. There are several problems with this approach.

It's inconvenient to deal with - you need special utilities to write the MBR, and just about the only way to find out what's in one is to dd the contents out and examine them.
As noted above, the MBR itself is not big enough for many modern bootloaders. What they do is install a small part of themselves to the MBR proper, and the rest to the empty space on the disk between where the conventional MBR ends and the first partition begins. There's a rather big problem with this (well, the whole design is a big problem, but never mind), which is that there's no reliable convention for where the first partition should begin, so it's difficult to be sure there'll be enough space. One thing you usually can rely on is that there won't be enough space for some bootloader configurations.
The design doesn't provide any standardized layer or mechanism for selecting boot targets other than disks...but people want to select boot targets other than disks. i.e. they want to have multiple bootable 'things' - usually operating systems - per disk. The only way to do this, in the BIOS/MBR world, is for the bootloaders to handle it; but there's no widely accepted convention for the right way to do this. There are many many different approaches, none of which is particularly interoperable with any of the others, none of which is a widely accepted standard or convention, and it's very difficult to write tooling at the OS / OS installation layer that handles multiboot cleanly. It's just a very messy design.
The design doesn't provide a standard way of booting from anything except disks. We're not going to really talk about that in this article, but just be aware it's another advantage of UEFI booting: it provides a standard way for booting from, for instance, a remote server.
There's no mechanism for levels above the firmware to configure the firmware's boot behaviour.

So you can imagine the UEFI Elves sitting around and considering this problem, and coming up with a solution. Instead of the firmware only knowing about disks and one 'magic' location per disk where bootloader code might reside, UEFI has much more infrastructure at the firmware layer for handling boot loading. Let's look at all the things it defines that are relevant here.

## EFI executables

The UEFI spec defines an executable format and requires all UEFI firmwares be capable of executing code in this format. When you write a bootloader for native UEFI, you write in this format. This is pretty simple and straightforward, and doesn't need any further explanation: it's just a Good Thing that we now have a firmware specification which actually defines a common format for code the firmware can execute.

## The GPT (GUID partition table) format

The GUID Partition Table format is very much tied in with the UEFI specification, and again, this isn't something particularly complex or in need of much explanation, it's just a good bit of groundwork the spec provides. GPT is just a standard for doing partition tables - the information at the start of a disk that defines what partitions that disk contains. It's a better standard for doing this than MBR/'MS-DOS' partition tables were in many ways, and the UEFI spec requires that UEFI-compliant firmwares be capable of interpreting GPT (it also requires them to be capable of interpreting MBR, for backwards compatibility). All of this is useful groundwork: what's going on here is the spec is establishing certain capabilities that everything above the firmware layer can rely on the firmware to have.

## EFI system partitions

I actually really wrapped my head around the EFI system partition concept while revising this post, and it was a great 'aha!' moment. Really, the concept of 'EFI system partitions' is just an answer to the problem of the 'special sauce' MBR space. The concept of some undefined amount of empty space at the start of a disk being 'where bootloader code lives' is a pretty crappy design, as we saw above. EFI system partitions are just UEFI's solution to that.1

The solution is this: we require the firmware layer to be capable of reading some specific types of filesystem. The UEFI spec requires that compliant firmwares be capable of reading the FAT12, FAT16 and FAT32 variants of the FAT format, in essence. In fact what it does is codify a particular interpretation of those formats as they existed at the point UEFI was accepted, and say that UEFI compliant firmwares must be capable of reading those formats. As the spec puts it:

"The file system supported by the Extensible Firmware Interface is based on the FAT file system. EFI defines a specific version of FAT that is explicitly documented and testable. Conformance to the EFI specification and its associate reference documents is the only definition of FAT that needs to be implemented to support EFI. To differentiate the EFI file system from pure FAT, a new partition file system type has been defined."

An 'EFI system partition' is really just any partition formatted with one of the UEFI spec-defined variants of FAT and given a specific GPT partition type to help the firmware find it. And the purpose of this is just as described above: allow everyone to rely on the fact that the firmware layer will definitely be able to read data from a pretty 'normal' disk partition. Hopefully it's clear why this is a better design: instead of having to write bootloader code to the 'magic' space at the start of an MBR disk, operating systems and so on can just create, format and mount partitions in a widely understood format and put bootloader code and anything else that they might want the firmware to read there.

The whole ESP thing seemed a bit bizarre and confusing to me at first, so I hope this section explains why it's actually a very sensible idea and a good design - the bizarre and confusing thing is really the BIOS/MBR design, where the only way for you to write something from the OS layer that you knew the firmware layer could consume was to write it into some (but you didn't know how much) Magic Space at the start of a disk, a convention which isn't actually codified anywhere. That really isn't a very sensible or understandable design, if you step back and take a look at it.

As we'll note later, the UEFI spec tends to take a 'you must at least do these things' approach - it rarely prohibits firmwares from doing anything else. It's not against the spec to write a firmware that can execute code in other formats, read other types of partition table, and read partitions formatted with filesystems other than the UEFI variants of FAT. But a UEFI compliant firmware must at least do all these things, so if you are writing an OS or something else that you want to run on any UEFI compliant firmware, this is why the EFI system partition concept is so important: it gives you (at least in theory) 100% confidence that you can put an EFI executable on a partition formatted with the UEFI FAT implementation and the correct GPT partition type, and the system firmware will be able to read it. This is the thing you can take to the bank, like 'the firmware will be able to execute some bootloader code I put in the MBR space' was in the BIOS world.

So now we have three important bits of groundwork the UEFI spec provides: thanks to these requirements, any other layer can confidently rely on the fact that the firmware:

Can read a partition table
Can access files in some specific filesystems
Can execute code in a particular format
This is much more than you can rely on a BIOS firmware being capable of. However, in order to complete the vision of a firmware layer that can handle booting multiple targets - not just disks - we need one more bit of groundwork: there needs to be a mechanism by which the firmware finds the various possible boot targets, and a way to configure it.

## The UEFI boot manager

The UEFI spec defines something called the UEFI boot manager. (Linux distributions contain a tool called efibootmgr which is used to manipulate the configuration of the UEFI boot manager). As a sample of what you can expect to find if you do read the UEFI spec, it defines the UEFI boot manager thusly:

"The UEFI boot manager is a firmware policy engine that can be configured by modifying architecturally defined global NVRAM variables. The boot manager will attempt to load UEFI drivers and UEFI applications (including UEFI OS boot loaders) in an order defined by the global NVRAM variables."

Well, that's that cleared up, let's move on. ;) No, not really. Let's translate that to Human. With only a reasonable degree of simplification, you can think of the UEFI boot manager as being a boot menu. With a BIOS firmware, your firmware level 'boot menu' is, necessarily, the disks connected to the system at boot time - no more, no less. This is not true with a UEFI firmware.

The UEFI boot manager can be configured - simply put, you can add and remove entries from the 'boot menu'. The firmware can also (it fact the spec requires it to, in various cases) effectively 'generate' entries in this boot menu, according to the disks attached to the system and possibly some firmware configuration settings. It can also be examined - you can look at what's in it.

One rather great thing UEFI provides is a mechanism for doing this from other layers: you can configure the system boot behaviour from a booted operating system. You can do all this by using the efibootmgr tool, once you have Linux booted via UEFI somehow. There are Windows tools for it too, but I'm not terribly familiar with them. Let's have a look at some typical efibootmgr output, which I stole and slightly tweaked from the Fedora forums:

```bash
[root@system directory]# efibootmgr -v
BootCurrent: 0002
Timeout: 3 seconds
BootOrder: 0003,0002,0000,0004
Boot0000* CD/DVD Drive  BIOS(3,0,00)
Boot0001* Hard Drive    HD(2,0,00)
Boot0002* Fedora        HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\fedora\grubx64.efi)
Boot0003* opensuse      HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\opensuse\grubx64.efi)
Boot0004* Hard Drive    BIOS(2,0,00)P0: ST1500DM003-9YN16G        .
[root@system directory]#
```

The first line tells you which of the 'boot menu' entries you are currently booted from. The second is pretty obvious (if the firmware presents a boot menu-like interface to the UEFI boot manager, that's the timeout before it goes ahead and boots the default entry). The BootOrder is the order in which the entries in the list will be tried. The rest of the output shows the actual boot entries. We'll describe what they actually do later.

If you boot a UEFI firmware entirely normally, without doing any of the tweaks we'll discuss later, what it ought to do is try to boot from each of the 'entries' in the 'boot menu', in the order listed in BootOrder. So on this system it would try to boot the entry called 'opensuse', then if that failed, the one called 'Fedora', then 'CD/DVD Drive', and then the second 'Hard Drive'.

## UEFI native booting: how it actually works - boot manager entries

What does these entries actually mean, though? There's actually a huge range of possibilities that makes up rather a large part of the complexity of the UEFI spec all by itself. If you're reading the spec, pour yourself an extremely large shot of gin and turn to the EFI_DEVICE_PATH_PROTOCOL section, but note that this is a generic protocol that's used for other things than booting - it's UEFI's Official Way Of Identifying Devices For All Purposes, used for boot manager entries but also for all sorts of other purposes. Not every possible EFI device path makes sense as a UEFI boot manager entry, for obvious reasons (you're probably not going to get too far trying to boot from your video adapter). But you can certainly have an entry that points to, say, a PXE server, not a disk partition. The spec has lots of bits defining valid non-disk boot targets that can be added to the UEFI boot manager configuration.

For our purposes, though, lets just consider fairly normal disks connected to the system. In this case we can consider three types of entry you're likely to come across.

## BIOS compatibility boot entries

Boot0000 and Boot0004 in this example are actually BIOS compatibility mode entries, not UEFI native entries. They have not been added to the UEFI boot manager configuration by any external agency, but generated by the firmware itself - this is a common way for a UEFI firmware to implement BIOS compatibility booting, by generating UEFI boot manager entries that trigger a BIOS-compatible boot of a given device. How they present this to the user is a different question, as we'll see later. Whether you see any of these entries or not will depend on your particular firmware, and its configuration. Each of these entries just gives a name - 'CD/DVD Drive', 'Hard Drive' - and says "if this entry is selected, boot this disk (where 'this disk' is 3,0,00 for Boot0000 and 2,0,00 for Boot0004) in BIOS compatibility mode".

Fallback path' UEFI native boot entries
Boot0001 is an entry (fictional, and somewhat unlikely, but it's for illustrative purposes) that tells the firmware to try and boot from a particular disk, and in UEFI mode not BIOS compatibility mode, but doesn't tell it anything more. It doesn't specify a particular boot target on the disk - it just says to boot the disk.

The UEFI spec defines a sort of 'fallback' path for booting this kind of boot manager entry, which works in principle somewhat like BIOS drive booting: it looks in a standard location for some boot loader code. The details are different, though.

What the firmware will actually do when trying to boot in this way is reasonably simple. The firmware will look through each EFI system partition on the disk in the order they exist on the disk. Within the ESP, it will look for a file with a specific name and location. On an x86-64 PC, it will look for the file \EFI\BOOT\BOOTx64.EFI. What it actually looks for is \EFI\BOOT\BOOT{machine type short-name}.EFI - 'x64' is the "machine type short-name" for x86-64 PCs. The other possibilities are BOOTIA32.EFI (x86-32), BOOTIA64.EFI (Itanium), BOOTARM.EFI (AArch32 - that is, 32-bit ARM) and BOOTAA64.EFI (AArch64 - that is, 64-bit ARM). It will then execute the first qualifying file it finds (obviously, the file needs to be in the executable format defined in the UEFI specification).

This mechanism is not designed for booting permanently-installed OSes. It's more designed for booting hotpluggable, device-agnostic media, like live images and OS install media. And this is indeed what it's usually used for. If you look at a UEFI-capable live or install medium for a Linux distribution or other OS, you'll find it has a GPT partition table and contains a FAT-formatted partition at or near the start of the device, with the GPT partition type that identifies it as an EFI system partition. Within that partition there will be a \EFI\BOOT directory with at least one of the specially-named files above. When you boot a Fedora live or install medium in UEFI-native mode, this is the mechanism that is used. The BOOTx64.EFI (or whatever) file handles the rest of the boot process from there, booting the actual operating system contained on the medium.

Full UEFI native boot entries
Boot0002 and Boot0003 are 'typical' entries for operating systems permanently installed to permanent storage devices. These entries show us the full power of the UEFI boot mechanism, by not just saying "boot from this disk", but "boot this specific bootloader in this specific location on this specific disk", using all the 'groundwork' we talked about above.

Boot0002 is a boot entry produced by a UEFI-native Fedora installation. Boot0003 is a boot entry produced by a UEFI-native OpenSUSE installation. As you may be able to tell, all they're saying is "load this file from this partition". The partition is the HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d) bit: that's referring to a specific partition (using the EFI_DEVICE_PATH_PROTOCOL, which I'm really not going to attempt to explain in any detail - you don't necessarily need to know it, if you interact with the boot manager via the firmware interface and efibootmgr). The file is the File(\EFI\opensuse\grubx64.efi) bit: that just means "load the file in this location on the partition we just described". The partition in question will almost always be one that qualifies as an EFI system partition, because of the considerations above: that's the type of partition we can trust the firmware to be able to access.

This is the mechanism the UEFI spec provides for operating systems to make themselves available for booting: the operating system is intended to install a bootloader which loads the OS kernel and so on to an EFI system partition, and add an entry to the UEFI boot manager configuration with a name - obviously, this will usually be derived from the operating system's name - and the location of the bootloader (in EFI executable format) that is intended for loading that operating system.

Linux distributions use the efibootmgr tool to deal with the UEFI boot manager. What a Linux distribution actually does, so far as bootloading is concerned, when you do a UEFI native install is really pretty simple: it creates an EFI system partition if one does not already exist, installs an EFI boot loader with an appropriate configuration - often grub2-efi, but there are others - into a correct path in the EFI system partition, and calls efibootmgr to add an appropriately-named UEFI boot manager entry pointing to its boot loader. Most distros will use an existing EFI system partition if there is one, though it's perfectly valid to create a new one and use that instead: as we've noted, UEFI is a permissive spec, and if you follow the design logically, there's really no problem with having just as many EFI system partitions as you want.

## stopped here

**[uefi](https://www.youtube.com/watch?v=-V3VhP-MUwE)**

UEFI (Unified Extensible Firmware Interface) boot mode initiates the system startup process by first initializing hardware and loading the UEFI firmware, which then locates and executes a boot manager. This boot manager presents a menu for selecting the desired operating system or boot entry. Once selected, UEFI loads the corresponding bootloader, transferring control to the operating system to complete the boot process.

Here's a more detailed breakdown:

1. Power On and POST:
.
When the computer is powered on, the UEFI firmware initializes the hardware components. This includes the POST (Power-On Self-Test) process to check system functionality.
2. UEFI Firmware Execution:
.
The UEFI firmware then begins its own execution.
3. Boot Manager Loading:
.
The UEFI firmware loads the boot manager, which is stored in the system's NVRAM (Non-Volatile RAM). This manager presents a menu of available boot options.
4. Boot Entry Selection:
.
The user selects the desired boot entry (e.g., an operating system) from the menu displayed by the boot manager.
5. Bootloader Loading and OS Startup:
.
UEFI then loads the corresponding bootloader for the selected operating system and transfers control to it. The bootloader then takes over, loading the operating system into memory and initiating its startup sequence.
6. Boot Files on ESP:
.
UEFI utilizes a special partition called the EFI System Partition (ESP), which contains boot loaders and other files needed for the boot process. These files are accessed using UEFI's support for file systems and partition tables.
7. GPT Partition Table:
.
UEFI primarily uses the GPT (GUID Partition Table) partition scheme, which is more modern and capable than the older MBR (Master Boot Record).
