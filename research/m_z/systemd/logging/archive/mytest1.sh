#!/bin/bash

# Redirect stderr such that any message is reported as an error to journald by
# prepending '<3>' to it. Use fd 4 (the saved stderr) to directly report other
# severity levels.
exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# File descriptors 0, 1 and 2 are for stdin, stdout and stderr respectively.

# File descriptors 3, 4, .. 9 are for additional files. In order to use them, you need to open them first. For example:

# exec 3<> /tmp/foo  #open reading and writing fd 3.
# echo "test" >&3
# exec 3>&- #close fd 3.

# Systemd can kill the logging subshell swiftly when we exit, and lose messages.
# Close the subshell before exiting the main program explicitly. This will block
# until the read builtin reads the EOF.
trap 'exec >&2-' EXIT

### From this point on, all stderr messages will be logged to syslog as errors
### via the subshell running the while loop. Fd 4 is the old stderr, and may
### be used to specify non-error level:

echo >&2 "This message is logged as an error, red and bold."

echo >&4 "<5>This is logged as a notice-level message, dim and boring."

echo >&4 "This is logged at the default severity level, 'info' unless changed."
