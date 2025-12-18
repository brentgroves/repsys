# **[Systemd Units](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Introduction

Increasingly, Linux distributions are adopting the systemd init system. This powerful suite of software can manage many aspects of your server, from services to mounted devices and system states.

In systemd, a unit refers to any resource that the system knows how to operate on and manage. This is the primary object that the systemd tools know how to deal with. These resources are defined using configuration files called unit files.

In this guide, we will introduce you to the different units that systemd can handle. We will also be covering some of the many directives that can be used in unit files in order to shape the way these resources are handled on your system.

## What do Systemd Units Give You?

Units are the objects that systemd knows how to manage. These are basically a standardized representation of system resources that can be managed by the suite of daemons and manipulated by the provided utilities.

Units can be said to be similar to services or jobs in other init systems. However, a unit has a much broader definition, as these can be used to abstract services, network resources, devices, filesystem mounts, and isolated resource pools.

Ideas that in other init systems may be handled with one unified service definition can be broken out into component units according to their focus. This organizes by function and allows you to easily enable, disable, or extend functionality without modifying the core behavior of a unit.

Some features that units are able implement easily are:

- **socket-based activation:** Sockets associated with a service are best broken out of the daemon itself in order to be handled separately. This provides a number of advantages, such as delaying the start of a service until the associated socket is first accessed. This also allows the system to create all sockets early in the boot process, making it possible to boot the associated services in parallel.

In Linux, a socket is a logical endpoint for communication, acting as a pseudo-file that represents a network connection. It's a fundamental building block for network applications, allowing processes to send and receive data across a network or even between processes on the same machine.

- **bus-based activation:** Units can also be activated on the bus interface provided by D-Bus. A unit can be started when an associated bus is published.

