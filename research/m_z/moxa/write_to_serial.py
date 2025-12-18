#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pyserial"
# ]
# ///

# Requires PySerial

# (c) www.xanthium.in 2021
# Rahul.S
# sudo usermod -a -G dialout $USER
import serial
import time

if __name__ == "__main__":

  try:
      # Open the serial port
      # Replace 'COM3' with your actual port name
      # Adjust baud rate if necessary
      # ser = serial.Serial('COM3', 9600, timeout=1) 
      ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)      
      print(f"Serial port {ser.name} opened successfully.")

      # Write a byte string
      ser.write(b'1\r\n') # Sending '1' followed by carriage return and newline
      print("Sent: '1\\r\\n'")

      time.sleep(0.1) # Give some time for the data to be sent

      # Write a regular string, encoded to bytes
      message = "Python serial communication.\r\n"
      ser.write(message.encode('utf-8'))
      print(f"Sent: '{message.strip()}'")

  except serial.SerialException as e:
      print(f"Error opening or communicating with serial port: {e}")

  finally:
      if 'ser' in locals() and ser.is_open:
          ser.close()
          print("Serial port closed.")



