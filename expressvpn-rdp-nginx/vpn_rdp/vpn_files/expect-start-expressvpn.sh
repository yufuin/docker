#!/usr/bin/expect
set timeout 600
spawn /etc/init.d/expressvpn start
expect eof
