# AI Overview: Python uv from systemd unit file example

Here's an example of a systemd unit file to run a Python script using uv:
Code

```bash
[Unit]
Description=Run Python script with uv
After=network.target

[Service]
WorkingDirectory=/path/to/your/project
ExecStart=/usr/bin/env uv run your_script.py
User=your_user
Group=your_group
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

In this example:

- Description: Provides a description for the service.
- After: Specifies that the service should start after the network is up.
- WorkingDirectory: Sets the working directory for the script.
- ExecStart: Defines the command to execute, using uv run to run the Python script.
- User and Group: Define the user and group to run the script as.
- Restart: Configures the service to restart on failure.
- WantedBy: Specifies that the service should be enabled for multi-user targets.

## To use this unit file

- Save it as your_service.service in `/etc/systemd/system/`.
- Replace `/path/to/your/project, your_script.py`, your_user, and your_group with your actual paths, script name, user, and group.
- Enable and start the service using systemctl enable your_service and  systemctl start your_service.
- Check the status of the service using systemctl status your_service.
- View logs using journalctl -u your_service.

```bash
# from 1st terminal
journalctl -f

# from 2nd terminal
cp uvtest1.py /etc/mytests/
cp uvtest1.service /etc/systemd/system/
sudo systemctl start uvtest1
# journalctl terminal
May 06 17:33:14 research21 sudo[542302]:    brent : TTY=pts/0 ; PWD=/home/brent/src/repsys/research/m_z/systemd/uv ; USER=root ; COMMAND=/usr/bin/systemctl start uvtest1
May 06 17:33:14 research21 sudo[542302]: pam_unix(sudo:session): session opened for user root(uid=0) by brent(uid=1000)
May 06 17:33:14 research21 systemd[1]: Started uvtest1.service - Run Python script with uv.
May 06 17:33:14 research21 sudo[542302]: pam_unix(sudo:session): session closed for user root
May 06 17:33:14 research21 env[542351]: Hello, world!
May 06 17:33:14 research21 systemd[1]: uvtest1.service: Deactivated successfully.
May 06 17:33:14 research21 tracker-miner-fs-3[542352]: (tracker-extract-3:542352): GLib-GIO-WARNING **: 17:33:14.969: Error creating IO channel for /proc/self/mountinfo: Invalid argument (g-io-error-quark, 13)

sudo systemctl status uvtest1
○ uvtest1.service - Run Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest1.service; disabled; preset: enabled)
     Active: inactive (dead)

May 06 17:33:14 research21 systemd[1]: Started uvtest1.service - Run Python script with uv.
May 06 17:33:14 research21 env[542351]: Hello, world!
May 06 17:33:14 research21 systemd[1]: uvtest1.service: Deactivated successfully.
```

## test 2

START HERE
