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
pushd .
cd ~/src/repsys/research/m_z/systemd/uv

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

```bash
# from 1st terminal
# after starting service
journalctl -u uvtest2.service 
May 07 12:26:16 research21 systemd[1]: Started uvtest2.service - Run Python script with uv.
May 07 12:26:16 research21 env[566307]: Installed 7 packages in 12ms
May 07 12:26:17 research21 env[566400]:  * Serving Flask app 'uvtest2'
May 07 12:26:17 research21 env[566400]:  * Debug mode: off
May 07 12:26:17 research21 env[566400]: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 12:26:17 research21 env[566400]:  * Running on all addresses (0.0.0.0)
May 07 12:26:17 research21 env[566400]:  * Running on http://127.0.0.1:8080
May 07 12:26:17 research21 env[566400]:  * Running on http://10.187.40.123:8080
May 07 12:26:17 research21 env[566400]: Press CTRL+C to quit
May 07 12:27:56 research21 env[566400]: 127.0.0.1 - - [07/May/2025 12:27:56] "GET / HTTP/1.1" 200 -

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/uv
cp uvtest2.py /etc/mytests/test2/
cp uvtest2.service /etc/systemd/system/
sudo systemctl start uvtest2
# check status
sudo systemctl status uvtest2
● uvtest2.service - Run Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest2.service; disabled; preset: enabled)
     Active: active (running) since Wed 2025-05-07 12:26:16 EDT; 19min ago
   Main PID: 566307 (uv)
      Tasks: 7 (limit: 38302)
     Memory: 37.3M (peak: 38.4M)
        CPU: 1.170s
     CGroup: /system.slice/uvtest2.service
             ├─566307 uv run uvtest2.py
             └─566400 /home/brent/.cache/uv/environments-v2/uvtest2-919d75032003516f/bin/python uvtest2.py

May 07 12:26:16 research21 systemd[1]: Started uvtest2.service - Run Python script with uv.
May 07 12:26:16 research21 env[566307]: Installed 7 packages in 12ms
May 07 12:26:17 research21 env[566400]:  * Serving Flask app 'uvtest2'
May 07 12:26:17 research21 env[566400]:  * Debug mode: off
May 07 12:26:17 research21 env[566400]: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 12:26:17 research21 env[566400]:  * Running on all addresses (0.0.0.0)
May 07 12:26:17 research21 env[566400]:  * Running on http://127.0.0.1:8080
May 07 12:26:17 research21 env[566400]:  * Running on http://10.187.40.123:8080
May 07 12:26:17 research21 env[566400]: Press CTRL+C to quit
May 07 12:27:56 research21 env[566400]: 127.0.0.1 - - [07/May/2025 12:27:56] "GET / HTTP/1.1" 200 -

# stop service
sudo systemctl stop uvtest2

# check status
sudo systemctl status uvtest2

× uvtest2.service - Run Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest2.service; disabled; preset: enabled)
     Active: failed (Result: exit-code) since Wed 2025-05-07 12:47:12 EDT; 15s ago
   Duration: 20min 56.391s
    Process: 566307 ExecStart=/usr/bin/env uv run uvtest2.py (code=exited, status=143)
   Main PID: 566307 (code=exited, status=143)
        CPU: 1.188s

May 07 12:26:17 research21 env[566400]:  * Running on all addresses (0.0.0.0)
May 07 12:26:17 research21 env[566400]:  * Running on http://127.0.0.1:8080
May 07 12:26:17 research21 env[566400]:  * Running on http://10.187.40.123:8080
May 07 12:26:17 research21 env[566400]: Press CTRL+C to quit
May 07 12:27:56 research21 env[566400]: 127.0.0.1 - - [07/May/2025 12:27:56] "GET / HTTP/1.1" 200 -
May 07 12:47:12 research21 systemd[1]: Stopping uvtest2.service - Run Python script with uv...
May 07 12:47:12 research21 systemd[1]: uvtest2.service: Main process exited, code=exited, status=143/n/a
May 07 12:47:12 research21 systemd[1]: uvtest2.service: Failed with result 'exit-code'.
May 07 12:47:12 research21 systemd[1]: Stopped uvtest2.service - Run Python script with uv.
May 07 12:47:12 research21 systemd[1]: uvtest2.service: Consumed 1.188s CPU time, 38.4M memory peak, 0B memory swap peak.
```

## temporary environments

Where does flask get installed?

```bash
# Environment=PATH=/home/brent/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# WorkingDirectory=/etc/mytests/test2

ls $HOME/.cache/uv/environments-v2

server-3827603ed46bafa8  socketthing-7d6b171392dc7764  uvtest2-919d75032003516f

# answer: it created the environment the user of the service unit's local cache. it first created a directory and the installed all the dependancies in it.
ls $HOME/.cache/uv/environments-v2/uvtest2-919d75032003516f 

bin  CACHEDIR.TAG  lib  lib64  pyvenv.cfg

ls $HOME/.cache/uv/environments-v2/uvtest2-919d75032003516f/bin

activate  activate.bat  activate.csh  activate.fish  activate.nu  activate.ps1  activate_this.py  deactivate.bat  flask  pydoc.bat  python  python3  python3.13

# didn't put anything in scripts working directory.
ls -ahl /etc/mytests/test2

total 12K
drwxrwxr-x 2 brent brent 4.0K May  7 12:26 .
drwxrwxrwx 3 root  root  4.0K May  7 12:21 ..
-rwxrwxr-x 1 brent brent  302 May  7 12:26 uvtest2.py
```

## By Unit

To see messages logged by any systemd unit, use the -u switch. The command below will show all messages logged by the Nginx web server. You can use the --since and --until switches here to pinpoint web server errors occurring within a time window.

```bash
journalctl -u uvtest2.service
```
