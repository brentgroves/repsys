# **[Deactivate Conda environment](https://stackoverflow.com/questions/990754/how-to-leave-exit-deactivate-a-python-virtualenv)**

Usually, activating a virtualenv gives you a shell function named:

$ deactivate
which puts things back to normal.

I have just looked specifically again at the code for virtualenvwrapper, and, yes, it too supports deactivate as the way to escape from all virtualenvs.

If you are trying to leave an Anaconda environment, the command depends upon your version of conda. Recent versions (like 4.6) install a conda function directly in your shell, in which case you run:

conda deactivate
