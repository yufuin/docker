#!/usr/bin/expect
set timeout 10
spawn expressvpn activate
set ACTIVATION_CODE [exec cat /secrets/activation_code]
expect {
	"Already activated. Logout from your account (y/N)?" {
		send "N\r"
	}
	"Enter activation code:" {
		send "${ACTIVATION_CODE}\r"
	}
	"Help improve ExpressVPN: Share crash reports, speed tests, usability diagnostics, and whether VPN connection attempts succeed. These reports never contain personally identifiable information. (Y/n)" {
		send "n\r"
	}
}
expect eof
