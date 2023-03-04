#!/bin/sh
pwd
cd /backend
echo $BE_PORT
uvicorn base.main:app --proxy-headers --host 0.0.0.0 --port $BE_PORT --root-path $BE_PATH
