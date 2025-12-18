# strace on shell scripts

## AI Overview

To use strace on a shell script, execute the command strace followed by the path to the script. This will trace all system calls made by the script and output them to the standard error stream.
For example, if the shell script is named my_script.sh, the command would be:

`strace ./strace1.sh`

To save the output to a file instead of printing it to the terminal, redirect the standard error stream using -o:
Code

`strace -o output.txt ./strace1.sh`

To follow child processes created by the script, use the -f option:
Code

`strace -f ./strace1.sh`
