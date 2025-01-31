# **[APT Issues](https://jumpcloud.com/blog/how-to-manage-apt-repositories-debian-ubuntu)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**


## **[No release file](https://itsfoss.com/repository-does-not-have-release-file-error-ubuntu/)** 

Understanding “Repository does not have a release file” error
Let’s go step by step here. The error message is:

E: The repository ‘http://ppa.launchpad.net/numix/ppa/ubuntu focal release’ does not have a release file

The critical part of this error message is “focal release”.

You probably already know that each Ubuntu release has a codename. For Ubuntu 20.04, the codename is Focal Fossa. The “focal” in the error message indicates Focal Fossa which is Ubuntu 20.04.

The error is basically telling you that though you have added a third-party repository to your system’s sources list, this new repository is not available for your current Ubuntu version.

Why so? You are probably using a new version of Ubuntu and the developer has not made the software available for this new version.

At this point, I highly recommend reading this in-depth guide to understand the concept of the repositories in Ubuntu. Trust me, you won’t be disappointed.

How to know if the PPA/third party repo is available for your Ubuntu version
First, you should check your Ubuntu version and its codename using ‘lsb_release -a’ command:

```bash
abhishek@itsfoss:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04 LTS
Release:	20.04
Codename:	focal
```

As you can see, the codename it shows is focal.

Now, the next thing you can do is go to the website of the software in question.

This could be the tricky part but you can figure it out with some patience and effort.

In the example here, the error complained about http://ppa.launchpad.net/numix/ppa/ubuntu. It is a PPA repository and you may easily find its webpage. How, you may ask.

Use Google or a Google alternative search engine like Duck Duck Go and search for “ppa numix”. This should give you the first result from launchpad.net which is the website used for hosting PPA related code.

On the webpage of the PPA, you can go to the “Overview of published packages” and filter it by the codename of your Ubuntu version:


- **[No release file](https://askubuntu.com/questions/732985/force-update-from-unsigned-repository)**

You can set options in your sources.list (located at /etc/apt/sources.list):

deb [trusted=yes] http://www.deb-multimedia.org jessie main
The trusted option is what turns off the GPG check. See man 5 sources.list for details.

You can either edit the file within the terminal with vim ( or whatever you prefer) or any non-terminal editor like gedit.

