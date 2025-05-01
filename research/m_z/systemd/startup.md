# **[Run a script at startup](https://www.tutorialspoint.com/run-a-script-on-startup-in-linux#:~:text=Make%20the%20script%20file%20executable,scriptname%20defaults%22%20in%20the%20terminal.)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## reference

- **[invoke-iptables-from-systemd-unit-file](https://unix.stackexchange.com/questions/694357/how-to-invoke-iptables-from-systemd-unit-file)**

## Using systemd

To run a script on startup using systemd, you will need to do the following ?

- Create a new service file in the /etc/systemd/system directory. You can use a text editor such as nano or vi to create the file. The file name should be in the format of "yourscriptname.service"

- Add the following lines to the service file

```systemd
[Unit]
Description=Description of your script
After=network.target

[Service]
<!-- typical path would be /usr/share/dbeaver-ce mode 755-->
ExecStart=/path/to/script arg1 arg2
Restart=always
User=root
Group=root
Type=simple

[Install]
WantedBy=multi-user.target
```

- Save and exit the file.
- Reload the systemd manager configuration by running the following command "sudo systemctl daemon-reload"
- Enable the service by running the following command "sudo systemctl enable yourscriptname.service"
- Start the service by running the following command "sudo systemctl start yourscriptname.service"
- Restart your system to test that the script is being run on startup

It's important to note that the path to the script must be the full path, not a relative path. Also make sure the script has execute permission.

The "After" field in the Unit section can be set to different values depending on the dependencies of your script, for example if your script requires the network to be up, it should have "network.target" as value, otherwise you can use "default.target"
