# **[Using Flatpak on Linux [Complete Guide]](https://itsfoss.com/flatpak-guide/)**

Learn all the essentials for managing Flatpak packages in this beginner's guide.

Started by Fedora, the Flatpak packaging format is getting popular among other distributions as well. More developers are providing their applications in Flatpak format. Some newer applications might only be applicable in Flatpak format.

All this makes it important that you learn to use Flatpak and this guide will help you with that. You'll learn:

- Pros and cons of Flatpak packaging
- To install Flatpak on your Linux system (if needed)
- To add Flatpak support in GNOME software center
- Essential Flatpak commands for effectively managing packages

## What is Flatpak?

**[Flatpak](https://flatpak.org/)** is a framework for applications on Linux. With the different distributions preferring their own package management, Flatpak aims to provide a cross-platform solution with other benefits. It makes the work for developers even easier.

## Primary advantages of Flatpak

- Apart from offering a single bundle for different Linux distributions, Flatpak offers integration to the Linux desktops making it easier to browse, install and use Flatpak applications, e.g. the GNOME Software Center can be used to install a Flatpak.
- Flatpaks are forward compatible i.e. the same Flatpak app can run on the next releases of a distribution without changes.
- Run-time dependencies are maintained which can be used by the application. Missing ones can be added as a part of the application.
- Though Flatpak provides a centralized service for distribution of applications, it fully supports the decentralized distribution of applications.

## Disadvantages of Flatpak

- Flatpak packages take a lot more disk space than traditional packages. What could be 30 MB of deb package could easily be 200 MB of Flatpak. That's because the Flatpak package contains all the dependency packages as well.
- Some Flatpak applications do not adhere to the system theme and thus look out of place

## A. Enable Flatpak support for various Linux distributions

Fedora and a few distributions already come with Flatpak support installed by default. You should check if Flatpak is already available by

`flatpak --version`

Installing Flatpak is a two-step process. The first one is to install Flatpak and then you have to add a Flatpak repo (here, Flathub) from where you can install applications.

## Install Flatpak on Ubuntu and Linux Mint

Install Flatpak support on Ubuntu with the following command:

`sudo apt install flatpak`

## B. Enable Flatpak application support in Software Center

Flatpak applications can be completely managed via command line. But not everyone likes using command line for installing applications and this is where enabling Flatpak support in GNOME software center will be a lifesaver.

On some distrubutions like Pop!_OS 20.04, you will find Flatpak integrated with the software center. So, you don’t need to separately do anything about it.

However, if you don’t have the Flatpak integration by default, you will need the GNOME software plugin to install flatpak via GUI. Use the below command to install it in Ubuntu based distributions:

`sudo apt install gnome-software-plugin-flatpak`

For other distributions, use the regular package installation command to install gnome-software-plugin-flatpak. Once installed, restart the Software Center or your machine.

Now you can download the .flatpakref file from the application developer’s website or from the official Flatpak application store, Flathub.

Navigate to the download folder and double-click on the downloaded .flatpakref file. It should open the Software Center and will provide the installation option as shown in the picture below:
![i](https://itsfoss.com/content/images/wordpress/2018/05/Flatpak-800x434.jpg)

You can also right-click on the file and Open it with Software Install (default) if double click doesn’t work.

Once the installation completes, you can launch it from software center or from the application menu.

## C. Using Flatpak commands (for intermediate to experts)

Now that you have seen how to enable Flatpak support and how to install Flatpak applications, you can move forward to see Flatpak commands for complete control over package installation.

## Add repositories for installing Flatpak applications

This part of the tutorial is optional and only intended for intermediate to expert users who prefer command line over GUI.
Add repositories for installing Flatpak applications
Flatpak needs to have repository information from where you can find and download applications. It would be a good idea to add the Flathub repository so that you get access to a number of Flatpak applications.

It is worth noting that at the time of writing this — **[Flathub](https://flathub.org/)** is the most popular repository for installing Flatpak. So, I’ve used it for every command mentioned. If you’re using some other repository (remote source), feel free to replace Flathub with the one you’re using for every command.

To do that, use the following command:

`flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

## Searching Flatpak packages through the terminal

You can search for available Flatpak applications using the search option in Flatpak command in the following manner:

`flatpak search applicationname`

The application name need not be exact. It will show all possible results matching the search query.

For example, flatpak search libreoffice returns LibreOffice stable release.

![i1](https://itsfoss.com/content/images/wordpress/2020/07/flatpak-search-new.jpg)

You should note two things in the above command output. The “Application ID” and “Remotes“. You’ll need these two for installing the application.

💡
You can install and remove Flatpak packages without using sudo in the command line. However, it only works if you have sudo access. A user without sudo access cannot install Flatpak packages in this manner.

Install Flatpak applications
The generic way to install a Flatpak application from a repository is:

`flatpak install <remotes> <ApplicationID>`

For example, in the previous search command, you got the Application ID and the repository name. You can use this info to install the application in the following manner:

`flatpak install flathub org.libreoffice.LibreOffice`

![i1](https://itsfoss.com/content/images/wordpress/2020/07/flatpak-flathub-installation.jpg)

Some developers provide their own repository. You can use the absolute path to the application’s flatpakref to install the application or through Flathub.

flatpak install --from <https://flathub.org/repo/appstream/com.spotify.Client.flatpakref>
💡
By default, Flatpak apps are installed at system level, meaning once installed, they are available to all the users on the system. If you want to install the applications for current user only, add --user flag to the package installation command.

## Install Flatpak applications from flatpakref file

If you have downloaded the .flatpakref file on your system, navigate to the directory and use the command to install it:

`flatpak install <ApplicationID>.flatpakref`

Suppose, you’ve downloaded net.poedit.Poedit.flatpakref file, the command will look like:

`flatpak install net.poedit.Poedit.flatpakref`

## Add env

Note that the directories

'/var/lib/flatpak/exports/share'
'/home/brent/.local/share/flatpak/exports/share'

are not in the search path set by the XDG_DATA_DIRS environment variable, so
applications installed by Flatpak may not appear on your desktop until the
session is restarted.

## Run a Flatpak

To run a Flatpak application, you can use the command below:

flatpak run <ApplicationID>
For instance, if you installed spotify, here’s how the command will look like:

`flatpak run com.spotify.Client`

## Display all Flatpak apps installed on your system

You can display all Flatpak applications installed on your system using the command below:

`flatpak list`

![i](https://itsfoss.com/content/images/wordpress/2020/07/flatpak-list.png)

## Uninstall a Flatpak application

You can use the uninstall option with the application id to remove the installed Flatpak package.

`flatpak uninstall <ApplicationID>`

Here’s how it should look like:

`flatpak uninstall com.spotify.Client`

## Updating all Flatpak applications at once

You can **[update all Flatpak packages](https://itsfoss.com/update-flatpak/)** that can be updated with this single command:

`flatpak update`

You can also **[downgrade Flatpak packages](https://itsfoss.com/downgrade-flatpak-packages/)** if you want to.

## Free up space by removing unused Flatpak runtimes

It would be wise to clean your system and free up space from time to time. You can remove the unused Flatpak runtimes with this command:

`flatpak uninstall --unused`

The above command lists the unused runtimes and gives you the option to remove them all.

You may also delete user data for Flatpak packages that are no longer in the system:

`flatpak uninstall --unused --delete-data`

## D. Troubleshooting Flatpak

In this section, we’ll see some common issues you may face with Flatpak.

Fix Flatpak Installation Error
If you encounter an error like this:

`error: runtime/org.freedesktop.Platform/x86_64/1.6 not installed`

You can easily fix it using this command:

`flatpak update -v`

You get the error if you had Flatpak installation incomplete because of poor internet connection or system shutdown. Updating Flatpak repositories usually fixes this problem.

`revokefs-fuse permission denied error`

If you try to install a Flatpak package and encounter this error:

Warning: Failed to create a mountpoint for revokefs-fuse: Permission denied
It means that you don't have sudo access. You need to be part of the sudo group first.

Where are Flatpaks installed?
You can find Flatpak runtime and other files in /var/lib/flatpak directory for the packages installed at the system level.

For the Flatpak apps installed at user level, you can find some files in the .local/share/flatpak/ of the user's home directory.

## What do you think of Flatpak?

Enabling Flatpak support certainly provides access to more software. Flathub website provides an easy way of finding these Flatpak applications.

## Flathub for finding Flatpak apps

Here are a few tips on getting more out of the Flatpak:

Not only Flatpak address the cross-platform application installation among Linux users, but it also saves efforts to develop separate bundles for different distributions.

A single package can be used on various kinds of Linux distributions, and the maintenance is super easy.

Though, in comparison to Snap, Flatpak is slightly complicated. Relying on the application id instead of the application name is an annoyance, in my opinion. I was also surprised that the installation and removal of the Flatpak application don’t require sudo rights.

💬What do you think about Flatpak, and do you use them? Do you prefer it over AppImage or Snaps? Let us know if you face any issues in the comment section.
