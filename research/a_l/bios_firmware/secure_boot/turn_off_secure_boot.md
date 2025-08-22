## **[Does turning on secure boot gonna need Windows 11 reinstall?](https://www.reddit.com/r/Windows11/comments/1mjy7gc/does_turning_on_secure_boot_gonna_need_windows_11/#:~:text=Actually%2C%20Windows%2011%20can%20be,disable%20it%20if%20using%20Windows.)**

Actually, Windows 11 can be installed as long as Secure Boot is present on the system. It does not have to be enabled.

In my opinion, however, there is no good reason to ever disable it if using Windows.

Important - Absolutely back up before changing secure boot settings.

<https://www.reddit.com/r/pcgaming/comments/1mhpu0t/secure_boot_is_a_requirement_to_play_battlefield/>

This is correct.... I THOUGHT I had Secure Boot active until i did systeminfo and to my surprise it was disabled. I went into BIOS and it was enabled but was not setup correctly. Now it is.

How do you setup it properly?

Um if i remember correctly I rebooted into BIOS (Custom built PC with gigabyte board) and changed the Secure Boot mode to Custom then disable CSM. But let me check the BIOS tonight and can get back to you.

Oh ok, I have it on custom too

Ok i am wrong. By default it was set to Custom. I set it to Standard and CSM to disabled. That's all i had to do.

CSM boot mode offers the compatibility for legacy BIOS that can support a bootable disk up to 2 TB, while UEFI boot mode can support up to 9 ZB

Important - Absolutely back up before changing secure boot settings.

<https://www.reddit.com/r/pcgaming/comments/1mhpu0t/secure_boot_is_a_requirement_to_play_battlefield/>

First you need to turn off bitlocker when you want to turn off secure boot again.

I have spent a day and a half trying to get this Secure Boot to work to no avail. The issue for me is weird, though, and I will explain below:

I went to do an advanced restart on my computer and went into the bios to enable the Secure Boot after I saved and restarted it. When it turned back on, I noticed my left monitor (I have 2 monitors) wasn't connecting, and my computer wouldn't register the monitor. I went back into the bios to disable Secure Boot to revert the change and my monitor connected. Long story short, I just enabled Secure Boot just to see if it would even work with the game, and it didn't, of course.

I am so confused about what I am doing wrong and would love any answers or advice on how to proceed. Specs are listed below. If anyone can help me, then please comment. Thanks in advance.
