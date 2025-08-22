# can you turn off bitlocker

Yes, you can turn off BitLocker encryption in Windows. You can do this through the Control Panel or by using PowerShell commands. The process involves decrypting the drive, which may take some time depending on the size of the data.

There is two things about "disabling" BitLocker:

You can temporary disable the BitLocker protection. This means that BitLocker won't get angry when you mess around with the partitions, BIOS settings, BIOS update or other things that might be sign of a compromised system. This is something you set and on next reboot Windows will activate this protection again.

You can remove the encryption on the system drive. This will remove the encryption and the BitLocker protection (see above). This process takes time as the data on the drive needs to be unencrypted but you can still use your computer while it does this. You can activate BitLocker again to encrypt your drive again - again, this takes times as all data needs to be encrypted again but you can still use your computer while this is going on.

In any case if your computer is BitLocker encrypted, I recommend that you go to the BitLocker settings (search for BotLocker in Start) and choose to save your recovery key.

I haven't tried installing another OS alongside a BitLocker protected Windows, so I don't know what Ubuntu refers to of the two ways of "disabling" BitLocker, but I could imagine they mean to remove the encryption all together (the second option), so that the Ubuntu installer can do "whatever it wants" to the Windows partition.

Bitlocker is full-disk encryption. It will prevent you from using part of that disk for something other than Windows.

You could get a second drive to install Linux onto. That's the safer route anyway.
1000x this, or possibly WSL. Multibooting is for thumb drives, not main OS drives anymore.

## How safe is it to disable BitLocker?

Tech support
I’m trying to install Ubuntu alongside Windows and the installer said I would have to disable BitLocker, but I’m worried I’ll brick my computer if I try that. Is there a better way or should I proceed as the instructions say?

How would that brick your computer? Anyway bitlocker is just encryption of the physical drive, so unless you're worried someone will go through the trouble of stealing your PC and putting the drive into a different PC, you should be fine, I have it disabled on my laptop because it's just too much of a pain for me

having to put in the giant pin number every time I want to enter safe mode

Okay. I haven't put in the recovery key except from the time that my motherboard got replaced. I can see it would be a hassel if typing in the key often.
