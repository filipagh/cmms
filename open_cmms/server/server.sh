#!/bin/bash

# Set the port
PORT=22222


# switch directories
cd ../build/web/ || exit
rm assets/.env
echo BACKEND_URI=$BACKEND_URI > assets/.env


# Start the server
echo 'Server starting on port' $PORT '...'
python3 server.py
