# **[bash process substitution](https://unix.stackexchange.com/questions/324167/meaning-of-2-command-redirection-in-bash)**

## references

- **[](https://tldp.org/LDP/abs/html/process-sub.html)**

```bash
# !/bin/bash

LOGFILE=/some/path/mylogfile

(

# here go my commands which produce some stdout

# and, if something goes wrong, also some stderr

) 1>>${LOGFILE} 2> >( tee -a ${LOGFILE} >&2 )
```

## **[process substitution](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html)**

>(...) is called process substitution. It lets the "outer" program write to the "inner" program as if it were a file.

In this case it's writing stderr to tee -a ${LOGFILE} >&2 which will append to LOGFILE and then also write everything back to stderr.

The redirection operator can go in either direction for process substitution, so you can write to it, as in this example, or use <(...) to read from it, which is a handy way to, for example, do a while loop without running it in a subshell itself.

```bash
exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# The logging levels are defined in sd-daemon(3):

#define SD_EMERG   "<0>"  /* system is unusable */
#define SD_ALERT   "<1>"  /* action must be taken immediately */
#define SD_CRIT    "<2>"  /* critical conditions */
#define SD_ERR     "<3>"  /* error conditions */
#define SD_WARNING "<4>"  /* warning conditions */
#define SD_NOTICE  "<5>"  /* normal but significant condition */
#define SD_INFO    "<6>"  /* informational */
#define SD_DEBUG   "<7>"  /* debug-level messages */

```
