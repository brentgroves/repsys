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
rm -f ~/bin/shell_scripts/end*.sh 
rm -f ~/bin/shell_scripts/start*.sh 
rm -f ~/bin/shell_scripts/cp_*.sh 
rm -f ~/bin/shell_scripts/freshstart*.sh 
rm -f ~/bin/shell_scripts/scc.sh 
cp ~/src/repsys/volumes/shell_scripts/end*.sh ~/bin/shell_scripts/
cp ~/src/repsys/volumes/shell_scripts/start*.sh ~/bin/shell_scripts/
cp ~/src/repsys/volumes/shell_scripts/cp_*.sh ~/bin/shell_scripts/
cp ~/src/repsys/volumes/shell_scripts/freshstart*.sh ~/bin/shell_scripts/
cp ~/src/repsys/volumes/shell_scripts/scc.sh ~/bin/shell_scripts/

popd
