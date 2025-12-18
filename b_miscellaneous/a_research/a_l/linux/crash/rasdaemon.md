# **[rasdaemon](https://manpages.ubuntu.com/manpages/jammy/man8/rasdaemon.8.html)**

 The rasdaemon program is a daemon which monitors the platform Reliablity, Availability and Serviceability
       (RAS)   reports   from   the   Linux   kernel   trace   events.   These   trace   events  are  logged  in
       /sys/kernel/debug/tracing, reporting them via syslog/journald.

  --usage
              Display a brief usage message and exit.

       --help Display a help message and exit.

       --disable  --usage
              Display a brief usage message and exit.

       --help Display a help message and exit.

       --disable
              Disable RAS tracing events and exit.

       --enable
              Enable RAS tracing events and exit.

       --foreground
              Executes in foreground, printing the events at console. Useful for testing it, and to be  used  by
              systemd or Unix System V respan.  If not specified, the program runs in daemon mode.

       --record
              Record RAS events via Sqlite3. The Sqlite3 database has the benefit of keeping a persistent record
              of  the  RAS  events. This feature is used with the ras-mc-ctl utility. Note that rasdaemon may be
              compiled without this feature.

       --version
              Print the program version and exit.

CONFIG FILE
       The rasdaemon program supports a config file to set rasdaemon systemd service environment  variables.  By
       default the config file is read from /etc/sysconfig/rasdaemon.

       The general format is environmentname=value.

              Disable RAS tracing events and exit.

       --enable
              Enable RAS tracing events and exit.

       --foreground
              Executes in foreground, printing the events at console. Useful for testing it, and to be  used  by
              systemd or Unix System V respan.  If not specified, the program runs in daemon mode.

       --record
              Record RAS events via Sqlite3. The Sqlite3 database has the benefit of keeping a persistent record
              of  the  RAS  events. This feature is used with the ras-mc-ctl utility. Note that rasdaemon may be
              compiled without this feature.

       --version
              Print the program version and exit.

CONFIG FILE
       The rasdaemon program supports a config file to set rasdaemon systemd service environment  variables.  By
       default the config file is read from /etc/sysconfig/rasdaemon.

       The general format is environmentname=value.
