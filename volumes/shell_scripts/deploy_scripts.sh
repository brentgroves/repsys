#!/bin/bash
# run: bash deploy_scripts.sh // if you don't zsh will run and it ignores rm -f
# https://gist.github.com/gitaarik/8735255
# https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if-else/rm-if-exists/#:~:text=To%20delete%20a%20file%20by,along%20with%20the%20rm%20command.
pushd .
#  -f          Attempt to remove the files without prompting for confirma-
#              tion, regardless of the file's permissions.  If the file does
#              not exist, do not display a diagnostic message or modify the
#              exit status to reflect an error.  The -f option overrides any
#              previous -i options.


# rm -f ~/end*.sh ~/start*.sh ~/cp_*.sh ~/freshstart*.sh ~/scc.sh 
# -f zsh ignores this option so instead of having to remember to 
# type "bash deploy_scripts.sh" I created many rm statements instead
rm -f ~/end*.sh 
rm -f ~/start*.sh 
rm -f ~/cp_*.sh 
rm -f ~/freshstart*.sh 
rm -f ~/scc.sh 
cp ~/src/repsys/shell_scripts/end*.sh ~/
cp ~/src/repsys/shell_scripts/start*.sh ~/
cp ~/src/repsys/shell_scripts/cp_*.sh ~/
cp ~/src/repsys/shell_scripts/freshstart*.sh ~/
cp ~/src/repsys/shell_scripts/scc.sh ~/


popd
