#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
# ]
# ///

# Requires PySerial

# (c) www.xanthium.in 2021
# Rahul.S

import socket 

if __name__ == "__main__":


  HOST = '10.188.74.11'  # The server's hostname or IP address
  PORT = 4065        # The port used by the server

  try:
      with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
          client_socket.connect((HOST, PORT))
          print(f"Connected to {HOST}:{PORT}")

          # message = "Hello, server!"
          # client_socket.sendall(message.encode('utf-8'))
          # print(f"Sent: {message}")

          data = client_socket.recv(1024)
          # print(f"Received from server: {data.decode('utf-8')}")
          print(f"Received from server: {data}")

  except ConnectionRefusedError:
      print(f"Connection refused. Ensure the server is running on {HOST}:{PORT}.")
  except Exception as e:
      print(f"An error occurred: {e}")