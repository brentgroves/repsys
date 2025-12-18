# **[](https://snapcraft.io/docs/get-started#p-19156-connect-an-interface)**

Connect an interface
Interfaces put you in control of what applications can and cannot do with your system by either permitting or denying access to resources outside a snap’s confinement. They’re most commonly used to enable access to a webcam, to permit sound recording, for network access, or to read and write to your $HOME directory or remote storage.

Which interfaces a snap requires, and provides, depends on the type of snap and its own requirements.

To see which interfaces a snap is using, and which interfaces it could use but isn’t, type snap connections <snapname>:

```bash
$ snap connections vlc
Interface       Plug                   Slot                 Notes
audio-playback  vlc:audio-playback     :audio-playback      -
audio-record    vlc:audio-record       -                    -
camera          vlc:camera             -                    -
desktop         vlc:desktop            :desktop             -
home            vlc:home               :home                -
(...)
```

The slot is the provider of the resource while the plug is the consumer, and a slot can support multiple plug connections. In the above output, the camera interface is not connected because its slot is empty. This means VLC cannot access any connected cameras. The <snap-name>:<interface-name> syntax describes which snap is responsible for which component. If there’s no snap, such as with :audio-playback, the component is directly connected to the system.

To allow a camera to be accessible to VLC, the interface can be connected with the snap connect command:

snap connect vlc:camera

As you can see the output from snap connections vlc, and in the above image, VLC already has access a user’s /home directory because the home interface is connected to the system $HOME directory. This is an automatic connection, and is granted to certain interfaces and snaps when an interface provides fundamental functionality, such as VLC accessing your personal video and audio files.

Refer to Interfaces for more information.

Where snaps store data
Most snaps use strict confinement. This isolates both their execution environments and their data from your system (see Snap Confinement for further details). A confined snap that needs user-access to files will most likely use the home interface to bridge this confinement gap, allowing you to save and load files from your home directory automatically.

You can see whether the home interface is being used in the output to snap connections <snap name>:

$ snap connections nethack
Interface  Plug          Slot   Notes
home       nethack:home  :home  -
Regardless of whether the home interface is used or not, a snap can also store user data, such as a database or configuration files, within its own directory under $HOME/snap. Data within this snap-specific directory is stored in one of two further directories, depending on whether the data needs to be tied to a specific release, or whether it can be used across multiple releases.

Data for a specific release is stored within a directory named after the revision of a release. This is a numeric value, such as 55 or 56. The data for each specific revision is often copied from one release to the next, so that reverting from one revision to a previous revision will restore a working configuration, for instance. The snap directory also contains a symbolic link called current that points to the snap revision currently active.

Data that can be shared across releases is stored in a directory called common, and might include image or audio caches, or a database. This data is not copied between releases.

For more details on where snaps store their data, see Data locations.

Create and restore a snapshot
A snapshot is a copy of the user, system and configuration data stored by snapd for one or more snaps on your system, and a snapshot of the data found in both $HOME/snap/<snap-name> and /var/snap/<snap-name> is stored in /var/lib/snapd/snapshots/ (see Data locations for more details).

Snapshots are generated manually with the snap save command and automatically when a snap is removed. A snapshot can be used to backup the state of your snaps, revert snaps to a previous state and to restore a fresh snapd installation to a previously saved state.

The snap save command creates a snapshot for all installed snaps, or if declared individually, specific snaps:

$ sudo snap save
Set  Snap         Age    Version               Rev   Size   Notes
30   core         1.00s  16-2.37~pre1          6229   250B  -
30   core18       886ms  18                    543    123B  -
30   go           483ms  1.10.7                3092   387B  -
30   vlc          529ms  3.0.6                 770   882kB  -
The restore command replaces the current user, system and configuration data with the corresponding data from the specified snapshot:

$ sudo snap restore 30
Restored snapshot #30.
By default, this command restores all the data for all the snaps in a snapshot. You can restore data for specific snaps by simply listing them after the command, and for specific users with the --users=<usernames> argument.

Excluding a snap’s system and configuration data from snap restore is not currently possible.

See Snapshots for further details on creating, exporting, importing and validating snapshots.

Remove a snap
To remove a snap from your system, along with its internal user, system and configuration data, use the remove command:

$ sudo snap remove vlc
vlc removed
Add the --no-wait option to return immediately to the command prompt and run the removal in the background.

By default, all of a snap’s revisions are also removed. To remove a specific revision, add the --revision=<revision-number> argument to the remove command.

Prior to removal (except on Ubuntu Core systems), a snap’s internal user, system, and configuration data is saved as a snapshot (snapd 2.39+), and retained for 31 days.

To remove a snap without generating a snapshot, use the additional --purge argument:

$ sudo snap remove vlc --purge
vlc removed
For more details information on using snaps, see our Snap How-to guides.
