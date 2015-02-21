#!/bin/sh 

# Script to enroll a computer to munki as part of a DeployStudio workflow.
# Author  : contact@richard-purves.com
# Version : 1.0 - Initial Version (based on https://github.com/flammable/munki-enroll)

SUBMITURL="http://munki/repo/munki-enroll/enroll.php"

/usr/bin/curl --max-time 5 --silent --get -d hostname=$DS_HOSTNAME $SUBMITURL

exit 0
