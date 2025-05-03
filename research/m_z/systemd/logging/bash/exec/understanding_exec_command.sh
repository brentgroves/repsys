#!/bin/bash
# https://unix.stackexchange.com/questions/634350/understanding-exec-command

# I'm trying to learn the effect of exec > >(tee logfile) in the following code:

#!/bin/bash                                                                                                                 

exec 7>&1           # save stdout for later reset                                                                           

exec > >(tee logfile)          # point stdout to FIFO pointing to tee command?                                              
#+expect any subsequent output to stdout to be sent                                                                         
#+both to stdout and logfile.                                                                                               

# so let's send some output                                                                                                 
echo
echo howdy             # expect these strings to be sent both to terminal and                                               
echo g\'day            #+logfile                                                                                            
echo hello!

# restore stdout                                                                                                            
exec 1>&7
exec 7>&-

#check content of logfile!                                                                                                  
echo ------------
cat logfile

# The general form of the commmand is exec > output which causes all further output to stdout to be sent to the file "output".

# This can be extended; eg exec 2> error will cause all futher output to stderr to be sent to the file "error"

# Now, >(...) is a bashism that means write the output to a command; in this case the command is "tee logfile"

# So we add the two together.

# exec > >(tee logfile) means "write all further output to the command tee logfile".

# Which means that all future output will be sent to the screen and (via tee) to the file "logfile"

# No; stdin is a FIFO to tee 'cos it's >(...). The more normally seen <(...) would make stdout point to the FIFO