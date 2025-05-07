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

## test 3

```bash
# from 1st terminal
journalctl -u uvtest3.service -f 
# or if there were issues starting service
journalctl -f 

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/uv
mkdir -p /etc/mytests/test3/
cp uvtest3.py /etc/mytests/test3/
sudo cp uvtest3.service /etc/systemd/system/
sudo systemctl start uvtest3
# check status
sudo systemctl status uvtest3
● uvtest3.service - Run test3 Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest3.service; disabled; preset: enabled)
     Active: active (running) since Wed 2025-05-07 13:48:23 EDT; 16min ago
   Main PID: 578052 (uv)
      Tasks: 7 (limit: 38302)
     Memory: 38.0M (peak: 39.1M)
        CPU: 1.134s
     CGroup: /system.slice/uvtest3.service
             ├─578052 uv run uvtest3.py
             └─578149 /home/brent/.cache/uv/environments-v2/uvtest3-97bb5e48ccb151ae/bin/python uvtest3.py

May 07 13:48:23 research21 systemd[1]: Started uvtest3.service - Run test3 Python script with uv.
May 07 13:48:24 research21 env[578052]: Installed 7 packages in 10ms
May 07 13:48:24 research21 env[578149]:  * Serving Flask app 'uvtest3'
May 07 13:48:24 research21 env[578149]:  * Debug mode: off
May 07 13:48:24 research21 env[578149]: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 13:48:24 research21 env[578149]:  * Running on all addresses (0.0.0.0)
May 07 13:48:24 research21 env[578149]:  * Running on http://127.0.0.1:8080
May 07 13:48:24 research21 env[578149]:  * Running on http://10.187.40.123:8080
May 07 13:48:24 research21 env[578149]: Press CTRL+C to quit

# test it
 curl http://localhost:8080
# stop service
sudo systemctl stop uvtest3
journalctl -u uvtest3.service -f

May 07 13:48:24 research21 env[578052]: Installed 7 packages in 10ms
May 07 13:48:24 research21 env[578149]:  * Serving Flask app 'uvtest3'
May 07 13:48:24 research21 env[578149]:  * Debug mode: off
May 07 13:48:24 research21 env[578149]: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 13:48:24 research21 env[578149]:  * Running on all addresses (0.0.0.0)
May 07 13:48:24 research21 env[578149]:  * Running on http://127.0.0.1:8080
May 07 13:48:24 research21 env[578149]:  * Running on http://10.187.40.123:8080
May 07 13:48:24 research21 env[578149]: Press CTRL+C to quit
May 07 14:05:26 research21 env[578149]: 127.0.0.1 - - [07/May/2025 14:05:26] "GET / HTTP/1.1" 200 -
May 07 14:06:25 research21 systemd[1]: Stopping uvtest3.service - Run test3 Python script with uv...
May 07 14:06:25 research21 systemd[1]: uvtest3.service: Deactivated successfully.
May 07 14:06:25 research21 systemd[1]: Stopped uvtest3.service - Run test3 Python script with uv.
May 07 14:06:25 research21 systemd[1]: uvtest3.service: Consumed 1.223s CPU time, 39.1M memory peak, 0B memory swap peak.

# check status for any error
sudo systemctl status uvtest3

○ uvtest3.service - Run test3 Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest3.service; disabled; preset: enabled)
     Active: inactive (dead)

May 07 13:48:24 research21 env[578149]: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 13:48:24 research21 env[578149]:  * Running on all addresses (0.0.0.0)
May 07 13:48:24 research21 env[578149]:  * Running on http://127.0.0.1:8080
May 07 13:48:24 research21 env[578149]:  * Running on http://10.187.40.123:8080
May 07 13:48:24 research21 env[578149]: Press CTRL+C to quit
May 07 14:05:26 research21 env[578149]: 127.0.0.1 - - [07/May/2025 14:05:26] "GET / HTTP/1.1" 200 -
May 07 14:06:25 research21 systemd[1]: Stopping uvtest3.service - Run test3 Python script with uv...
May 07 14:06:25 research21 systemd[1]: uvtest3.service: Deactivated successfully.
May 07 14:06:25 research21 systemd[1]: Stopped uvtest3.service - Run test3 Python script with uv.
May 07 14:06:25 research21 systemd[1]: uvtest3.service: Consumed 1.223s CPU time, 39.1M memory peak, 0B memory swap peak.

# anytime 
journalctl -u uvtest3.service -f 
# or if there were issues starting service
journalctl -f 

```

## logging.info not shown in journal

logging.info messages might not be displayed due to the default logging level being set to WARNING. This means that by default, only messages with a severity level of WARNING or higher (i.e., WARNING, ERROR, CRITICAL) will be displayed. To show logging.info messages, the logging level needs to be set to INFO or DEBUG.

To resolve this, configure the logging level using logging.basicConfig() at the beginning of the script:

```python
import logging

logging.basicConfig(level=logging.INFO)

logging.info("This is an info message.")
logging.warning("This is a warning message.")
```

## temporary environments

Where does flask get installed?

```bash
# Environment=PATH=/home/brent/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# WorkingDirectory=/etc/mytests/test2

ls $HOME/.cache/uv/environments-v2

server-3827603ed46bafa8  socketthing-7d6b171392dc7764  uvtest2-919d75032003516f  uvtest3-97bb5e48ccb151ae

# answer: it created the environment the user of the service unit's local cache. it first created a directory and the installed all the dependancies in it.
ls $HOME/.cache/uv/environments-v2/uvtest3-97bb5e48ccb151ae 

bin  CACHEDIR.TAG  lib  lib64  pyvenv.cfg

ls $HOME/.cache/uv/environments-v2/uvtest3-97bb5e48ccb151ae/bin

activate  activate.bat  activate.csh  activate.fish  activate.nu  activate.ps1  activate_this.py  deactivate.bat  flask  pydoc.bat  python  python3  python3.13

# didn't put anything in scripts working directory.
ls -ahl /etc/mytests/test3

total 12K
drwxrwxr-x 2 brent brent 4.0K May  7 12:26 .
drwxrwxrwx 3 root  root  4.0K May  7 12:21 ..
-rwxrwxr-x 1 brent brent  302 May  7 12:26 uvtest2.py
```

## By Unit

To see messages logged by any systemd unit, use the -u switch. The command below will show all messages logged by the Nginx web server. You can use the --since and --until switches here to pinpoint web server errors occurring within a time window.

```bash
journalctl -u uvtest3.service
# or
journalctl -u uvtest3.service -f
```
