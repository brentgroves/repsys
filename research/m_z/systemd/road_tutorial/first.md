# **[Writing Systemd Services for Fun and Profit](https://www.linux.com/training-tutorials/writing-systemd-services-fun-and-profit/)**

**[Current Tasks](../../../../a_status/current_tasks.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Let’s say you want to run a games server, a server that runs Minetest, a very cool and open source mining and crafting sandbox game. You want to set it up for your school or friends and have it running on a server in your living room. Because, you know, if that’s good enough for the kernel mailing list admins, then it’s good enough for you.

However, you soon realize it is a chore to remember to run the server every time you switch your computer on and a nuisance to power down safely when you want to switch off.

First, you have to run the server as a daemon:

`minetest --server &`

Take note of the PID (you’ll need it later).

Then you have to tell your friends the server is up by emailing or messaging them. After that you can start playing.

Suddenly it is 3 am. Time to call it a day! But you can’t just switch off your machine and go to bed. First, you have to tell the other players the server is coming down, locate the bit of paper where you wrote the PID we were talking about earlier, and kill the Minetest server gracefully…

`kill -2 <PID>`
Kill -2 sends an interrupt (2 is the value associated with SIGINT). This will wake up the sleep call but then the loop continues.

…because just pulling the plug is a great way to end up with corrupted files. Then and only then can you power down your computer.

There must be a way to make this easier.

## Systemd Services to the Rescue

Let’s start off by making a systemd service you can run (manually) as a regular user and build up from there.

Services you can run without admin privileges live in ~/.config/systemd/user/, so start by creating that directory:

```bash
cd
mkdir -p ~/.config/systemd/user/
```

There are several types of systemd units (the formal name of systemd scripts), such as timers, paths, and so on; but what you want is a service. Create a file in `~/.config/systemd/user/` called minetest.service and open it with your text editor and type the following into it:

```bash
# minetest.service

[Unit] 
Description= Minetest server 
Documentation= https://wiki.minetest.net/Main_Page 

[Service] 
Type= simple 
ExecStart= /usr/games/minetest --server
```

Notice how units have different sections: The [Unit] section is mainly informative. It contains information for users describing what the unit is and where you can read more about it.

The meat of your script is in the [Service] section. Here you start by stating what kind of service it is using the Type directive. There are several types of service. If, for example, the process you run first sets up an environment and then calls in another process (which is the main process) and then exits, you would use the forking type; if you needed to block the execution of other units until the process in your unit finished, you would use oneshot; and so on.

None of the above is the case for the Minetest server, however. You want to start the server, make it go to the background, and move on. This is what the simple type does.

Next up is the ExecStart directive. This directive tells systemd what program to run. In this case, you are going to run minetest as headless server. You can add options to your executables as shown above, but you can’t chain a bunch of Bash commands together. A line like:

`ExecStart: lsmod | grep nvidia > videodrive.txt`

Would not work. If you need to chain Bash commands, it is best to wrap them in a script and execute that.

Also notice that systemd requires you give the full path to the program. So, even if you have to run something as simple as ls you will have to use `ExecStart= /bin/ls`.

There is also an ExecStop directive that you can use to customize how your service should be terminated. We’ll be talking about this directive more in part two, but for now you must know that, if you don’t specify an ExecStop, systemd will take it on itself to finish the process as gracefully as possible.

There is a full list of directives in the systemd.directives man page or, if you prefer, you can **[check them out on the web](http://man7.org/linux/man-pages/man7/systemd.directives.7.html)** and click through to see what each does.

Although only 6 lines long, your minetest.service is already a fully functional systemd unit. You can run it by executing

`systemd --user start minetest`

And stop it with

`systemd --user stop minetest`

The --user option tells systemd to look for the service in your own directories and to execute the service with your user’s privileges.

That wraps up this part of our server management story. In part two, we’ll go beyond starting and stopping and look at how to send emails to players, alerting them of the server’s availability. Stay tuned.
