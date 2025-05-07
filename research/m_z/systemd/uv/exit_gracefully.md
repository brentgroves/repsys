# AI Overview: how to exit python gracefully from systemd service

To exit a Python program gracefully when it's running as a systemd service, it's important to handle signals correctly and ensure proper cleanup. Systemd sends SIGTERM by default when stopping a service. Here's how to handle it in Python:

Signal Handling: Use the signal module to register a handler for SIGTERM. This allows you to execute cleanup code before exiting.

```python
import signal
import sys
import logging

def handle_sigterm(signum, frame):
    logging.info("Received SIGTERM, shutting down gracefully...")
    # Perform cleanup tasks here (e.g., closing files, releasing resources)
    logging.info("Cleanup complete, exiting.")
    sys.exit(0)

signal.signal(signal.SIGTERM, handle_sigterm)
```

- **Systemd Service Configuration:** Ensure your systemd service file is configured correctly. The default KillMode=control-group and KillSignal=SIGTERM are usually sufficient. You can adjust TimeoutStopSec if your cleanup process takes longer than the default 90 seconds.
Code

```bash
[Unit]
Description=My Python Service
After=network.target

[Service]
WorkingDirectory=/path/to/your/app
ExecStart=/path/to/your/python /path/to/your/app/main.py
User=your_user
Group=your_group
KillMode=control-group
KillSignal=SIGTERM
TimeoutStopSec=300

[Install]
WantedBy=multi-user.target
```

## Logging

Use a logging library to record events, especially during startup and shutdown. This helps with debugging and monitoring.

## Error Handling

Implement appropriate error handling to prevent unexpected crashes. Use try-except blocks to catch exceptions and log errors.

## Testing

Test your service thoroughly, including starting, stopping, and restarting it. Use systemctl commands to manage the service and check its status.

By implementing these steps, your Python service will be able to shut down gracefully when stopped by systemd, preventing data loss or corruption and ensuring a clean exit.
