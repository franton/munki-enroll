#!/bin/sh 
 
HOSTN=$( scutil --get LocalHostName );

SUBMITURL="http://munki/repo/munki-enroll/enroll.php"

# Application paths
CURL="/usr/bin/curl"

$CURL --max-time 5 --silent --get -d hostname="$HOSTN" "$SUBMITURL"

exit 0