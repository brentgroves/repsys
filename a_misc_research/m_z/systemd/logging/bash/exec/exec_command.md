# AI Overview

The exec command in Bash replaces the current shell process with the command specified, rather than creating a new process. This is useful for running a command without forking a new process, which can save resources. It is also used for redirecting file descriptors.
When exec is used with a command, it replaces the current shell with that command. The original shell is terminated, and the new command takes its place. If the command does not exist, the shell will exit with an error.
**When exec is used without a command, it can be used to modify file descriptors for the current shell.** This means that input and output can be redirected for the current shell environment.
Here are a few examples of how exec can be used:

- **exec command:** Replace the current shell with command.
- **exec < file:** Redirect standard input to file.
- **exec > file:** Redirect standard output to file.
- **exec 2> file:** Redirect standard error to file.
- **exec > file 2>&1:** Redirect both standard output and standard error to file.
- **exec 3< file:** Open file for reading on file descriptor 3.
- **exec 4> file:** Open file for writing on file descriptor 4.

It's important to note that exec will not return to the original shell, so any commands after exec in a script will not be executed unless exec fails.

```bash
exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# >(...) is called process substitution. It lets the "outer" program write to the "inner" program as if it were a file

# exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# File descriptor 4 is redirected to standard error. Standard error is redirected to the inner process. I'm not sure of this.
```
