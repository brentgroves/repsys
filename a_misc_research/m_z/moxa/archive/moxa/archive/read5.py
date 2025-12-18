#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pyserial",
# ]
# ///

# Requires PySerial

# (c) www.xanthium.in 2021
# Rahul.S

import serial

if __name__ == "__main__":


  HOST = '10.188.74.11'  # The server's hostname or IP address
  PORT = 4065        # The port used by the server

  try:
    ser = serial.serial_for_url("tcp://10.188.74.11:4066/logging=debug")
    data = ser.read(8)
    if data:
        print(data)
        ser.flushOutput()
    ser.close()
  except ConnectionRefusedError:
      print(f"Connection refused. Ensure the server is running on {HOST}:{PORT}.")
  except Exception as e:
      print(f"An error occurred: {e}")