#

I do not know of a direct equivalent, but lshw should give you the info you want, try:

sudo lshw -C display
(it also works without sudo but the info may be less complete/accurate)

You can also install the package lshw-gtk to get a GUI.