![db](https://fedoramagazine.org/wp-content/uploads/2023/12/a1890px-Processes_with_D-Bus.svg_-816x345.jpg)

D-Bus is, mainly, an interprocess communication (IPC) protocol. Its main advantage is that applications don’t need to establish one-to-one communication with every other process that they need to talk with. D-Bus, instead, offers a virtual bus to which all applications connect and send the messages to.

- **path-based activation:** A unit can be started based on activity on or the availability of certain filesystem paths. This utilizes inotify.
- **device-based activation:** Units can also be started at the first availability of associated hardware by leveraging udev events.

Udev events in Linux are notifications the kernel sends to the udev daemon when a device is added, removed, or its state changes. Udev, in turn, uses these events to manage device nodes in /dev, create symbolic links, and potentially trigger actions like loading drivers or mounting file systems.

- **implicit dependency mapping:** Most of the dependency tree for units can be built by systemd itself. You can still add dependency and ordering information, but most of the heavy lifting is taken care of for you.
- **instances and templates:** Template unit files can be used to create multiple instances of the same general unit. This allows for slight variations or sibling units that all provide the same general function.
- **easy security hardening:** Units can implement some fairly good security features by adding simple directives. For example, you can specify no or read-only access to part of the filesystem, limit kernel capabilities, and assign private /tmp and network access.
- **drop-ins and snippets:** Units can easily be extended by providing snippets that will override parts of the system’s unit file. This makes it easy to switch between vanilla and customized unit implementations.

There are many other advantages that systemd units have over other init systems’ work items, but this should give you an idea of the power that can be leveraged using native configuration directives.

## Where are Systemd Unit Files Found?

The files that define how systemd will handle a unit can be found in many different locations, each of which have different priorities and implications.

The system’s copy of unit files are generally kept in the /lib/systemd/system directory. When software installs unit files on the system, this is the location where they are placed by default.

Unit files stored here are able to be started and stopped on-demand during a session. This will be the generic, vanilla unit file, often written by the upstream project’s maintainers that should work on any system that deploys systemd in its standard implementation. You should not edit files in this directory. Instead you should override the file, if necessary, using another unit file location which will supersede the file in this location.

If you wish to modify the way that a unit functions, the best location to do so is within the `/etc/systemd/system` directory. Unit files found in this directory location **take precedence over any of the other locations** on the filesystem. If you need to modify the system’s copy of a unit file, putting a replacement in this directory is the safest and most flexible way to do this.

If you wish to override only specific directives from the system’s unit file, you can actually provide unit file snippets within a subdirectory. These will append or modify the directives of the system’s copy, allowing you to specify only the options you want to change.

The correct way to do this is to create a directory named after the unit file with .d appended on the end. So for a unit called example.service, a subdirectory called example.service.d could be created. Within this directory a file ending with .conf can be used to override or extend the attributes of the system’s unit file.

There is also a location for run-time unit definitions at `/run/systemd/system`. Unit files found in this directory have a priority landing between those in /etc/systemd/system and /lib/systemd/system. Files in this location are given less weight than the former location, but more weight than the latter.

The systemd process itself uses this location for dynamically created unit files created at runtime. This directory can be used to change the system’s unit behavior for the duration of the session. All changes made in this directory will be lost when the server is rebooted.

## Types of Units

Systemd categories units according to the type of resource they describe. The easiest way to determine the type of a unit is with its type suffix, which is appended to the end of the resource name. The following list describes the types of units available to systemd:

- **.service:** A service unit describes how to manage a service or application on the server. This will include how to start or stop the service, under which circumstances it should be automatically started, and the dependency and ordering information for related software.
- **.socket:** A socket unit file describes a network or IPC socket, or a FIFO buffer that systemd uses for socket-based activation. These always have an associated .service file that will be started when activity is seen on the socket that this unit defines.
- **.device:** A unit that describes a device that has been designated as needing systemd management by udev or the sysfs filesystem. Not all devices will have .device files. Some scenarios where .device units may be necessary are for ordering, mounting, and accessing the devices.
- **.mount:** This unit defines a mountpoint on the system to be managed by systemd. These are named after the mount path, with slashes changed to dashes. Entries within /etc/fstab can have units created automatically.
- **.automount:** An .automount unit configures a mountpoint that will be automatically mounted. These must be named after the mount point they refer to and must have a matching .mount unit to define the specifics of the mount.
- **.swap:** This unit describes swap space on the system. The name of these units must reflect the device or file path of the space.
- **.target:** A target unit is used to provide synchronization points for other units when booting up or changing states. They also can be used to bring the system to a new state. Other units specify their relation to targets to become tied to the target’s operations.
- **.path:** This unit defines a path that can be used for path-based activation. By default, a .service unit of the same base name will be started when the path reaches the specified state. This uses inotify to monitor the path for changes.
- **.timer:** A .timer unit defines a timer that will be managed by systemd, similar to a cron job for delayed or scheduled activation. A matching unit will be started when the timer is reached.
- **.snapshot:** A .snapshot unit is created automatically by the systemctl snapshot command. It allows you to reconstruct the current state of the system after making changes. Snapshots do not survive across sessions and are used to roll back temporary states.
- **.slice:** A .slice unit is associated with Linux Control Group nodes, allowing resources to be restricted or assigned to any processes associated with the slice. The name reflects its hierarchical position within the cgroup tree. Units are placed in certain slices by default depending on their type.
- **.scope:** Scope units are created automatically by systemd from information received from its bus interfaces. These are used to manage sets of system processes that are created externally.

As you can see, there are many different units that systemd knows how to manage. Many of the unit types work together to add functionality. For instance, some units are used to trigger other units and provide activation functionality.

We will mainly be focusing on .service units due to their utility and the consistency in which administrators need to managed these units.

## Anatomy of a Unit File

The internal structure of unit files are organized with sections. Sections are denoted by a pair of square brackets “[” and “]” with the section name enclosed within. Each section extends until the beginning of the subsequent section or until the end of the file.

## General Characteristics of Unit Files

Section names are well-defined and case-sensitive. So, the section [Unit] will not be interpreted correctly if it is spelled like [UNIT]. If you need to add non-standard sections to be parsed by applications other than systemd, you can add a X- prefix to the section name.

Within these sections, unit behavior and metadata is defined through the use of simple directives using a key-value format with assignment indicated by an equal sign, like this:

```bash
[Section]
Directive1=value
Directive2=value

. . .
```

In the event of an override file (such as those contained in a unit.type.d directory), directives can be reset by assigning them to an empty string. For example, the system’s copy of a unit file may contain a directive set to a value like this:

```bash
Directive1=default_value
```

The default_value can be eliminated in an override file by referencing Directive1 without a value, like this:

```bash
Directive1=
```

In general, systemd allows for easy and flexible configuration. For example, multiple boolean expressions are accepted (1, yes, on, and true for affirmative and 0, no off, and false for the opposite answer). Times can be intelligently parsed, with seconds assumed for unit-less values and combining multiple formats accomplished internally.

## [Unit] Section Directives

The first section found in most unit files is the [Unit] section. This is generally used for defining metadata for the unit and configuring the relationship of the unit to other units.

Although section order does not matter to systemd when parsing the file, this section is often placed at the top because it provides an overview of the unit. Some common directives that you will find in the [Unit] section are:

- **Description=:** This directive can be used to describe the name and basic functionality of the unit. It is returned by various systemd tools, so it is good to set this to something short, specific, and informative.
- **Documentation=:** This directive provides a location for a list of URIs for documentation. These can be either internally available man pages or web accessible URLs. The systemctl status command will expose this information, allowing for easy discoverability.
- **Requires=:** This directive lists any units upon which this unit essentially depends. If the current unit is activated, the units listed here must successfully activate as well, else this unit will fail. These units are started in parallel with the current unit by default.
- **Wants=:** This directive is similar to Requires=, but less strict. Systemd will attempt to start any units listed here when this unit is activated. If these units are not found or fail to start, the current unit will continue to function. This is the recommended way to configure most dependency relationships. Again, this implies a parallel activation unless modified by other directives.
- **BindsTo=:** This directive is similar to Requires=, but also causes the current unit to stop when the associated unit terminates.
- **Before=:** The units listed in this directive will not be started until the current unit is marked as started if they are activated at the same time. This does not imply a dependency relationship and must be used in conjunction with one of the above directives if this is desired.
- **After=:** The units listed in this directive will be started before starting the current unit. This does not imply a dependency relationship and one must be established through the above directives if this is required.
- **Conflicts=:** This can be used to list units that cannot be run at the same time as the current unit. Starting a unit with this relationship will cause the other units to be stopped.
- **Condition...=:** There are a number of directives that start with Condition which allow the administrator to test certain conditions prior to starting the unit. This can be used to provide a generic unit file that will only be run when on appropriate systems. If the condition is not met, the unit is gracefully skipped.
- **Assert...=:** Similar to the directives that start with Condition, these directives check for different aspects of the running environment to decide whether the unit should activate. However, unlike the Condition directives, a negative result causes a failure with this directive.

Using these directives and a handful of others, general information about the unit and its relationship to other units and the operating system can be established.

## [Install] Section Directives

On the opposite side of unit file, the last section is often the [Install] section. This section is optional and is used to define the behavior or a unit if it is enabled or disabled. Enabling a unit marks it to be automatically started at boot. In essence, this is accomplished by latching the unit in question onto another unit that is somewhere in the line of units to be started at boot.

Because of this, only units that can be enabled will have this section. The directives within dictate what should happen when the unit is enabled:

- **WantedBy=:** The WantedBy= directive is the most common way to specify how a unit should be enabled. This directive allows you to specify a dependency relationship in a similar way to the Wants= directive does in the [Unit] section. The difference is that this directive is included in the ancillary unit allowing the primary unit listed to remain relatively clean. When a unit with this directive is enabled, a directory will be created within `/etc/systemd/system` named after the specified unit with .wants appended to the end. Within this, a symbolic link to the current unit will be created, creating the dependency. For instance, if the current unit has WantedBy=multi-user.target, a directory called multi-user.target.wants will be created within /etc/systemd/system (if not already available) and a symbolic link to the current unit will be placed within. Disabling this unit removes the link and removes the dependency relationship.
- **RequiredBy=:** This directive is very similar to the WantedBy= directive, but instead specifies a required dependency that will cause the activation to fail if not met. When enabled, a unit with this directive will create a directory ending with .requires.
- **Alias=:** This directive allows the unit to be enabled under another name as well. Among other uses, this allows multiple providers of a function to be available, so that related units can look for any provider of the common aliased name.
- **Also=:** This directive allows units to be enabled or disabled as a set. Supporting units that should always be available when this unit is active can be listed here. They will be managed as a group for installation tasks.
- **DefaultInstance=:** For template units (covered later) which can produce unit instances with unpredictable names, this can be used as a fallback value for the name if an appropriate name is not provided.

## Unit-Specific Section Directives

Sandwiched between the previous two sections, you will likely find unit type-specific sections. Most unit types offer directives that only apply to their specific type. These are available within sections named after their type. We will cover those briefly here.

The device, target, snapshot, and scope unit types have no unit-specific directives, and thus have no associated sections for their type.

## The [Service] Section

The [Service] section is used to provide configuration that is only applicable for services.

One of the basic things that should be specified within the [Service] section is the Type= of the service. This categorizes services by their process and daemonizing behavior. This is important because it tells systemd how to correctly manage the servie and find out its state.

The Type= directive can be one of the following:

- **simple:** The main process of the service is specified in the start line. This is the default if the Type= and Busname= directives are not set, but the ExecStart= is set. Any communication should be handled outside of the unit through a second unit of the appropriate type (like through a .socket unit if this unit must communicate using sockets).
- **forking:** This service type is used when the service forks a child process, exiting the parent process almost immediately. This tells systemd that the process is still running even though the parent exited.
- **oneshot:** This type indicates that the process will be short-lived and that systemd should wait for the process to exit before continuing on with other units. This is the default Type= and ExecStart= are not set. It is used for one-off tasks.
- **dbus:** This indicates that unit will take a name on the D-Bus bus. When this happens, systemd will continue to process the next unit.
- **notify:** This indicates that the service will issue a notification when it has finished starting up. The systemd process will wait for this to happen before proceeding to other units.
- **idle:** This indicates that the service will not be run until all jobs are dispatched.

Some additional directives may be needed when using certain service types. For instance:

- **RemainAfterExit=:** This directive is commonly used with the oneshot type. It indicates that the service should be considered active even after the process exits.
- **PIDFile=:** If the service type is marked as “forking”, this directive is used to set the path of the file that should contain the process ID number of the main child that should be monitored.
- **BusName=:** This directive should be set to the D-Bus bus name that the service will attempt to acquire when using the “dbus” service type.
- **NotifyAccess=:** This specifies access to the socket that should be used to listen for notifications when the “notify” service type is selected This can be “none”, “main”, or "all. The default, “none”, ignores all status messages. The “main” option will listen to messages from the main process and the “all” option will cause all members of the service’s control group to be processed.

So far, we have discussed some pre-requisite information, but we haven’t actually defined how to manage our services. The directives to do this are:

- **ExecStart=:** This specifies the full path and the arguments of the command to be executed to start the process. This may only be specified once (except for “oneshot” services). If the path to the command is preceded by a dash “-” character, non-zero exit statuses will be accepted without marking the unit activation as failed.
- **ExecStartPre=:** This can be used to provide additional commands that should be executed before the main process is started. This can be used multiple times. Again, commands must specify a full path and they can be preceded by “-” to indicate that the failure of the command will be tolerated.
ExecStartPost=: This has the same exact qualities as ExecStartPre= except that it specifies commands that will be run after the main process is started.
ExecReload=: This optional directive indicates the command necessary to reload the configuration of the service if available.
ExecStop=: This indicates the command needed to stop the service. If this is not given, the process will be killed immediately when the service is stopped.
ExecStopPost=: This can be used to specify commands to execute following the stop command.
RestartSec=: If automatically restarting the service is enabled, this specifies the amount of time to wait before attempting to restart the service.
Restart=: This indicates the circumstances under which systemd will attempt to automatically restart the service. This can be set to values like “always”, “on-success”, “on-failure”, “on-abnormal”, “on-abort”, or “on-watchdog”. These will trigger a restart according to the way that the service was stopped.
TimeoutSec=: This configures the amount of time that systemd will wait when stopping or stopping the service before marking it as failed or forcefully killing it. You can set separate timeouts with TimeoutStartSec= and TimeoutStopSec= as well.
