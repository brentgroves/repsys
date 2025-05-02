#!/bin/bash
# https://stackoverflow.com/questions/7082001/how-do-file-descriptors-work
echo "This"
echo "is" >&2
echo "a" >&3
echo "test." >&4

# It works if you invoke it differently:
# ./fdtest 3>&1 4>&1
# which means to redirect file descriptors 3 and 4 to 1 
# (which is standard output).

# exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)
# redirect fd 4 to stderr