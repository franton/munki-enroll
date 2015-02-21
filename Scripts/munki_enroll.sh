#!/bin/sh 

# Script to enroll a computer to munki as part of a DeployStudio workflow.
# Author  : contact@richard-purves.com
# Version : 21-02-2015 : 1.0 - Initial Version (based on https://github.com/flammable/munki-enroll)
#         : This version has been modified to pass a custom catalog and manifest name to the php script.
#         : Easier to mod this script than the php script after the fact.

SUBMITURL="http://munki/repo/munki-enroll/enroll.php"
CATALOG="production"
MANIFEST="All Computers"

/usr/bin/curl --max-time 5 --silent --get -d hostname=$DS_HOSTNAME catalog=$CATALOG manifest=$MANIFEST $SUBMITURL

exit 0
