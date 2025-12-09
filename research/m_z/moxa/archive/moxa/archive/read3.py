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


  try:
    host = '10.188.74.11' # The server's hostname or IP address
    port = 4065 # The port used by the server
    backlog = 5 
    size = 1024 
      # with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
      #     client_socket.connect((HOST, PORT))
      #     print(f"Connected to {HOST}:{PORT}")

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
    s.bind((host,port)) 
    s.listen(backlog) 
    while 1: 
        client, address = s.accept() 
        data = client.recv(size) 
        if data: 
            print(data)
        client.close()

  except ConnectionRefusedError:
      print(f"Connection refused. Ensure the server is running on {HOST}:{PORT}.")
  except Exception as e:
      print(f"An error occurred: {e}")

      # An error occurred: [Errno 99] Cannot assign requested address