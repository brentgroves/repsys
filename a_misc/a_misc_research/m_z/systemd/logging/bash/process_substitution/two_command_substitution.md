# **[Meaning of '2> >(command)' Redirection in Bash](https://unix.stackexchange.com/questions/324167/meaning-of-2-command-redirection-in-bash)**

## references

- **[](https://tldp.org/LDP/abs/html/process-sub.html)**

A while ago I made a script and I added some logging around it, but I forgot how the redirection for the logging works :-(

The gist of it is:

```bash
# !/bin/bash

LOGFILE=/some/path/mylogfile

(

# here go my commands which produce some stdout

# and, if something goes wrong, also some stderr

) 1>>${LOGFILE} 2> >( tee -a ${LOGFILE} >&2 )
# used because standard error cannot be piped to tee
```

When I run the script, it doesn't print anything to stdout, but only prints what goes to stderr. Logfile ${LOGFILE} captures both stdout and stderr.

When I run the script and there is no output on my terminal, then I know everything is fine. If there is any output, I know something went wrong and I can check the logfile to find out what the problem is.

The part of the redirection that now puzzles me is the syntax of: 2> >( some command )

Can anyone explain what is going on there?

## answer

>(...) is called **[process substitution](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html)**. It lets the "outer" program write to the "inner" program as if it were a file.

In this case it's writing stderr to tee -a ${LOGFILE} >&2 which will append to LOGFILE and then also write everything back to stderr.

In Bash, expressions enclosed in parentheses serve multiple purposes, impacting how commands are grouped, executed, and evaluated. The behavior depends on the type and context of the parentheses used.

The redirection operator can go in either direction for process substitution, so you can write to it, as in this example, or use <(...) to read from it, which is a handy way to, for example, do a while loop without running it in a subshell itself.

## replies

Got it :-) If I execute echo <(date), it gives me the name of the substituted file: /dev/fd/63. If I execute cat <(date), it gives me the date, i.e. the content of the substituted file: Fri Nov 18 14:11:09 NZDT 2016. –
NZD

```bash
echo <(date)
/proc/self/fd/11
 brent@research21  ~/src/repsys   main ±  cat <(date) 
Sat May  3 05:47:12 PM EDT 2025
 brent@research21  ~/src/repsys   main ±  more <(date)
Sat May  3 05:47:37 PM EDT 2025
 brent@research21  ~/src/repsys   main ±  less <(date)
/proc/self/fd/11 is not a regular file (use -f to see it)
```

 CommentedNov 18, 2016 at 1:21
@NZD, yes - but don't imagine it's a regular file - what you see in /dev is a name for the pipe between the processes. –
Toby Speight
 CommentedNov 18, 2016 at 8:36
Is this technique used because stderr cannot be piped (to tee, in this case)? –
bli
 CommentedNov 23, 2016 at 12:58
@bli Yeah, since stdout is already being redirected elsewhere this seems to me like the most straightforward way to tee stderr and keep it separate from stdout. –
Eric Renouf
 CommentedNov 23, 2016 at 13:00

## Subshells: (command)

Enclosing commands in single parentheses creates a subshell. This means the commands inside the parentheses are executed in a separate, independent environment. Changes made within the subshell, such as variable assignments or directory changes, do not affect the current shell.

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
