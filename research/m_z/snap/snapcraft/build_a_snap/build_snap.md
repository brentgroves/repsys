# **[](https://snapcraft.io/blog/lets-build-a-snap-together-a-complex-snapcraft-yaml-walkthrough)**

Let’s build a snap together – a complex snapcraft.yaml walkthrough

It has been a while since we talked about how to build snaps. In the past, we went through a number of detailed examples, focused on different programming languages and the use of various useful components that can be declared in snapcraft.yaml, like extensions, stage packages, layouts, and more. Today, we want to give you an overview of a fairly complex snap, which should help you get underway in your snap journey. We will take a look at **[GIMP](https://github.com/snapcrafters/gimp/blob/master/snap/snapcraft.yaml)**, a snap maintained under the Snapcrafters umbrella.

## Basic metadata

The first section of the snapcraft.yaml file declares the metadata by which the snap can be identified, or searched for in the Snap Store. The icon keyword specifies the name of the image file available in the local project tree that will be used when the snap gets installed.

```yaml
name: gimp
version: '2.10.30'
summary: GNU Image Manipulation Program
description: |
  Whether you are a graphic designer, photographer, illustrator, or scientist,
  GIMP provides you with sophisticated tools to get your job done. You can
  further enhance your productivity with GIMP thanks to many customization
  options and 3rd party plugins.
icon: gimp.png
```

Grade, base compression
The second section of the snapcraft.yaml file declares a number of important parameters. Grade defines the stability level of the snap. Two levels are available – stable and devel. A snap that is in the devel mode cannot be published to the candidate or stable channels in the Snap Store.

The GIMP snap is also strictly confined, meaning it has limited access to system resources. Later on in the file, we will look at interfaces, a security mechanism that allows strictly confined snaps to access and use system resources in a granular, finely controlled way.

grade: stable
confinement: strict
base: core18
compression: lzo

The snap uses core18 as its base. The base is a special type of snap that functions as the foundation on top of which the snap will execute and run. For instance, core18 is based on Ubuntu 18.04, and uses its libraries to provide the necessary environment.

Compression specifies the type of algorithm that will be used to pack the built snap artifacts into a snap, a file that is in essence a single squashFS archive with a .snap suffix. In the past, the xz algorithm was used, but more recently, snaps can opt into using lzo. While it provides a lesser compression (snaps are bigger), it also contributes to faster startup times, which are essential to a good user experience, especially on desktop systems.

Architectures
Developers can specify which target architectures they want to use for their snap. By default, snaps will be built for the amd64 platform. It is important to make sure that the application can build and run on the desired architectures, and that all the relevant library dependencies that need to be bundled inside the snap exist and can be provided for these architectures.

architectures:

- build-on: amd64
- build-on: arm64
- build-on: armhf

## Layouts

This section allows developers to map directory and file paths in a way that will present the applications inside the snap with a structure similar to traditional Linux systems. In some cases, this may be necessary, because certain applications are not “snap-aware” or may be hard-coded to using absolute paths that would break out of the snap security confinement. A workaround to this problem is to use layouts and point the relevant paths to inside-the-snap directories and files.

```bash
layout:
  /etc/gimp:
    bind: $SNAP/etc/gimp
  /etc/ld.so.cache:
    bind-file: $SNAP_DATA/etc/ld.so.cache
  /usr/lib/$SNAPCRAFT_ARCH_TRIPLET/babl-0.1:
    bind: $SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/babl-0.1
  /usr/lib/$SNAPCRAFT_ARCH_TRIPLET/gegl-0.4:
    bind: $SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/gegl-0.4
...
  /usr/lib/gimp:
    bind: $SNAP/usr/lib/gimp
  /usr/lib/python2.7:
    bind: $SNAP/usr/lib/python2.7
  /usr/lib/gvfs:
    bind: $SNAP/usr/lib/gvfs
...
```

## Plugs

**[Snap interfaces](https://snapcraft.io/docs/interface-management)** allow (or deny) access to a resource outside of a snap’s strict confinement in a controlled fashion. This mechanism allows snaps to provide the necessary functionality without compromising on the security model. For instance, interfaces can be used to access OpenGL acceleration, home directory, network, audio playback, and more.

Each interface consists of two components – plug and slot, whereby the former is a consumer and the latter a provider of a resource. When a developer declares one or more plugs in their snapcraft.yaml, they allow its applications to access the relevant components. The plugs can be declared for all applications inside the snap (there can be more than one application), or specified individually for each application.

For example, if a snap has two apps – foo and bar, you may want to give both access to the home directory, but only allow network access to bar. You can then declare the home interface in a global plugs section, and then add a separate plug declaration for just the bar application.

```yaml
plugs:
  gtk-3-themes:
    interface: content
    target: $SNAP/data-dir/themes
    default-provider: gtk-common-themes:gtk-3-themes
  sound-themes:
    interface: content
    target: $SNAP/data-dir/sounds
    default-provider: gtk-common-themes:sound-themes
  icon-themes:
    interface: content
    target: $SNAP/data-dir/icons
    default-provider: gtk-common-themes:icon-themes
  gnome-3-28-1804:
    interface: content
    target: $SNAP/data-dir/gnome-platform
    default-provider: gnome-3-28-1804:gnome-3-28-1804
```

The GIMP snap utilizes themes, sounds, icons and other assets from the common Gtk content themes, as well as additional assets from the GNOME 3.28 content platform. The elegance of this approach is that it allows the GIMP snap to ship with fewer components, saving space, reducing maintenance, and in general, allowing multiple snaps to utilize common parts, driving overall platform consistency.

## Slots

Similarly, the GIMP snapcraft.yaml declares a D-BUS session slot, which allows for application interoperability. This way, software that can access the D-BUS service will be able to communicate with GIMP over the registered bus, even though it is an isolated, strictly confined application.

slots:
  dbus-gimp:
    interface: dbus
    bus: session
    name: org.gimp.GIMP.UI

## Hooks

Sometimes, snaps may have to do dynamic things that go beyond the build process. This kind of functionality can be provided with hooks, a set of shell scripts that can be executed at different stages in the snap’s lifecycle.

hooks:
  install:
    command-chain:
      - snap/command-chain/desktop-launch
  post-refresh:
    command-chain:
      - snap/command-chain/desktop-launch

In the example above, the GIMP snap has two hooks, one which runs during the install stage, and one that is triggered after an update (refresh). The execution of the hooks is governed by the snapd service.

In particular, the use of hooks is handy for operations that cannot be fully defined during the build process. For instance, a snap may need a specific on-device configuration that can only be generated at install time, or require other elements that the developer cannot provide during the build.

# Environment

Snaps run in their own environment, isolated from the rest of the system. To that end, they also have their own environment variables. Developers can set variables that will then be accessed and used by the snap applications at runtime.

environment:
  SNAP_DESKTOP_RUNTIME: $SNAP/data-dir/gnome-platform
  GTK_EXE_PREFIX: $SNAP/usr
  GTK_USE_PORTAL: '1'
  GIMP2_LOCALEDIR: $SNAP/usr/share/locale
  LD_LIBRARY_PATH:
$SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/lapack:$SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/blas
  PYTHONPATH:
$SNAP/usr/lib/python2.7:$SNAP/usr/lib/python2.7/site-packages:$PYTHONPATH
  FINAL_BINARY: $SNAP/usr/bin/gimp

Apps
The apps section of the snapcraft.yaml file declares one or more applications. Most snaps will have one namesake binary, but there is no limitation to how many different applications can be specified. Each one must have its path (command) as well as optional declarations like slots, plugs, or perhaps desktop files.

apps:
  gimp:
    command: usr/bin/gimp
    command-chain: [snap/command-chain/desktop-launch]
    desktop: usr/share/applications/gimp.desktop
    common-id: org.gimp.GIMP
    slots:
    - dbus-gimp
    plugs:
    - cups-control
    - browser-support
    - desktop
    - desktop-legacy
    - gsettings
...

## Apps

The apps section of the snapcraft.yaml file declares one or more applications. Most snaps will have one namesake binary, but there is no limitation to how many different applications can be specified. Each one must have its path (command) as well as optional declarations like slots, plugs, or perhaps desktop files.

apps:
  gimp:
    command: usr/bin/gimp
    command-chain: [snap/command-chain/desktop-launch]
    desktop: usr/share/applications/gimp.desktop
    common-id: org.gimp.GIMP
    slots:
    - dbus-gimp
    plugs:
    - cups-control
    - browser-support
    - desktop
    - desktop-legacy
    - gsettings
...

GIMP requires access to the D-Bus (as we defined in the slots section), as well as access to desktop, home, network, X11 or Wayland, 3D acceleration, removable media, and other resources.

## Parts

The bulk of most snaps is the parts declaration – a section where developers list all the different components that will be compiled, built and assembled into the snap. Parts can be any assets, including source files, deb packages, zipped archives, standalone files, or even empty stubs that are used to perform build operations on other parts. You can specify the order of execution of parts, so that for instance one part downloads an asset, while another changes it after it’s downloaded.

Developers have quite a bit of flexibility when it comes to how they use and define parts:

- They can use plugins for specific programming languages or build tools.
- They can use scriptlets to override default part build commands and perform custom actions that go beyond the default behavior of each plugin.

```bash
parts:
  fix-pkgconfig-files:
    plugin: nil
    override-build: |
      cat <<'EOF' > $SNAPCRAFT_PART_INSTALL/fix-pkgconfig-files.sh
      for pcfile in
$SNAPCRAFT_PART_INSTALL/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/pkgconfig/*.pc
$SNAPCRAFT_PART_INSTALL/usr/lib/pkgconfig/*.pc
$SNAPCRAFT_PART_INSTALL/usr/local/lib/$SNAPCRAFT_ARCH_TRIPLET/pkgconfig/*.pc
$SNAPCRAFT_PART_INSTALL/usr/local/lib/pkgconfig/*.pc; do
        sed -i -E "s~^((include|lib)dir=)/usr(/local)?~\1\\\${prefix}~g" $pcfile || true
        sed -i -E "s~^((exec_)?prefix=)(/usr(/local)?)~\1/\3~" $pcfile || true
      done
      EOF
      chmod +x $SNAPCRAFT_PART_INSTALL/fix-pkgconfig-files.sh
    prime:
    - -*
```

Another interesting part is desktop-launch. The source for this part comes from a local directory named desktop-launch in the snap project folder. It is built using the make plugin. The part lists a number of packages that will be used during the build step, as well as several stage packages, which will be used by the built binary artifacts at runtime.

```bash
desktop-launch:
    plugin: make
    source: desktop-launch
    build-packages:
      - rsync
      - libgail-dev
      - libgtk-3-dev
      - libgtk2.0-dev
    stage-packages:
      - appmenu-gtk2-module
      - gtk2-engines
      - gtk2-engines-pixbuf
      - libatk-adaptor
      - libcanberra-gtk-module
      - libgail-common
...
```

Both the build and stage packages are provided from Ubuntu archives that match the base declared earlier in the file. Thus, if a developer uses libgail-dev during the build and has specified core18 in their snapcraft.yaml, Snapcraft will pull this file from the Ubuntu 18.04 repositories. Similarly, with core20, Snapcraft will query the Ubuntu 20.04 archives.

The build and stage packages need to be written in the correct form that matches their names in the respective archives. If you omit some, you may see an error at build time, or the application may fail to run. Snapcraft can auto-guess some of the dependencies, but you may also need to manually supply the list yourself, which requires some basic familiarity with how the snapped applications works.

The GIMP part itself does a large number of interesting things:

It is built after several other components.
It is compiled using autotools.
The source file is downloaded from the official website, and it is compiled with a number of config flags, including O2 level of optimization and debug symbols.
A number of build and stage packages is listed, including architecture-specific entries.

gimp:
    after:
    - babl
    - desktop-settings-packages
    - gegl
    - gtk-locales
    - libheif
    - libmypaint
    - mypaint-brushes
    plugin: autotools
    source:
<https://download.gimp.org/pub/gimp/v2.10/gimp-$SNAPCRAFT_PROJECT_VERSION.tar.bz2>
    source-checksum:
sha256/88815daa76ed7d4277eeb353358bafa116cd2fcd2c861d95b95135c1d52b67dc
    configflags:
    - --prefix=/usr
    - --sysconfdir=/etc
    - --with-bug-report-url=<https://github.com/snapcrafters/gimp/issues/>
    - --with-build-id=org.gimp.GIMP.snapcraft.stable
    - --disable-check-update
    - --disable-docs
    - --disable-gtk-doc
    - --disable-gtk-doc-html
    - --disable-python
    build-environment:
    - CFLAGS: -O2 -g -pipe
    - CXXFLAGS: -O2 -g -pipe
...

In particular, in the build-packages list, Snapcraft will try to use three libraries, but only on architectures where these libraries are available. This allows snapcraft.yaml to be more compact while still targeting different platforms.

- try:
  - libunwind8 # not available in s390x
  - libfftw3-long3 # only amd64 and i386
  - libfftw3-quad3 # only amd64 and i386

Additionally, the GIMP snapcraft.yaml also builds the babl pixel encoding and color space conversion engine, G’MIC image processing framework, GEGL image processing library, help files, as well performs several more cleanup operations.

And that brings us to the end of our long, exhaustive snapcraft.yaml!

Summary
Hopefully, this somewhat long tutorial clarifies the ins and outs of snap building, and makes the process easier and more accessible. If you want to create your first snap, perhaps you can start with a somewhat simpler project, and if you’re looking for a more complex challenge, the GIMP one is a good starting point. We’d like to hear your feedback and thoughts, so if you want to share anything, please join our forum and let us know.

Photo by Dominik Scythe on Unsplash.
