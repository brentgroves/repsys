Hi April,

Happy Friday! I would like to setup some time to work on the Marposs Gauge today if possible.

Thanks,
Brent

ToDo:

- Verify the version of Windows the Marposs Gauge computer is using.
- Look at the directory structures and locate any existing CSV files.
- Determine what program is running.
- Make a backup of all existing programs and CSV file(s).

You can find your Windows version by going to Settings > System > About, or by typing winver in the Windows search bar and pressing Enter. The Settings app will show the edition, version, and OS build under "Windows specifications," while the winver command opens a pop-up window with the same details.

Status:

- The serial device server is now running on socket 10.188.74.11/4065.  Thank you Jared for creating the VLAN!
Currently, it is connected to a computer and not to the Marposs gauge.  A program is sending a number from 1 to 10 every 2 seconds.

Next I need to configure Merlin with qualities help.

We also will need another network drop for the long term but we could test with the one that is there already.

Thank you Carl for ordering a db9 F/F cable!
