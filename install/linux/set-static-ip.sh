#!/usr/bin/env bash
# Set static IP
DEV=eth0

echo "----------------"
echo "Network settings"
echo "----------------"
echo    "Device         | $DEV"
echo -n "Format N.N.N.N | IP? "
read IP
echo -n "Default 24     | Mask? "
read MASK
if [ -z $MASK ];
then
  MASK=24
fi

echo "----------------"

ip addr add $IP/$MASK dev $DEV
ip route delete default
ip route add default via $IP dev $DEV

