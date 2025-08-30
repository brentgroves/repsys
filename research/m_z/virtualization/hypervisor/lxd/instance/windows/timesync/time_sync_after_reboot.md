# **[](https://learn.microsoft.com/en-us/answers/questions/4095358/automatic-windows-resync-time-after-reboot-setup)**

Hi

Welcome to Microsoft community.

You can set up a task in Task Scheduler to automatically synchronize the time whenever your computer starts. Here's how:

1. Open Task Scheduler:

Press  Win + R  to open the Run dialog.
Type  taskschd.msc  and press Enter.
2. Create a new task:

Click on "Create Basic Task..." on the right side of the window.
3. Set up the task:

Name it something like "Time Sync on Startup".
For Trigger, select "When the computer starts".
For Action, select "Start a program".
4. Specify program/script:

In the Program/script field, type w32tm. In Add arguments (optional), type /resync.

The final setup should look something like this:

Program/script: w32tm Add arguments (optional): /resync

This tells Windows to use its built-in time synchronization command (w32tm /resync) whenever your computer starts.

Click Finish to create the task.

Now, every time you start your computer, Windows should automatically sync its clock with Microsoft's time server.

Please note that for this setup to work, your PC needs to have an active internet connection at startup.

Please let me know if you need any further assistance. Thank you.

Best regards
