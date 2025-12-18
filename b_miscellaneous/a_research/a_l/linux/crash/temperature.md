# **[temp](https://www.baeldung.com/linux/cpu-temperature)**

In this tutorial, we’ll take a look at how we can check for the CPU temperature on the Linux terminal. First, we’ll see how we can figure out the temperature of our CPUs without the help of third-party tools. Afterward, we’ll cover a couple of small useful utilities for the same purpose.

2. Finding CPU Temperature Without Third-Party Tools
On Linux, we can read almost every accessible detail related to hardware resources. These details include the count of the CPU cycles, CPU temperature, I/O usage, network usage, and more. This is all possible because Linux gives us more control over the hardware and software.

2.1. The /sys/class Directory
The /sys directory is a virtual file system that contains a plethora of information regarding the Linux kernel and the hardware. The files inside this directory don’t actually reside on the disk. Instead, they’re only created and updated on-the-fly as we read them.

The /sys/class directory is the hierarchy of the hardware. This directory mostly contains information about the devices that are registered with the kernel.

One of the directories is called thermal, which contains temperature information of the hardware resources:

$ ls -lL /sys/class/thermal
total 0
...
drwxr-xr-x 3 root root 0 Apr 7 00:05 cooling_device7
drwxr-xr-x 3 root root 0 Apr 7 00:05 cooling_device8
drwxr-xr-x 4 root root 0 Apr 7 00:05 thermal_zone0
drwxr-xr-x 3 root root 0 Apr 7 00:05 thermal_zone1
drwxr-xr-x 3 root root 0 Apr 7 00:05 thermal_zone2
Copy
In this directory, we’re concerned with the thermal_zone directories. The thermal_zone directories correspond to the thermometers placed on our motherboard.

Let’s cd into the thermal_zone0 directory and check what it contains:

$ cd thermal_zone0 && ls -lL
total 0
...
drwxr-xr-x 2 root root    0 Apr  7 00:05 subsystem
-rw-r--r-- 1 root root 4096 Apr  7 00:55 sustainable_power
-r--r--r-- 1 root root 4096 Apr  7 00:29 temp
-r--r--r-- 1 root root 4096 Apr  7 00:29 type
-r--r--r-- 1 root root 4096 Apr  7 00:29 trip_point_0_temp
...
Copy
As we can see, it includes lots of files and directories. However, we’re only interested in the temp and the type files.

2.2. The temp File
The temp file contains the actual temperature of the zone. It should contain just a single integer value:

$ cat temp
27800
Copy
We can divide this value by 100 to get the actual temperature in Celsius. In this case, it would be 27.8 °C.

2.3. The type File
The type file contains a value that signifies the zone to which the temperature corresponds:

$ cat type
acpitz
Copy
The acpitz thermometer is located beside the CPU socket. However, we are interested in the CPU temperature. Similarly, for the CPUs, we can check the other thermal_zone directories that might contain this thermal information.

2.4. Putting It All Together
It can be tedious to check for CPU temperature this way because these directories might be different on different machines. Interestingly, the zone information is defined in the driver for the hardware resources.

For that reason, we might want to use a command that prints out this information in a readable way:

```bash
paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
acpitz        27.8°C
acpitz        29.8°C
x86_pkg_temp  38.0°C
```

We read the type and file files from each thermal_zone directory and feed the result to paste
The paste command will align the lines from the corresponding files, separated by tabs
We pipe the output of the paste command to column, which further aligns the output into columns
The contents of column are then piped to sed, which replaces the values with readable temperature values
Additionally, we can create a simple shell script out of this rather long command and execute it either directly or from another script.

## 3. Alternative: lm_sensors

lm_sensors is a handy utility for monitoring temperatures, voltage, fan speed, and other hardware sensor information.

3.1. Installation
On major Linux distributions, lm_sensors should already be installed. However, if it’s not, we can use a package manager to install it from our distro’s official package repository:

# Ubuntu-like

$ apt install lm-sensors
Copy

# Fedora, RHEL, openSUSE

$ yum install lm_sensors
Copy

# Arch-like

$ pacman -S lm_sensors
Copy
Once installed, let’s verify it:

$ sensors -v
sensors version 3.6.0+git with libsensors version 3.6.0+git
Copy

## 3.2. Usage

We can use lm_sensors by simply typing in the sensors command:

$ sensors
acpitz-acpi-0
Adapter: ACPI interface
temp1:        +27.8 C
temp2:        +29.8 C

coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +40.0 C
Core 0:        +39.0 C
Core 1:        +40.0 C
Copy
As we can see, the CPU temperature for each core is given in the Core 0 and Core 1 fields, respectively.

Moreover, if it doesn’t display the CPU temperature, we can run the sensors-detect command beforehand. The sensors-detect command will detect all the available sensors attached to the machine.

## 4. Alternative: acpi

acpi is another lightweight alternative that we can use to display the temperature and battery information.

## 4.1. Installation

The acpi utility doesn’t ship with most distributions, so we’ll have to install it from our official package repository using the package name acpi:

# Ubuntu-like

$ apt install acpi
Copy

# Fedora, RHEL, openSUSE

$ yum install acpi
Copy

# Arch-like

$ pacman -S acpi
Copy

After the installation, let’s verify it:

$ acpi -v
acpi 1.7
Copy

4.2. Usage
We can print out the temperature information with acpi by simply running it with the -t or –thermal opention:

$ acpi -t
Thermal 0: ok, 29.8 degrees C
Thermal 1: ok, 27.8 degrees C
Copy
We can print a detailed report with the -i or –details option as well.

5. Conclusion
In this article, we covered how we can check the thermal status of our CPUs. First, we experimented with the raw thermal details provided by the Kernel in the /sys/class directory. Afterward, we used a couple of alternative tools that automate this process for us.
