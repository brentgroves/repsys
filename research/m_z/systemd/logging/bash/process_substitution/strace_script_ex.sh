#!/bin/bash
# https://unix.stackexchange.com/questions/316479/bash-process-substitution-in-exec-line-some-commands-stopped-working
ls -l "$1" >/tmp/out  
echo "SUCCESS" > "$1"
# cat /tmp/out                         
# l-wx------ 1 brent brent 64 May  3 15:33 /proc/self/fd/12 -> pipe:[1960887]

# So I have a bash command using process substitution in an exec line that stopped working recently, and it boils down to this example:

# 1.  This works, putting "SUCCESS" into log:
# rm -f log; ./script.sh >(cat >log)
# cat log 
# SUCCESS
# cat /tmp/out
# l-wx------ 1 brent brent 64 May  3 15:33 /proc/self/fd/12 -> pipe:[1960887]

# 2. Using tail also works:
# rm -f log; ./script.sh >(tail >log)
# cat log 
# SUCCESS
# cat /tmp/out
# l-wx------ 1 brent brent 64 May  3 15:35 /proc/self/fd/12 -> pipe:[1960887]

# script.sh
# ls -l "$1" >/tmp/out  
# echo "SUCCESS" > "$1"

# 3. Using exec with cat works:
# rm -f log; exec ./script.sh >(cat >log)
# cd ~/src/repsys/research/m_z/systemd/logging/bash/process_substitution/

# cat log 
# SUCCESS
# cat /tmp/out
# l-wx------ 1 brent brent 64 May  3 15:37 /proc/self/fd/12 -> pipe:[1960887]

# So using strace on substituted process revealed that tail and head were getting a SIGHUP from the kernel before they had a chance to write. A simple workaround is to add nohup to the substitution:

# rm -f log; exec ./script.sh >(nohup tail >log)

# I think I understand why this fails with exec. IIUC, >(tail >log) creates a child process of the current bash process. However when using exec, it now becomes a child process of script.sh. When script.sh exits, the kernel sends SIGHUP to all child processes.

# Still not sure why this used to work, perhaps in newer kernel versions it is faster/more aggressive about sending its SIGHUPs.