#!/bin/sh

while :
do
    /mnt/config/aria2/tracker.sh RPC localhost:${RPC_PORT} ${PASSWORD}
    sleep 24h
done