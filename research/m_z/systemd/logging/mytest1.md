# mytest1 service

## logging technique for shell scripts

Since the question mentions Arch Linux (systemd-controlled from day one) and logging, I'll hazard a guess it is related to logging from a systemd service. Here's another **[logging technique for shell scripts](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Logging%20and%20Standard%20Input/Output)** invoked from systemd service units. systemd can be (and by default is) set up to listen to the service's processes stderr and/or stdout, and forward messages to the journal. When a message starts with a 3-character prefix '<' N '>', where N is a digit from 0 to 7, systemd interprets it as the log level, omits it, and logs the rest of the string at the specified level.

## Example

A shell script (Bash in this case, relying on process substitution and trap ... EXIT behavior), taken from a real service's ExecStartPre script:

```bash
# !/bin/bash

# Redirect stderr such that any message is reported as an error to journald by

# prepending '<3>' to it. Use fd 4 (the saved stderr) to directly report other

# severity levels

exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# >(...) is called process substitution. It lets the "outer" program write to the "inner" program as if it were a file.

# In this case it's writing stderr to tee -a ${LOGFILE} >&2 which will append to LOGFILE and then also write everything back to stderr.

# The redirection operator can go in either direction for process substitution, so you can write to it, as in this example, or use <(...) to read from it, which is a handy way to, for example, do a while loop without running it in a subshell itself.

# No; stdin is a FIFO to tee 'cos it's >(...). The more normally seen <(...) would make stdout point to the FIFO

# Systemd can kill the logging subshell swiftly when we exit, and lose messages

# Close the subshell before exiting the main program explicitly. This will block

# until the read builtin reads the EOF

trap 'exec >&2-' EXIT

### From this point on, all stderr messages will be logged to syslog as errors

### via the subshell running the while loop. Fd 4 is the old stderr, and may

### be used to specify non-error level

echo >&2 "This message is logged as an error, red and bold."

echo >&4 "<5>This is logged as a notice-level message, dim and boring."

echo >&4 "This is logged at the default severity level, 'info' unless changed."
```

The settings in the unit file generally do not need to be set specially. stderr logging works out of the box, unless globally overridden in **[systemd-system.conf(5)](https://www.freedesktop.org/software/systemd/man/systemd-system.conf.html)** or **[journald.conf(5)](https://www.freedesktop.org/software/systemd/man/journald.conf.html)**. The defaults are:

```bash
[Service]
; These defaults may be overridden in systemd-system.conf(5).
;StandardError=journal
;StandardOutput=journal

; These defaults may be overridden in journald.conf(5).
;LogLevelMax=debug
;LogRateLimitIntervalSec=10000
;LogRateLimitBurst=30s

; Extra fields may be added to every message.
;LogExtraFields=

;; Other settings:

; Defaults to process name. NOT the unit name, but rather basename(3) of the $0.
;SyslogIdentifier=

; For messages written without the <N> prefix.
;SyslogLevel=info

;SyslogFacility=daemon

; For completeness only: The level-parsing machinery can be disabled, but that
; was the whole point...
;SyslogLevelPrefix=true
```

Note that systemd redirects all commands invoked with the Exec* settings, not only the main service process ExecStart, but also ExecStartPre, ExecStartPost, etc.

To run the example, save the above script as logging-test.sh, run with systemd-run as a temporary unit, then query the full properties of every log record. If you do not see the info level message, check if journald.conf limits the logging level stored in the journal to a higher value.

```bash
systemd-run --user --wait ./mytest1.sh
journalctl -t mytest1.sh
$ journalctl -t mytest1.sh -o json-pretty
```

The logging levels are defined in sd-daemon(3):

```bash
# define SD_EMERG   "<0>"  /*system is unusable */
# define SD_ALERT   "<1>"  /* action must be taken immediately */
# define SD_CRIT    "<2>"  /* critical conditions */
# define SD_ERR     "<3>"  /* error conditions */
# define SD_WARNING "<4>"  /* warning conditions */
# define SD_NOTICE  "<5>"  /* normal but significant condition */
# define SD_INFO    "<6>"  /* informational */
# define SD_DEBUG   "<7>"  /* debug-level messages*/
```

## References

- **[systemd.exec(5)](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Logging%20and%20Standard%20Input/Output)**, Logging and Standard Input/Output.
- **[sd-daemon(3)](https://www.freedesktop.org/software/systemd/man/sd-daemon.html)**.
- **[systemd-system.conf(5)](https://www.freedesktop.org/software/systemd/man/systemd-system.conf.html)** (the file name is normally systemd.conf, named here is the man page).
- **[journald.conf(5)](https://www.freedesktop.org/software/systemd/man/journald.conf.html)**.

## Test unit file

```bash
pushd .
cd ~/src/repsys/research/m_z/systemd/logging/iptables
sudo mkdir /etc/mytests
sudo chmod 777 /etc/mytests
# copy contents
cp ./*.sh /etc/myiptables/
# verify
ls -alh /etc/myiptables
total 24K
drwxrwxrwx   2 root  root  4.0K May  1 15:47 .
drwxr-xr-x 148 root  root   12K May  1 15:34 ..
-rwxrwxr-x   1 brent brent 2.0K May  1 15:47 delete_myrules.sh
-rwxrwxr-x   1 brent brent 2.3K May  1 15:47 recreate_myrules.sh

```

## manually test scripts without systemd

```bash
iptables -S
iptables -t nat -S
/etc/myiptables/recreate_rules.sh
/etc/myiptables/delete_rules.sh
```
