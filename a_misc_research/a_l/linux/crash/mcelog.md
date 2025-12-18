# **[mcelog](https://mcelog.org/)**

mcelog logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.
mcelog is required by both 32bit x86 Linux kernels (since 2.6.30) and 64bit Linux kernels (since early 2.6 kernel releases) to log machine checks and should run on all Linux systems that need error handling.

The mcelog daemon accounts memory and some other errors errors in various ways. mcelog --client can be used to query a running daemon. The daemon can also execute triggers when configurable error thresholds are exceeded. This is used to implement a range of automatic predictive failure analysis algorithms: including bad page offlining and automatic cache error handling. User defined actions can be also configured.

All errors are logged to /var/log/mcelog or syslog or the journal.

For memory errors it supports modern x86 systems with integrated memory controllers; for CPU errors all modern x86 systems are supported.

Traditionally mcelog was run as a cronjob, but this usage is deprecated now. The modern way to run it is to start it at boot up time and run it always as a daemon. In addition it can be used to decode fatal machine checks on the command line (but this is also usually not needed anymore on modern kernels which log those after reboot automatically)

For installation information and how to set up a mcelog package (if you're a distributor) please see the README.
