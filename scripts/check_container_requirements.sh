#!/bin/bash
PROJ_FOLDER=$(dirname $(readlink -f $0))
PROJ_FOLDER=$(dirname $PROJ_FOLDER)

echo "Checking Requirements"

if [ ! -f .env ]; then
    echo "No .env File detected. Copying default."
    cp .env.sample .env
fi

if [ ! -f ./cert/server.crt ]; then
    echo "No Certificate found. Please generate one using 'make cert'"
    exit 1
fi

echo "Requrements check sucessfull"
