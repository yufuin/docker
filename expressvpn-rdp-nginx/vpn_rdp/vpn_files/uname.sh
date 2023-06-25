#!/usr/bin/bash

kv=$(uname -r | awk -F '.' '{
        if ($1 < 4) { print 1; }
        else if ($1 == 4) {
            if ($2 <= 9) { print 1; }
            else { print 0; }
        }
        else { print 0; }
    }')

NETWORK=`cat /vpn_settings/network`
if [[ $NETWORK = "off" ]];
then
	expressvpn preferences set network_lock off
else
	if [[ $kv = 0 ]];
	then
		expressvpn preferences set network_lock on
	else
		echo "Kernel Version is lower than minimum version of required kernel (4.9), network_lock will be disabled."
		expressvpn preferences set network_lock off
	fi
fi