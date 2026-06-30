#!/bin/sh

SWACT=$(/bin/nv getenv sw_active | awk -F'=' '{print $2}')
FWVER=$(awk -F" " '{print $1}' /etc/version)

if [ "$SWACT" == "0" ]; then
	SWVER0=$(/bin/nv getenv sw_version0 | awk -F'=' '{print $2}')
	if [ "$SWVER0" != "$FWVER" ]; then
		/bin/nv setenv sw_version0 $FWVER
		echo "sw_version0 is not the same, set to " $FWVER
	fi
elif [ "$SWACT" == "1" ]; then
	SWVER1=$(/bin/nv getenv sw_version1 | awk -F'=' '{print $2}')
	if [ "$SWVER1" != "$FWVER" ]; then
		/bin/nv setenv sw_version1 $FWVER
		echo "sw_version1 is not the same, set to " $FWVER
	fi
fi

