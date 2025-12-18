# **[How to snap: introducing classic confinement](https://ubuntu.com/blog/how-to-snap-introducing-classic-confinement)**

Last Thursday, January 5, the snapd team was delighted to announce a new release of snapd (2.20), the daemon that enables systems to work with snaps and provides the snap command.

It’s time we take a look at the most prominent feature of this release: classic confinement. A new relaxed security policy for snaps, aimed at developer tools and scripts that need access to the whole host system.

## Confinement policies

As you may know, snaps are installed and mounted in a tightly controlled space: they don’t have access to the vast majority of system resources, they bundle libraries they need and have a read-only file-system. In the snap world, this is the “strict” confinement policy, which is enforced by default.

With snapd 2.20, a new confinement policy is introduced: “classic”, designed to cater for all your scripting and tooling needs. Snaps declaring their confinement as “classic”, have access to the rest of the system, as most legacy (debian packages for example) packaged apps do, while still benefiting from the ci-integrated store model, with automated updates, rollbacks to older versions, release channels, etc.

This new “classic” confinement is only available when snapd is installed on top of a traditional Linux distribution, as opposed to Ubuntu Core systems.

See the **[confinement reference](http://snapcraft.io/docs/reference/confinement?utm_source=insights&utm_campaign=snapd_2_20_classic_post&_gl=1*168knoq*_gcl_au*MTcwMzEzOTMxMC4xNzUzMTIxNDg4*_ga*MTY2Njg1MzMxNS4xNzQ3NTE3NDk3*_ga_5LTL1CNEJM*czE3NTczNjExMDUkbzY0JGcxJHQxNzU3MzYxMjI3JGo2MCRsMCRoMA..)** for details, or directly jump into a 5 minutes practical example. All you need is an up-to-date Ubuntu install and a terminal.

## Practical example

To illustrate this feature, let’s dive in and make a classic snap!

This example assumes you are on a fully updated (sudo apt update && sudo apt upgrade) Ubuntu 16.04, 16.10 or 17.04 and you have the snapcraft package installed (sudo apt install snapcraft).

you are going to snap a tool that used to be notoriously hard to snap, because it requires access to virtual pty devices and may need to launch other snaps: asciinema.

Asciinema allows you to record a terminal session, play it back (and optionally send it to asciinema.org for online playback).

## Create the project

Let’s start by initiating our project with snapcraft init. It will create a snap template for you to fill.

mkdir asciinema
cd asciinema
snapcraft init
The template is called snapcraft.yaml, this is the only file you will need to snap asciinema from source. Let’s edit it:

`$ <your favorite editor> snapcraft.yaml`

And make it look like this:

```yaml
name: asciinema
version: 'latest'
summary: One-line elevator pitch for asciinema
description: |
 You can write a longer
 multi-line paragraph in here.

grade: stable
confinement: classic

apps:
  asciinema:
    command: asciinema

parts:
  asciinema:
    source: <https://github.com/asciinema/asciinema.git>
    plugin: python
    python-version: 'python3'

```

confinement: classic
Here is our classic confinement mode declaration. Since classic snaps have a relaxed security model, users will need to explicitly pass the --classic flag to the snap install command when installing this snap.

apps:
  asciinema:
    command: asciinema
The apps declaration is where you declare which apps your snap will expose to the user. In this case, it exposes an asciinema command launching an asciinema executable placed in the path of the snap (in this case, its bin/ directory). If the executable was located in a foo/ directory, the command field would look like this:

command: foo/asciinema

Then, you have to declare where the source code for your app lives and how to build it, using the parts keyword. A part is a piece of code that composes your snap. In this case, you only have one piece, which is the asciinema source code.

parts:
  asciinema:
Then, in a part, you need to declare its source, which can be remote or local, and the way to build it. Snapcraft makes this very easy with a plugin system for different technologies and languages. Asciinema is a Python 3 app, let’s see how snapcraft can understand this:

parts:
  asciinema:
    source: <https://github.com/asciinema/asciinema.git>
    plugin: python
    python-version: 'python3'

The python plugin comes with options, in this case, you want to build a Python 3 app. When snapcraft will run and build the snap, you will be able to see all the build output (in this case, `pip` installs).

Snap it!
That’s it. You can go back to your terminal and run snapcraft to build the snap, it should take one or two minutes depending on your network speed to 1) download the asciinema source and Python plugin dependencies, 2) build the app, 3) compress it in a snap.

At the end of the process, you will have an asciinema_latest_amd64.snap file (name_version_arch.snap) ready to install.

You can install it with the snap install command:

snap install asciinema_latest_amd64.snap --classic --dangerous
The --classic flag acknowledges the fact that you are not installing a snap in strict confinement and the --dangerous flag overrides signature checking, as snaps installed from the store are signed with your developer key.

On install, an asciinema launcher has been added to /snap/bin/, that will call the snap itself, installed in /snap/asciinema/<revision>/:

$ which asciinema
/snap/bin/asciinema
Then of course, let’s run asciinema itself and see if it works:

$ asciinema
usage: asciinema [-h] [--version] {rec,play,upload,auth} ...
[...]
Test upload to asciinema.org:

## Classic confinement is effectively un-confining the applications inside a snap. Applications which use classic confinement have the same full system access as traditionally packaged applications. Classic confinement is intended as a stop-gap measure to enable developers to publish applications which need more access than the current set of interfaces enable. Over time, as more interfaces are developed, snap publishers can migrate away from classic confinement to strict

Classically confined snaps must be reviewed by the snap store reviewers team before they can be published in the stable channel. Snaps which use classic confinement may be rejected if they don’t meet the requirements.

Users should not attempt to override a strictly confined snap to make it ‘classic’ as this undoes the confinement and interfaces defined by the developer. In addition applications published as strict snaps may misbehave when installed with the ‘–classic’ switch.

As for a recommendation, you'll need to weigh the risks in your own mind. Consider the publisher of the software, their reputation/recognition and the fact that classic confinement snaps are reviewed before being published. Classic confinement is not all that different than having done a traditional apt install in terms of the access it allows to the program.
