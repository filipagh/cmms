#!/bin/bash

# Set the port
PORT=22222


# switch directories
cd ../build/web/ || exit



# Start the server
echo 'Server starting on port' $PORT '...'
python3 server.py
