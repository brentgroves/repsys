#!/bin/bash

exec 3> output.txt
echo "This will be written to output.txt" >&3
exec 3>&-
# This command opens output.txt for writing on file descriptor 3, 
# writes to it, and then closes the file descriptor.
# exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)
