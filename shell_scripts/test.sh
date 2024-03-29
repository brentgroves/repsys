#!/bin/bash
#  -f          Attempt to remove the files without prompting for confirma-
#              tion, regardless of the file's permissions.  If the file does
#              not exist, do not display a diagnostic message or modify the
#              exit status to reflect an error.  The -f option overrides any
#              previous -i options.


# rm -f ~/end*.sh ~/start*.sh ~/cp_*.sh ~/freshstart*.sh ~/scc.sh 
# -f zsh ignores this option so instead of having to remember to 
# type "bash deploy_scripts.sh" I created many rm statements instead


rm -f ~/end*.sh ~/start*.sh ~/cp_*.sh ~/freshstart*.sh ~/scc.sh 

