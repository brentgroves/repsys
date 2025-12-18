# **[Get started with snaps](https://snapcraft.io/docs/get-started)**

A snap is a bundle of one or more applications that works without dependencies or modification across many different Linux distributions. Snaps are discoverable and installable from the Snap Store, a public app store with an audience of millions.

This tour introduces all of snap’s main features. We suggest going through the first few steps and then playing with what you’ve learnt. Come back when you feel comfortable and wish to further your knowledge.

By the end of the tour, you’ll have a good understanding of how to use snaps, from how they’re installed and updated, to how they’re backed-up and removed.

## Requirements

Snaps can be installed and removed with a graphical package manager, such as Ubuntu Software Centre, but most advanced functionality is only available from the Linux command shell.

The command shell is accessible from Terminal and many similar applications. It helps if you have some familiarity with this, but if you don’t, this tour is itself an ideal introduction to get you started.

Many Linux distributions, including Ubuntu, support snap by default. You can check by running the snap command. If the snap command is not found, take a look at our Installation guides for further help.

## List installed snaps

Snap is installed with a few other snaps, and a good place to start is to display these with the snap list command:

```bash
$ snap list
Name             Version        Rev    Tracking         Publisher   Notes
core22           20231123       1033   latest/stable    canonical✓  base
firefox          120.0.1-1      3504   latest/stable    mozilla✓    -
snapd            2.60.4         20290  latest/stable    canonical✓  snapd
```

Versions and revisions, under the Version and Rev columns respectively, convey different details about one specific release of a snap:

Version : the version of the software being packaged, as assigned by the developers
Revision: the sequence number assigned by the store when the snap file was uploaded
The version is a name or number that was arbitrarily assigned to a release by its developers, according to their development practices. It tells the user what content to expect from a snap. The revision is an automatic number assigned by the store to give every snap release a unique identity within the channel across every architecture supported by the snap.

## Finding snaps

There are snaps for many popular applications, including Spotify, Slack and the Chromium web browser.

The best way to find new snaps is to use the online Snap Store, either by searching for apps and words you’re interested in, such as “Spotify”, “music” or “maths”, or by browsing through categories.

To search for snaps with ‘media player’ in either their names or descriptions, type snap find "media player" into your terminal:

```bash
$ snap find "media player"
Name  Version  Developer    Notes  Summary
vlc   3.0.4     videolan✓   -      The ultimate media player.
```

The ✓ alongside videolan in the above output indicates that the snap publisher has been verified. Verified publishers are trusted to produce and maintain high-quality packages and include institutions, foundations, and companies.

## Section categories

Typing snap find without any arguments will return a list of suggested snaps and those suggestions can also be limited to a category with an additional --section= argument. The following section names are valid:

## Learn about a snap

The snap info command makes it easy to find more details about a specific snap. These details include what a snap does, who publishes it, which commands it provides.

The final part of the output lists the channels for the snap:

channels:
  latest/stable:    3.0.19                      2023-10-13 (3721) 336MB -
  latest/candidate: 3.0.19                      2023-10-02 (3721) 336MB -
  latest/beta:      3.0.20-27-g795b1bc62b       2023-12-13 (3862) 336MB -
  latest/edge:      4.0.0-dev-26928-g9bc7ded0f0 2023-12-13 (3863) 692MB -
installed:          3.0.19                                 (3721) 336MB -

Channels declare which release of a snap is installed and tracked for updates. The latest/stable channel is used by default, but opting to install from a different channel can be useful for testing new features, or for installing old legacy versions of an application. Which snaps are released to which channels is entirely up to the snap publisher.

Install the snap
Type snap install followed by the name of the snap to install the snap:

`sudo snap install vlc`
When install is run for the first time, one or more dependencies may be automatically installed alongside the snap you requested. Your network speed will determine how long this process takes. Snap operations can always be safely cancelled with ctrl+c, and one of snap’s best features is that an operation is either wholly successful, or it’s cleanly rolled back to the previous state.

A channel can also be optionally specified with the channel option:

sudo snap install --channel=edge vlc
After installation, the channel being monitored for updates can be changed with:

sudo snap switch --channel=stable vlc

Run apps and commands from the snap
The vast majority of snap-installed applications will run as you expect, from either the command line or from the desktop launcher.

If executing a command directly doesn’t work, use the snap run command:

`snap run vlc`

Links to snapped applications are located in /snap/bin which is added to the system $PATH.

## Update an installed snap

Snaps are updated automatically. However, to manually check for updates, use the following command:

`sudo snap refresh vlc`

The above will check the channel being tracked by the snap. If a newer version of the snap is available, it will be downloaded and installed.

Changing the channel being tracked and refreshing the snap can be accomplished with a single command:

`sudo snap refresh --channel=beta vlc`

Updates are automatically installed within 6 hours of a revision being made to a tracked channel, keeping most systems up-to-date. This schedule can be tuned via configuration options and disabled with the --hold option.

## Pause or stop automatic updates

The snap refresh --hold command holds, or postpones, snap updates for individual snaps, or for all snaps on the system, either indefinitely or for a specified period of time.

snap refresh --hold=<duration> <snap1> <snap2>...
Time duration units can be seconds (s), minutes (m) or hours (h), or a combination of these. To postpone updates indefinitely, a value of forever is also valid.

`$ snap refresh --hold=24h firefox`

General refreshes of "firefox" held until 2023-10-26T14:10:53+01:00
If no duration is specified, the hold period defaults to forever.

Refer to Managing updates for more details.

Revert to an earlier revision
A snap may be reverted to an earlier revision with the snap revert command. By default, it will attempt to revert to the previous revision:

`$ sudo snap revert vlc`

vlc reverted to 3.0.5-1
The optional --revision argument can be specified to request a specific revision:

`snap revert vlc --revision 500`

This operation will revert both the snap revision and the configuration data associated with the software. If the previously used revision of the snap is from a different channel, that snap will be installed but the channel being tracked won’t change.

User data, such as data generated by the snap and stored in a database, is often stored in a common directory and will not be reverted. See Data locations for more details on what information is stored and where.

A snap won’t automatically update to a version previously reverted from, and the output from snap refresh will continue to state All snaps up to date. A reverted snap will be automatically updated when a new and different revision is made available by the publisher.

However, explicitly adding the snap name to snap refresh will update the snap, regardless of whether the latest revision was previously reverted from or not:

`$ snap list --all vlc`

Name  Version  Rev  Tracking  Publisher  Notes
vlc   3.0.5-1  768  stable    videolan✓  -
vlc   3.0.6    770  stable    videolan✓  disabled

`$ sudo snap refresh`

All snaps up to date.

`$ sudo snap refresh vlc`

vlc 3.0.6 from VideoLAN✓ refreshed
