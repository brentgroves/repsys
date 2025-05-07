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

## logging.info not shown in journal

logging.info messages might not be displayed due to the default logging level being set to WARNING. This means that by default, only messages with a severity level of WARNING or higher (i.e., WARNING, ERROR, CRITICAL) will be displayed. To show logging.info messages, the logging level needs to be set to INFO or DEBUG.

To resolve this, configure the logging level using logging.basicConfig() at the beginning of the script:

```python
import logging

logging.basicConfig(level=logging.INFO)

logging.info("This is an info message.")
logging.warning("This is a warning message.")
```

## test 4

```bash
# from 1st terminal
journalctl -u uvtest4.service -f 
# or if there were issues starting service
journalctl -f 

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/uv
mkdir -p /etc/mytests/test4/
cp uvtest4.py /etc/mytests/test4/
sudo cp uvtest4.service /etc/systemd/system/
sudo systemctl start uvtest4
# journal
journalctl -u uvtest4.service -f 

May 07 14:25:06 research21 env[584247]: Installed 7 packages in 7ms
May 07 14:25:07 research21 env[584296]:  * Serving Flask app 'uvtest4'
May 07 14:25:07 research21 env[584296]:  * Debug mode: off
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 14:25:07 research21 env[584296]:  * Running on all addresses (0.0.0.0)
May 07 14:25:07 research21 env[584296]:  * Running on http://127.0.0.1:8080
May 07 14:25:07 research21 env[584296]:  * Running on http://10.187.40.123:8080
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - Press CTRL+C to quit

# check status
sudo systemctl status uvtest4
● uvtest4.service - Run test4 Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest4.service; disabled; preset: enabled)
     Active: active (running) since Wed 2025-05-07 14:25:06 EDT; 1min 11s ago
   Main PID: 584247 (uv)
      Tasks: 7 (limit: 38302)
     Memory: 37.6M (peak: 38.8M)
        CPU: 980ms
     CGroup: /system.slice/uvtest4.service
             ├─584247 uv run uvtest4.py
             └─584296 /home/brent/.cache/uv/environments-v2/uvtest4-3f63cba31aee9b39/bin/python uvtest4.py

May 07 14:25:06 research21 systemd[1]: Started uvtest4.service - Run test4 Python script with uv.
May 07 14:25:06 research21 env[584247]: Installed 7 packages in 7ms
May 07 14:25:07 research21 env[584296]:  * Serving Flask app 'uvtest4'
May 07 14:25:07 research21 env[584296]:  * Debug mode: off
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - WARNING: This is a development server. Do not use it in a production deployment. Use a production WSG>
May 07 14:25:07 research21 env[584296]:  * Running on all addresses (0.0.0.0)
May 07 14:25:07 research21 env[584296]:  * Running on http://127.0.0.1:8080
May 07 14:25:07 research21 env[584296]:  * Running on http://10.187.40.123:8080
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - Press CTRL+C to quit

# test it
curl http://localhost:8080
Hello from Flask!
# stop service
sudo systemctl stop uvtest4
# journal check
journalctl -u uvtest4.service -f

May 07 14:25:06 research21 env[584247]: Installed 7 packages in 7ms
May 07 14:25:07 research21 env[584296]:  * Serving Flask app 'uvtest4'
May 07 14:25:07 research21 env[584296]:  * Debug mode: off
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
May 07 14:25:07 research21 env[584296]:  * Running on all addresses (0.0.0.0)
May 07 14:25:07 research21 env[584296]:  * Running on http://127.0.0.1:8080
May 07 14:25:07 research21 env[584296]:  * Running on http://10.187.40.123:8080
May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - Press CTRL+C to quit
May 07 14:26:48 research21 env[584296]: 2025-05-07 14:26:48,916 - INFO - 127.0.0.1 - - [07/May/2025 14:26:48] "GET / HTTP/1.1" 200 -
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,020 - INFO - Received SIGTERM, shutting down gracefully...
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - INFO - Cleanup complete, exiting.
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - WARNING - This is a warning message.
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - CRITICAL - This is a critical error
May 07 14:27:12 research21 systemd[1]: Stopping uvtest4.service - Run test4 Python script with uv...
May 07 14:27:12 research21 systemd[1]: uvtest4.service: Deactivated successfully.
May 07 14:27:12 research21 systemd[1]: Stopped uvtest4.service - Run test4 Python script with uv.
May 07 14:27:12 research21 systemd[1]: uvtest4.service: Consumed 1.059s CPU time, 38.8M memory peak, 0B memory swap peak.

# check status for any error
sudo systemctl status uvtest4

○ uvtest4.service - Run test4 Python script with uv
     Loaded: loaded (/etc/systemd/system/uvtest4.service; disabled; preset: enabled)
     Active: inactive (dead)

May 07 14:25:07 research21 env[584296]: 2025-05-07 14:25:07,667 - INFO - Press CTRL+C to quit
May 07 14:26:48 research21 env[584296]: 2025-05-07 14:26:48,916 - INFO - 127.0.0.1 - - [07/May/2025 14:26:48] "GET / HTTP/1.1" 200 -
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,020 - INFO - Received SIGTERM, shutting down gracefully...
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - INFO - Cleanup complete, exiting.
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - WARNING - This is a warning message.
May 07 14:27:12 research21 env[584296]: 2025-05-07 14:27:12,021 - CRITICAL - This is a critical error
May 07 14:27:12 research21 systemd[1]: Stopping uvtest4.service - Run test4 Python script with uv...
May 07 14:27:12 research21 systemd[1]: uvtest4.service: Deactivated successfully.
May 07 14:27:12 research21 systemd[1]: Stopped uvtest4.service - Run test4 Python script with uv.
May 07 14:27:12 research21 systemd[1]: uvtest4.service: Consumed 1.059s CPU time, 38.8M memory peak, 0B memory swap peak

```

## temporary environments

Where does flask get installed?

```bash
# Environment=PATH=/home/brent/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# WorkingDirectory=/etc/mytests/test2

ls $HOME/.cache/uv/environments-v2

server-3827603ed46bafa8  socketthing-7d6b171392dc7764  uvtest2-919d75032003516f  uvtest3-97bb5e48ccb151ae  uvtest4-3f63cba31aee9b39

# answer: it created the environment the user of the service unit's local cache. it first created a directory and the installed all the dependancies in it.
ls $HOME/.cache/uv/environments-v2/uvtest4-3f63cba31aee9b39 

bin  CACHEDIR.TAG  lib  lib64  pyvenv.cfg

# check support files and dependancies
ls $HOME/.cache/uv/environments-v2/uvtest4-3f63cba31aee9b39/bin

activate  activate.bat  activate.csh  activate.fish  activate.nu  activate.ps1  activate_this.py  deactivate.bat  flask  pydoc.bat  python  python3  python3.13

# didn't put anything in scripts working directory.
ls -ahl /etc/mytests/test4

total 12K
drwxrwxr-x 2 brent brent 4.0K May  7 14:24 .
drwxrwxrwx 5 root  root  4.0K May  7 14:17 ..
-rwxrwxr-x 1 brent brent  840 May  7 14:24 uvtest4.py
```

## By Unit

To see messages logged by any systemd unit, use the -u switch. The command below will show all messages logged by the Nginx web server. You can use the --since and --until switches here to pinpoint web server errors occurring within a time window.

```bash
journalctl -u uvtest4.service
# or
journalctl -u uvtest4.service -f
```
