#!/bin/bash
# systemd-run --user --wait ./bash_to_journald.sh
# journalctl -t my-script 
# Your script content here

# Redirect stdout and stderr to systemd-cat
{
  # Commands to be logged
  echo "<5>Starting the script..."
  # ... more commands ...
  echo "<2>log level 2"
  echo "<3>log level 3"
  echo "<4>log level 4"

} 2>&1 | systemd-cat -t my-script

The logging levels are defined in sd-daemon(3):

#define SD_EMERG   "<0>"  /* system is unusable */
#define SD_ALERT   "<1>"  /* action must be taken immediately */
#define SD_CRIT    "<2>"  /* critical conditions */
#define SD_ERR     "<3>"  /* error conditions */
#define SD_WARNING "<4>"  /* warning conditions */
#define SD_NOTICE  "<5>"  /* normal but significant condition */
#define SD_INFO    "<6>"  /* informational */
#define SD_DEBUG   "<7>"  /* debug-level messages */

# In Bash, 2>&1 redirects standard error (file descriptor 2) to standard output (file descriptor 1). By default, standard output and standard error are displayed on the terminal. This redirection merges the two streams, so both normal output and error messages are sent to the same destination, which is usually the terminal unless further redirection is applied.\systemd-cat is a tool used to connect the standard input and output of a process to the systemd journal.
# systemd-cat is a tool used to connect the standard input and output of a process to the systemd journal.