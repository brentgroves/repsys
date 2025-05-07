#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "flask",
# ]
# ///
import signal
import sys
import logging
from flask import Flask
app = Flask(__name__)

def handle_sigterm(signum, frame):
    logging.info("Received SIGTERM, shutting down gracefully...")
    # Perform cleanup tasks here (e.g., closing files, releasing resources)
    logging.info("Cleanup complete, exiting.")
    sys.exit(0)

signal.signal(signal.SIGTERM, handle_sigterm)

@app.route('/')
def hello_world():
    return 'Hello from Flask!\n'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
