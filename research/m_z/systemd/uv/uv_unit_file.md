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

```python
#!/usr/bin/env -S uv run --script
# https://docs.astral.sh/uv/guides/scripts/#using-a-shebang-to-create-an-executable-file
# https://stackoverflow.com/questions/37211115/how-to-enable-a-virtualenv-in-a-systemd-service-unit

print("Hello, world!")
```
